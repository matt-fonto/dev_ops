# Github Actions

1. Create the .github/workflows/<filename>.cy
2. Decide the config

- Name

### Characteristics

#### Event-driven workflows

- Triggered by events such as: `pull`, `pull_request`, `schedule`, or custom defined events
- Enables CI/CD, automated testing, and deployment based on repo activity

#### Modular and reusable

- Workflows have jobs, which contain steps
- Steps: pre-built actions or custom ones
- Encourages reusability with marketplace actions and reusable workflows

#### Parallel and Sequential Execution

- Jobs within a workflow can run in parallel (default) or sequentially by defining deps (`needs`)
- Optimizes performance and reduces build time

#### Containerized and Corss-Platform execution

- Actions run in isolated Docker Containers or virtual machines (Ubuntu, Windows, macOS)
- Supports multiple environments for testing

#### Secrets and security

- Uses GitHub secrets to store sensitive data (API Keys, credentials)
- Enforces least privilege principle (actions should only have necessary permissions)

#### Composability with Matrix Strategy

- Allows defining a matrix to run worfklows across different environments, OSs, and deps
- Useful for testing compatibility (e.g.: different node.js versions)

#### Idempotency and caching

- Caching dependencies (e.g., actions/cache) speeds up workflow executions
- Ensures that workflows are idempotent, meaning they produce the same result given the same input

#### Observability and Logging

- Provides real-time logs for debugging
- Supports artifacts to store and retrieve workflow results
- Integrates with monitoring tools like `Datadog` and `Prometheus`

#### Branch and Environment protection

- Can enforce checks before merging (`required status checks`)
- Supports environments for staging and production, restricting who can deploy

#### Infrastructure as Code (IaC)

- Workflows are defined using YAML, enabling version control and reproducibility
- Supports self-hosted runners for custom build environments
