# README

## Development Dependencies

If Docker Desktop is installed, this application should work on any MacOS computer or any Windows computer with the Windows Subsystem for Linux (WSL). However, it has only been tested in the following environment:

- Windows 10.0.19044 N/A Build 19044
- Ubuntu 22.04.2 via WSL version 1.2.5.0
- Docker Desktop 4.14.0

## Initial Setup

Execute the following in a terminal window:

```bash
# .env.example contains local DB settings. Create the .env file that is not
# checked in to version control
cp .env.example .env

# build the docker image used for development and test
docker-compose build

# setup the development and test databases
docker-compose run --rm web bin/rails db:setup
docker-compose run --rm web bin/rails db:setup RAILS_ENV=test
```

## Running Tests

Specs can be executed with:

```bash
docker-compose run --rm web bundle exec rspec
```

## Data Import

Example restaurant, menu, and menu item data is stored in `resources/restaurant_data.json`. To import the data into the development database, run the `import` Rake task with:

```bash
docker-compose run --rm web bin/rake "import[./resources/restaurant_data.json]"
```
