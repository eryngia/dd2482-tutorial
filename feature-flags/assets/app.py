from flask import Flask
from openfeature import api
from openfeature.contrib.provider.flagd import FlagdProvider

api.set_provider(FlagdProvider(host="localhost", port=8013))
client = api.get_client()
app = Flask(__name__)

@app.route("/")
def index():
    if client.get_boolean_value("new-feature", False):
        return "Hello World! (new feature is ON)\n"
    return "Hello World! (new feature is OFF)\n"

app.run(host="0.0.0.0", port=8080)