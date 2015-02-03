from flask import (
    Flask,
    send_from_directory,
    jsonify,
    request
)
import os
import operator
import json

dist_folder = os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir, 'public'))
static_folder = os.path.join(dist_folder, 'static')

app = Flask(__name__, static_url_path='/static', static_folder=static_folder)
import gravity.supervisor
app.client = gravity.supervisor.get_client()

as_dict = operator.methodcaller("as_dict")


# from gravity import views
@app.route('/', methods=["GET"])
def index():
    return send_from_directory(dist_folder, 'index.html')


@app.route('/api/services', methods=["GET"])
def processes():
    processes = app.client.processes
    return json.dumps(map(as_dict, processes))


@app.route('/api/services/<name>', methods=["GET"])
def process(name):
    process = _find_process(name)
    return jsonify(process.as_dict())


@app.route('/api/services/<name>/stdout', methods=["GET"])
def stdout(name):
    return _get_log(name, 'stdout')


@app.route('/api/services/<name>/stderr', methods=["GET"])
def stderr(name):
    return _get_log(name, 'stderr')


@app.route('/api/services/<name>', methods=["PUT"])
def update_state(name):
    process = _find_process(name)
    request_json = request.get_json(force=True)
    print request_json
    new_state = request_json["state"]
    if new_state == "start":
        process.start()
    elif new_state == "stop":
        process.stop()


def _get_log(name, log_type):
    process = _find_process(name)
    log = getattr(process, log_type)
    return log


def _find_process(name):
    return app.client.find_process(name)


if __name__ == '__main__':
    app.run(debug=True)
