import xmlrpclib


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
    def processes(self):
        return self._server.supervisor.getAllProcessInfo()

