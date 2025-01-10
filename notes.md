# DevOps

- Methodology to build products by continuously getting user feedback

  > Sequence: Plan -> code -> build -> test -> release -> deploy -> operate -> monitor

- DevOps Engineering: being able to build, test, release and monitor applications
- 3 pillars:
  - 1. PR automation: understand if proposed changes are good faster
  - 2. Deployment automation: deploy code in a way users don't complain
  - 3. Application performance management: automation to check if things are healthy

## PR Automation

- Developer feedback cycle
- Gates to identify if changes are suitable
- Automatic and manual feedbacks for changes
  - Automation in PR
  - Code review: another dev informs about code style, architecture, and observations
- What can we automate?
  - Continuous integration (CI)
  - Automated security scanning
- Goal as DevOps: proposals should get reviewd and merged within 24 hours of when they are made

## Deployment automation

- Deploy feature to certain set of users as a final test before rolling out publically
- Starting new versoin of services without down time
- Rolling back to prior version in case something goes wrong

## Application Performance Management

- Metrics: numering measurements of key numbers in production
- Logging: text descriptions of what's happening during processing
- Monitoring: take metrics and logs to convert them into health metrics
- Alerting: if there's a problem, notify responsible parties

## Different scenarios and different DevOps needs

- New startup with no users: Github, Vercel, LayerCI
- 10 enterprise customers: Github, Sentry, PagerDuty, CodeCov, Bitrise/CircleCI
