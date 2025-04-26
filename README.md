# Privilee API Assessment
This repository is covers the automation regressing the following endpoints:
  Markup :  - POST /public/v2/users
            - GET /public/v2/users
            - GET /public/v2/users/:id
            - POST /public/v2/users/:id/posts
            - POST /public/v2/users/:id/todos
Automation tool utilized is Robot Framework. Directory profile are as follows:
  Markup :  - resources - contains utilities and assertions
              - assertions - contains keywords specific to validating scenarios per endpoint
              - utilities - contains keywords specific to utilities per endpoint
              - libraries.robot - contains the imported libraries
            - requests - contains keywords that manipulates the request body and directly communicates to the endpoint. This also includes request bodies per endpoint
            - tests - contains the test scenarios organized per endpoint
            - environment_variables.robot - contains the settings/test accounts/tokens
            - resource_collection.robot - contains the resource paths imported so that the tests can use the keywords
            - log.html and report.html - files that are generated every run. Contains failed and successful executions

## Setup
1. Python should be installed
2. Clone the repository
3. Run the command below in the root directory of this project
```bash
pip install -r requirements.txt
```

## Usage
Run the command to execute the whole automation
```bash
robot ./tests
```

NOTE: To run per endpoint include the "Force Tags" to the command e.g. `robot -i create-user ./tests`
