from flask import Flask, request
from openfeature import api
from openfeature.contrib.provider.flagd import FlagdProvider
from openfeature.evaluation_context import EvaluationContext

# Configure flagd as the provider for evaluating feature flags
api.set_provider(FlagdProvider(host="localhost", port=8013))
# Create a client for evaluating feature flags through the configured provider
client = api.get_client()

# Create the Flask application
app = Flask(__name__)

@app.route("/")
def index():
    # Build context from email parameter
    email = request.args.get("email", "")
    context = EvaluationContext(targeting_key=email, attributes={"email": email})

    enabled = []

    # Enable 'dark-mode' feature depending on flag
    if client.get_boolean_value("dark-mode", False):
        enabled.append("dark-mode")

    # Enable 'dashboard' feature depending on flag and context
    if client.get_boolean_value("dashboard", False, context):
        enabled.append("dashboard")

    # Change 'layout' feature depending on flag and context
    layout = client.get_string_value("layout", "classic", context)
    enabled.append(layout)

    # Display enabled features
    return "App is running\nEnabled features: " + (", ".join(enabled) if enabled else "none") + "\n"

# Run app
app.run(host="0.0.0.0", port=8080)