Release the dark mode feature by changing the flag in `flags.json`, without restarting or redeploying the app. You only need to change the `defaultVariant` of the feature from `off` to `on`. The change will be detected by flagd, and `client.get_boolean_value` will now return `True` for the feature.

Check the endpoint again after a moment:
```bash
curl localhost:8080
```{{exec}}

The same running process should now show dark mode as enabled. We have separated the deployment of the code from the release of the feature.

## Help
If you get stuck, solution files are available in the `~/demo/solutions` folder.