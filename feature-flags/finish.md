Well done on completing the tutorial! In this section we will reflect on the functionality of feature flags, where they fit into DevOps, and when they should be used.

## Summary
In this tutorial, you completed these tasks:
1. Add a boolean flag and change its default variant to turn a feature on and off without redeploying.
2. Configure a targeting rule using the evaluation context to release a feature to a subset of users.
3. Use multiple variants with weights to distribute them randomly among users for an experiment or gradual release.

## DevOps relevance

In continuous delivery, code should be deployed often to reduce risk and iterate on feedback. Feature flags make this possible even when features are not completely finished: the code can be merged into the main branch and deployed behind a flag that is initially off.

Furthermore, if a released feature causes issues, feature flags allow rapid rollback without a new deployment, acting as a kill switch.

Lastly, targeting and percentage-based rollouts allow developers to expose a feature to a small group first to measure its performance before releasing it to everyone. This allows for early feedback with lower risk.

## Design decisions

### Tools
OpenFeature is an open standard for feature flags because it places the flag provider behind an abstraction layer so that the application only interfaces with a consistent API. This allows providers to be easily changed without modifying the code in many places.

The flagd provider was chosen because it is free, open source software that can be easily run through a Docker container. Its flag definitions are JSON files, which are familiar to most and can be integrated into any source control.

### Architecture
Using flagd as a central service for accessing flags is preferable to making each app read a config file itself, as this would require additional separate logic and may cause synchronization issues. In case the application cannot connect to flagd, the SDK returns a safe default, usually to turn off the feature.

The architecture is simplified in this tutorial compared to a real application. In practice, the flag configurations would be updated in a pull request and synchronized to flagd from Git or through orchestration software. The application would also have more complex logic for constructing an evaluation context based on user identity, and would collect metrics for A/B testing.

### Alternatives

Both feature flags and canary deployments reduce the risk of a release, but they work at different levels and are often used together because they complement each other.

| Feature flags | Canary deployment |
|--|--|
| inside application code | infrastructure and traffic routing |
| changes individual features within one version | changes entire versions |
| users selected by rules | percentage of user traffic selected |
| release by changing a flag | release by routing traffic to the other version |
| requires flag checks in code and a flag service | requires multiple running versions and a traffic router |


## Usefulness

Feature flags are useful for:
- Larger teams practising continuous delivery with frequent deployments.
- Granular testing of features on real users before a full release.
- Safe releases with the option to roll back individual features.

They are less useful for:
- Small applications with fewer users or rare releases that do not need the additional complexity.
- Teams that cannot keep up with removing old flags (flag debt) or with testing the growing number of combinations.
- Changes that cannot be handled through simple code branches, such as database migration.   

## Further reading
- [OpenFeature documentation](https://openfeature.dev/docs/reference/intro)
- [flagd documentation](https://flagd.dev/)