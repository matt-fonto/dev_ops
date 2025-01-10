# DevOps

- Section 1: DevOps Intro
- Section 2: TDD
- Section 3: CI

## Section 1: DevOps Intro

- Methodology to build products by continuously getting user feedback

  > Sequence: Plan -> code -> build -> test -> release -> deploy -> operate -> monitor

- DevOps Engineering: being able to build, test, release and monitor applications
- 3 pillars:
  - 1. PR automation: understand if proposed changes are good faster
  - 2. Deployment automation: deploy code in a way users don't complain
  - 3. Application performance management: automation to check if things are healthy

### PR Automation

- Developer feedback cycle
- Gates to identify if changes are suitable
- Automatic and manual feedbacks for changes
  - Automation in PR
  - Code review: another dev informs about code style, architecture, and observations
- What can we automate?
  - Continuous integration (CI)
  - Automated security scanning
- Goal as DevOps: proposals should get reviewd and merged within 24 hours of when they are made
- DevOps is fundamental, especially as the product matures

### Deployment automation

- Deploy feature to certain set of users as a final test before rolling out publically
- Starting new versoin of services without down time
- Rolling back to prior version in case something goes wrong

### Application Performance Management

- Metrics: numering measurements of key numbers in production
- Logging: text descriptions of what's happening during processing
- Monitoring: take metrics and logs to convert them into health metrics
- Alerting: if there's a problem, notify responsible parties

### Different scenarios and different DevOps needs

- New startup with no users: Github, Vercel, LayerCI
- 10 enterprise customers: Github, Sentry, PagerDuty, CodeCov, Bitrise/CircleCI
- Heavy user-online apps: Github enterprise, sentry, ElasticSearch/Logstash/Kibana, Pingdom, Launch Darkly, Terraform

## Section 2: TDD

- Testing is fundamental for Continuous Integration
- TDD: Test-Driven Development. Tests are written before code. Tests drive the development
- Unit tests
- Integration tests
- System (end to end) tests
- Acceptance tests

### TDD Goals

- To know when something breaks and where
- To know the whole system is working correctly

### Worflows

#### Without TDD

1. Choose something to work on
2. Build it based on specifications
3. Test it with small scripts

### With TDD

1. Choose something to work on
2. Write tests that'd pass if product works
3. Keep building it until tests pass

- Results are the same, however, TDD forces prioritization of tasks

## Section 3: CI

- Continuous Integration: Pushing changes to a central git repo
- Changes are verified by an automatic software that runs comprehensive tess to insure no major issues appear

### Benefits of CI

- First step to DevOps automation and helps with code collaboration
- It provides confidence and speed in making changes because we know previous functionality won't be broken by new ones
- Master branch -> feature 1 branch

### Docker

- 1. Create docker file and build the image `docker build -t [image-name] .
- 2. Create docker-compose.yaml to make it easier running the container

```yml
version: "3.8"

services:
  web:
    image: dev-ops-nextjs
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    container_name: container-dev-ops-nextjs
    volumes:
      - .:/app # Mount current directory to /app in the container
      - /app/node_modules # Avoid overwriting `node_modules` inside the container
    environment:
      NODE_ENV: development
```

### Github Actions

- Once the application is dockerized, create the github workflow: ./github/workflows/[ci-name].yml
- Workflow has jobs, jobs have steps and steps have actions

```yml
# appears in the Actions tab on Github
name: [workflow-name]

# on: defines the events that trigger the workflow
# when should it run? => pushes? | pull requests ? | scheduled times?
on:
  push:
    branches:
      - main
  pull_request:

# jobs: collections of tasks that make up the workflow
jobs:
  # job 1: build-and-test
  build-and-test:
    runs-on: ubuntu-latest # specify the environment the job will run

    # steps: sequence of actions | commands within a job
    steps:
      # Step 1: Checkout the code
      - name: Checkout code
        # uses: reusable action or prebuilt functionality. It pulls a specific actions from the Github actions marketplace or Github-provided actions
        uses: actions/checkout@v3

      # Step 2: Set up Docker
      - name: Setup Docker
        uses: docker/setup-buildx-action@v2

      # Step 3: Build the Docker image
      - name: Build Docker image
        # run: executes a shell command or script. Defines custom commands
        run: docker compose build

      # Step 4: Run the Docker container
      - name: Run Docker container
        run: docker compose up -d

      # Step 5: Test app
      - name: Test app
        run: |
          sleep 10
          curl -f http://localhost:3000 || exit 1

      # Step 6: Stop and remove the container
      - name: Stop and remove container
        run: docker compose down
```
