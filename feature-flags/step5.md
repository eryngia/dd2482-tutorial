Boolean flags are on or off. For experiments such as A/B tests, you need more than two variants, and you want to split users between them. A good split must be consistent: the same user should always get the same variant.

Add a new flag called `layout` to `flags.json`. Variants can hold any value, not just booleans. Here is an example with string variants:
```json
"<flag-name>": {
    "state": "ENABLED",
    "variants": {
        "<variant-1>": "<string-1>",
        "<variant-2>": "<string-2>",
        "<variant-3>": "<string-3>"
    },
    "defaultVariant": "<variant-1>"
}
```
The layout has three variants `classic`, `compact` and `split`, with `classic` as the default. Their values are strings that are the same as their names, for example `"classic": "classic"`.

Now modify `app.py` to integrate the new feature by appending the layout value to the `enabled` list. For string flags, use `get_string_value` to retrieve their value:
```python
layout = client.get_string_value("layout", "classic", context)
```

Restart the app once more:
```bash
pkill -f '[p]ython.*app.py' || true
python3 app.py > app.log 2>&1 &
```{{exec}}

Send requests from ten different users and count the layouts:

```bash
for i in $(seq 1 10); do curl -s "localhost:8080?email=user$i@gmail.com"; done
```{{exec}}

Everyone has `classic`, because that is the default variant. We will add the `fractional` operator to distribute users across variants. Add it as a `targeting` rule to the `layout` flag. To distribute variants equally, the weights should be the same:
```json
"targeting": {
    "fractional": [
        ["<variant-1>", <weight-1>],
        ["<variant-2>", <weight-2>],
        ["<variant-3>", <weight-3>]
    ]
}
```

Run the 10 requests again. Since only the flag configuration was changed, no restarts are needed. You should usually see a mix of the three layouts. This functionality could be used to gradually increase the number of users who can access a new feature, or to test different versions of a feature.

The targeting key (the email in this case) is hashed by flagd to pick a bucket. Therefore, the same user will receive the same variant every time:
```bash
for i in $(seq 1 5); do curl -s "localhost:8080?email=alice@gmail.com"; done
```{{exec}}

## Help
If you get stuck, solution files are available in the `~/demo/solutions` folder. Remember to restart the app.