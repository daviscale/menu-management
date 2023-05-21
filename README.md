# README

## Development Dependencies

Running this application on a development workstation requires Docker Desktop.

It has been tested in the following environment:

- Windows 10.0.19044 N/A Build 19044
- Ubuntu 22.04.2 via WSL version 1.2.5.0
- Docker Desktop 4.14.0

## Initial Setup

```
# .env.example contains local DB settings. Create the .env file that is not
# checked in to version control
cp .env.example .env

# build the docker image used for development and test
docker-compose build

# setup the development and test databases
docker-compose run --rm web bin/rails db:setup
docker-compose run --rm web bin/rails db:setup RAILS_ENV=test
```
