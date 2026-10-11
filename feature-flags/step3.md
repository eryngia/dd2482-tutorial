Let's add another simple feature flag for a new dashboard feature. Add a new element to the `flags` dictionary in `flags.json`. Here is what a flag should look like:

```json
"<flag-name>": {
    "state": "ENABLED",
    "variants": {
        "on": true,
        "off": false
    },
    "defaultVariant": "off"
}
```

The current value of the flag can be checked in `app.py` using:
```python
client.get_boolean_value("<flag-name>", False)
```
The first parameter is the name of the flag, and the second is a default value in case the flag cannot be read. 

Modify the application with a `dashboard` feature that can be turned on and off with a flag. If it is turned on, append `"dashboard"` to the `enabled` list. Then, since the application code was changed, restart the application:
```bash
pkill -f '[p]ython.*app.py' || true
python3 app.py > app.log 2>&1 &
```{{exec}}

Observe how the behaviour of the application changes just by editing the `flags.json` file:
```bash
curl localhost:8080
```{{exec}}

When you are done, leave the feature on.

## Help
If you get stuck, solution files are available in the `~/demo/solutions` folder. Remember to restart the app.