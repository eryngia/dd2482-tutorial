from flask import Flask
from openfeature import api
from openfeature.contrib.provider.flagd import FlagdProvider

# Configure flagd as the provider for evaluating feature flags
api.set_provider(FlagdProvider(host="localhost", port=8013))
# Create a client for evaluating feature flags through the configured provider
client = api.get_client()

# Create the Flask application
app = Flask(__name__)

@app.route("/")
def index():
    enabled = []

    # Enable 'dark-mode' feature depending on flag
    if client.get_boolean_value("dark-mode"):
        enabled.append("dark-mode")

    # Display enabled features
    return "App is running\nEnabled features: " + (", ".join(enabled) if enabled else "none") + "\n"

# Run app
app.run(host="0.0.0.0", port=8080)