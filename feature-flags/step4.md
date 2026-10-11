So far every user sees the same thing. In practice, you often want to release a feature to a specific group first. For example, we might want employees to try it in production before customers, which is called *dogfooding*.

For this, flagd needs to know the sender of the request. The app sends an evaluation context along with each flag check: a targeting key (a unique user ID) and additional attributes you define. Targeting rules can then be applied by flagd using these attributes.

The app has no login system, so we will instead include a user email from a query parameter, e.g. `localhost:8080?email=alice@company.com`. In `app.py`, build the context from the request at the start of `index()`:
```python
email = request.args.get("email", "")
context = EvaluationContext(targeting_key=email, attributes={"email": email})
```

You can pass the context as a third parameter to the `dashboard` flag check:
```python
client.get_boolean_value("dashboard", False, context)
```

A flag can have a `targeting` property. It contains a rule that returns the name of the variant to use. The rule structure looks like this:
```json
"targeting": {
    "if": [
        { "ends_with": [{ "var": "<attribute>" }, "<suffix>"] },
        "<variant if condition is true>",
        "<variant if condition is false>"
    ]
}
```

Edit the `dashboard` flag in `flags.json` so that only users whose `email` ends with `@company.com` get the `on` variant, and everyone else gets `off`. Keep `defaultVariant` as `off`: it is what flagd falls back to when no rule applies.

Since the application was changed, restart it again:
```bash
pkill -f '[p]ython.*app.py' || true
python3 app.py > app.log 2>&1 &
```{{exec}}

Now request the page as an internal and an external user:
```bash
curl "localhost:8080?email=alice@company.com"
```{{exec}}
```bash
curl "localhost:8080?email=bob@gmail.com"
```{{exec}}

Alice should see the `dashboard` feature and Bob should not. The code is identical for both. Only the context differs, and the decision happens in flagd.

## Help
If you get stuck, solution files are available in the `~/demo/solutions` folder. Remember to restart the app.