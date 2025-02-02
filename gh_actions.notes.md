# Github Actions

1. Create the .github/workflows/<filename>.cy
2. Decide the config

## Characteristics

### Event-driven workflows

- Triggered by events such as: `pull`, `pull_request`, `schedule`, or custom defined events
- Enables CI/CD, automated testing, and deployment based on repo activity

### Modular and reusable

- Workflows have jobs, which contain steps
- Steps: pre-built actions or custom ones
- Encourages reusability with marketplace actions and reusable workflows

### Parallel and Sequential Execution

- Jobs within a workflow can run in parallel (default) or sequentially by defining deps (`needs`)
- Optimizes performance and reduces build time

### Containerized and Corss-Platform execution

- Actions run in isolated Docker Containers or virtual machines (Ubuntu, Windows, macOS)
- Supports multiple environments for testing

### Secrets and security

- Uses GitHub secrets to store sensitive data (API Keys, credentials)
- Enforces least privilege principle (actions should only have necessary permissions)

### Composability with Matrix Strategy

- Allows defining a matrix to run worfklows across different environments, OSs, and deps
- Useful for testing compatibility (e.g.: different node.js versions)

### Idempotency and caching

- Caching dependencies (e.g., actions/cache) speeds up workflow executions
- Ensures that workflows are idempotent, meaning they produce the same result given the same input

### Observability and Logging

- Provides real-time logs for debugging
- Supports artifacts to store and retrieve workflow results
- Integrates with monitoring tools like `Datadog` and `Prometheus`

### Branch and Environment protection

- Can enforce checks before merging (`required status checks`)
- Supports environments for staging and production, restricting who can deploy

### Infrastructure as Code (IaC)

- Workflows are defined using YAML, enabling version control and reproducibility
- Supports self-hosted runners for custom build environments

## Syntax

- [1. Name](#workflow-name)
- [2. Events / Triggers](#events)
- [3. Jobs](#jobs)
- [4. Steps](#steps)
- [5. Environment variables](#env-variables)
- [6. Matrix strategy](#matrix-strategy)
- [7. Job dependencies](#job-dependencies)
- [8. Artifacts](#artifacts)

<a id="workflow-name"></a>

### 1. Define worfklow name

- (optional) sets a name for the workflow
- Default is the file name if ommitted

```yml
name: CI/CD Pipeline
```

<a id="events"></a>

### 2. Specify Events (triggers)

- Supports triggers:
  - push
  - pull_request
  - schedule
  - worfklow_dispatch

```yml
on:
  push:
    branches:
      - main
      - develop
  pull_request:
    branches:
      - main
  schedule:
    - cron: "0 12 ** 1" # runs every Monday at 12:00 UTC
```

<a id="jobs"></a>

### 3. Define jobs

- jobs: collection of jobs executed in parallel by default
- runs-on: defines the OS (ubuntu-latest, macos-latest, windows-latest)
- steps: tasks executed inside the job

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
      - uses: actions/checkout@v4
```

<a id="steps"></a>

### 4. Steps: running commands and actions

- uses: calls pre-built gh actions
- run: executes shell commands
- with: provides input paramters to actions

```yaml
steps:
  - name: Checkout repository
    uses: actions/checkout@v4

  - name: install node.js
    uses: actions/setup-node@v4
    with:
      node-version: 18

  - name: install dependencies
    run: install

  - name: run tests
    run: npm test
```

<a id="env-variables"></a>

### 5. Environment variables

- global `env` applies to the whole job
- ${{ secrets.* }} references GitHub secrets for secure credentials

```yaml
env:
  NODE_ENV: production
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
```

<a id="matrix-strategy"></a>

### 6. Matrix strategy (parallel testing)

- runs the same job multiple times with different configurations

```yaml
strategy:
  matrix:
    node: [16, 18, 20]
```

<a id="job-dependencies"></a>

### 7. Job Dependencies

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      run: echo "Building..."

  deploy:
    runs-on: ubuntu-latest
    needs: build # wait for the 'built' to complete
    steps:
      - run: echo "Deploying..."
```

<a id="artifacts"></a>

### 8. Artifacts

- Stores artifacts from a job for later use

```yaml
steps:
  - name: Upload test results
  uses: actions/upload-artifact@v4
  with:
    name: test-results
    path: ./results
```
