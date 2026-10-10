Your team has finished a new feature for your app. The code is merged, tested and can be deployed to production, but the product owner is not ready to show it to users yet. They want to try it with internal employees first, and later they want to run an A/B test to decide between two versions.

If the only way to change what users see is to build and deploy a new version, every one of these decisions means another release. And if the feature breaks something, turning it off means yet another deployment to roll back.

Feature flags solve this by separating these processes:
- *Deployment*: running new code on the servers.
- *Release*: letting users actually see that code.

With a feature flag, the new code is deployed but remains hidden behind a condition that is evaluated at runtime. Changing the flag changes the behaviour of the running application, without rebuilding or redeploying anything.

## Learning outcomes
After completing this tutorial, you should be able to:
1. Explain how feature flags decouple deployment from release, and why this is useful for DevOps.
2. Describe how the application, the OpenFeature SDK and the flagd provider interact.
3. Turn a feature on and off at runtime by changing a flag definition, without redeploying the application.
4. Write a targeting rule that shows a feature only to a specific group of users, based on the evaluation context.
5. Configure a flag with multiple variants and a percentage-based rollout for A/B testing.

## Tools

**OpenFeature** is an open, vendor-neutral standard for feature flagging, hosted by the Cloud Native Computing Foundation (CNCF). It defines one API that applications use to query flags. The actual flag data comes from a provider, which can be changed without modifying the application.

**flagd** is an open-source flag evaluation engine from the OpenFeature project. It reads flag definitions from a JSON file, watches that file for changes, and answers flag evaluation requests from applications. It needs no account and no external service, which is useful for learning and for keeping the flag configuration in Git.

## Architecture

Here is an overview of the interacting components:

![Architecture](https://raw.githubusercontent.com/eryngia/dd2482-tutorial/main/feature-flags/assets/architecture.png)

- The user, through `curl` or the browser, sends a request to the Python web app.
- When the app reaches a new feature in the code, it queries the flag value through the OpenFeature SDK API. It may pass an evaluation context with information about the current request.
- The flagd provider passes the query to flagd.
- In a Docker container, flagd evaluates the flag using the rules in `flags.json` and returns the value.
- When you edit `flags.json`, flagd sees the change and uses the new rules for subsequent requests. The app itself is never restarted.

## Plan
In this tutorial, you will:
1. Start the app and see that the new feature is deployed but switched off.
2. Turn the feature on by editing the flag definition, without redeploying.
3. Create a boolean flag yourself for a new feature.
4. Add a targeting rule so that only internal users see the feature.
5. Turn the flag into an A/B test with a percentage-based rollout.
6. Reflect on when feature flags are worth using, and how they compare to other release strategies such as canary deployments.