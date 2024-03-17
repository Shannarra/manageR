# manageR™ - manage your institution the correct way! [![Ruby](https://github.com/Shannarra/manageR/actions/workflows/ruby.yml/badge.svg?branch=master)](https://github.com/Shannarra/manageR/actions/workflows/ruby.yml)
This app is a comprehensive school management system using Rails 7 with PostgreSQL, import maps, turbo, stimulus, bootstrap and hotwire, all running in Docker. The base template of the application can be found at [Shannarra/rails7template](https://github.com/Shannarra/rails7template)

## Features
- [x] Rails 7
- [x] Ruby 3
- [x] Bootstrap
- [x] Dockerfile and Docker Compose configuration
- [x] PostgreSQL database
- [x] Redis
- [x] GitHub Actions for
  - [x] tests
  - [x] Rubocop for linting
  - [x] Security checks with [Brakeman](https://github.com/presidentbeef/brakeman) and [bundler-audit](https://github.com/rubysec/bundler-audit)
- [x] Dependabot for automated updates
- [x] Devise for [authentication](./docs/users/authentication.md)
- [x] Different user access types (based on profile)
  (see access types in [authentication docs](./docs/users/authentication.md))
- [x] [Authorization](./docs/users/authorization.md) checks using Pundit
- [x] [Admin panel](./docs/users/admin.md) and privileges
- [x] [Institutions](./docs/institutions.md)
- [x] Classses
- [x] Study Subjects
- [x] Attendance tracking
- [x] Exams (with types: physical, online) and scheduling in the future
- [x] [Grades](./docs/grading.md)
- [ ] *IN PROGRESS* Reports for a specific class or all classes (in PDF, CSV), including top-graded students, average grades for subject, etc.

## Requirements

Please ensure you are using Docker Compose V2. This project relies on the `docker compose` command, not the previous `docker-compose` standalone program.

https://docs.docker.com/compose/#compose-v2-and-the-new-docker-compose-command

rails g scaffold Subject name:string year:integer description:string teacher:references klass:references


Check your docker compose version with:
```
$ docker compose version
Docker Compose version v2.20.2
```

## Development setup
> Please, make sure that you have turned your postgresql service off or you will be greeted with an error message saying that port 5432 is taken.
You can do that by running the command `sudo systemctl stop postgresql`

You can just run the [startup.sh](https://github.com/Shannarra/rails7template/edit/master/startup.sh) script:
```console
sh ./startup.sh --run
```
This will bootstrap the application with sample data and profiles with different authorizations. Please, note that __*Registering endpoints are disabled intentionally*__ (see [Usage](#Usage))

## Usage
#### Running the app
```console
docker compose up --build
```
Then just navigate to http://localhost:3000

#### Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```console
docker compose exec web bin/rails c
```

When no container running yet, start up a new one:
```console
docker compose run --rm web bin/rails c
```

#### Running tests
```console
docker compose run --rm web bin/rspec
```

#### Updating gems
```console
docker compose run --rm web bundle
docker compose up --build
```

#### Production build
```console
docker build -f production.Dockerfile .
```


## Deployment
This app can be hosted wherever Ruby is supported and PostgreSQL databases can be provisioned.

#### Render

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=[https://github.com/Shannarra/manageR](https://github.com/Shannarra/manageR))

NOTE: You will need to generate a production secret with `bin/rails secret` and set it as the `SECRET_KEY_BASE` environment variable.

## Credits/References

### Rails with Docker
* [Quickstart: Compose and Rails](https://docs.docker.com/compose/rails/)
* [Docker for Rails Developers
Build, Ship, and Run Your Applications Everywhere](https://pragprog.com/titles/ridocker/docker-for-rails-developers/)
* [Ruby on Whales:
Dockerizing Ruby and Rails development](https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development)
* [Original inspiration repo](https://github.com/ryanwi/rails7-on-docker)

### Rails 7 with importmaps

* [Alpha preview: Modern JavaScript in Rails 7 without Webpack](https://www.youtube.com/watch?v=PtxZvFnL2i0)

### Rails 7 with hotwire

* [Stimulus 3 + Turbo 7 = Hotwire 1.0](https://world.hey.com/dhh/stimulus-3-turbo-7-hotwire-1-0-9d507133)
* [Turbo 7](https://world.hey.com/hotwired/turbo-7-0dd7a27f)
* [Rails 7 will have three great answers to JavaScript in 2021+](https://world.hey.com/dhh/rails-7-will-have-three-great-answers-to-javascript-in-2021-8d68191b)
* [Hotwire Turbo Replacing Rails UJS](https://www.driftingruby.com/episodes/hotwire-turbo-replacing-rails-ujs)
