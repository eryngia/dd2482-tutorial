Open the **Editor** tab above and have a look at the `/demo` directory. It contains a simple Python app in `app.py` with a single endpoint. The dependencies are already installed.

The app contains a new dark mode feature, but it is hidden behind a flag called `dark-mode`. As you can see in `flags.json`, the `defaultVariant` for this flag is `off`, so the feature exists in the code but is not yet released. The app asks flagd for this flag through the OpenFeature SDK on every request.

Navigate to the `/demo` directory in the terminal:
```bash
cd ~/demo
```

Start the app in the background:
```bash
python3 app.py > app.log 2>&1 &
```

Send a request:
```bash
curl localhost:8080
```

You should see that there are no features currently enabled. 