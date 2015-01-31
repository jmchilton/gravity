from flask import Flask, send_from_directory
import os
import json

dist_folder = os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir, 'public'))
static_folder = os.path.join(dist_folder, 'static')

app = Flask(__name__, static_url_path='/static', static_folder=static_folder)
import gravity.supervisor
app.client = gravity.supervisor.get_client()


# from gravity import views
@app.route('/')
def index():
    return send_from_directory(dist_folder, 'index.html')


@app.route('/api/services')
def processes():
    processes = app.client.processes
    print processes
    return json.dumps(processes)


if __name__ == '__main__':
    app.run(debug=True)
