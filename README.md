# Tasks

You need to implement functionallity for email confirmation(including resending). ONLY API, not need to implement something related to web app.

General description:
Welcome email will be sent to user after registration. This email will contain link to web app, web app will handle such link, extract token and send request to API.

To achive that you need to:
* send email on user creation, this email should contain link to dummy web resource(example.com) including unique token as parameter
* implement endpoint to confirm email  
incoming attributes: token
* implement endpoint to resend email confirmation  
incoming attributes: email

Requirements:
* [JSON:API](https://jsonapi.org/) specification must be followed
* you need to follow code style that is applied in the project(you can check how implemented POST /users endpoint)
* confirmation request should be separate entity + should have states
* confirmation request TTL is 2d
* resending request cannot be performed by user more than once every 5 minutes
* EmailCredential's state must be changed to `active` + confirmed_at field must be filled after successful confirmation
* should be covered as many scenarios as possible on processing API endpoints(token is expired, etc.)
* state machine should be used to change entity's state
* all changes should be covered by tests

# Setup

## Dependencies

* [Docker & Docker compose](https://docs.docker.com/compose/install/)

## Install

### First install

### Install development environment

```bash
make provision
```

### Install test environment
```
RAILS_ENV=test make provision
```

## Usage

all actual tasks you can see in Makefile

### Launch tests

```
make test
```

### Go to app container

```
make bash
```

### Down containers

```
make down
```

down and remove all volumes:
```
make down-v
```
