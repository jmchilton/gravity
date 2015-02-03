import xmlrpclib
import operator


def get_client(url='http://localhost:9001/'):
    if not url.endswith("/"):
        url = "%s/" % url
    rpc_url = "%sRPC2" % url
    print rpc_url
    server = xmlrpclib.Server(rpc_url)
    return Client(server)


class Client(object):

    def __init__(self, server):
        self._server = server

    @property
    def supervisor(self):
        return self._server.supervisor

    @property
    def processes(self):
        raw_processes_info = self.supervisor.getAllProcessInfo()
        return map(self._build_process, raw_processes_info)

    def find_process(self, name):
        raw_process_info = lambda: self.supervisor.getProcessInfo(name)
        return self._build_process(raw_process_info, name=name)

    def _build_process(self, process_info, name=None):
        return Process(self, process_info, name=name)


class Process(object):

    def __init__(self, client, process_info, name=None):
        self.client = client
        self._raw_process_info = process_info
        self._name = name

    def as_dict(self):
        return self.raw_process_info

    @property
    def name(self):
        if self._name is None:
            self._name = self.raw_process_info["name"]
        return self._name

    @property
    def raw_process_info(self):
        raw_process_info = self._raw_process_info
        # Allow delayed evaluation...
        if operator.isCallable(raw_process_info):
            raw_process_info = raw_process_info()
        return raw_process_info

    @property
    def stdout(self):
        return self._supervisor.readProcessStdoutLog(self.name, 0, 1024 * 1024)

    @property
    def stderr(self):
        return self._supervisor.readProcessStderrLog(self.name, 0, 1024 * 1024)

    def clear_logs(self):
        self._supervisor.clearProcessLogs(self.name)

    def start(self):
        self._supervisor.startProcessGroup(self.name)

    def stop(self):
        self._supervisor.stopProcessGroup(self.name)

    @property
    def _supervisor(self):
        return self.client.supervisor
