# First time logging in manageR

The first time you log in, you will be asked to provide the security code of your institution.
It consists of 20-digit alphanumeric string that the institution provides to the users. The code is different for each institution.

Let's say you want to log in as the admin to the system, you can do that by navigating to http://localhost:3000/users/sign_in and providing the following credentials:
Credential | Value
--|--
Email | "admin@example.com"
Password | 123456

![login](https://github.com/Shannarra/manageR/assets/26832131/42cf1b0f-fee3-44da-b878-644feb8f844a)

Once you log in you will be greeted by the "Verify your institution" screen. You will need to enter the institution's code and your profile's password to verify your user.
![verify](https://github.com/Shannarra/manageR/assets/26832131/0ce7e8c5-ccda-4846-8ea0-3ddf00cb3816)

##### Getting the code
Code will be sent via email in a real environment, but for the purpose of development, you can directly check for the code of the current user's institution in the database via the following command:

```console
docker compose run --rm web rails c
```

And inside the prompt, enter the following:
```ruby
User.where(email: "admin@example.com").first.institution.code
```
You will get an output similar to this one:
```
  User Load (1.2ms)  SELECT "users".* FROM "users" WHERE "users"."email" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["email", "admin@example.com"], ["LIMIT", 1]]
  Institution Load (0.4ms)  SELECT "institutions".* FROM "institutions" WHERE "institutions"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
=> "LR9dWXG7Q0jYft6NsiZq"
```
![code](https://github.com/Shannarra/manageR/assets/26832131/7970cc2c-aa51-40a2-a8ab-8b7f25fd830b)

See that last piece of string? This is the institution's code!
We can now copy it and paste it into the verification form.

![confirmed](https://github.com/Shannarra/manageR/assets/26832131/3850b279-5d61-433f-9cee-5f413c6fc8a4)

And that's it, you have been verified! Your admin user now has a free reign over the entire system!

All of this is required only once. When the user gets verified, the system will never ask for the institution code again and you can freely access the system.


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
- [x] [Classses](./docs/classes.md)
- [x] Study [Subjects](./docs/subjects.md)
- [x] [Attendance](./docs/attendance.md) tracking
- [x] [Exams](./docs/exams.md) (with types: physical, online) and scheduling in the future
- [x] [Grades](./docs/grading.md)
- [x] [Reports](./docs/reports.md) (in PDF, CSV or JSON), including overall information for institution and all data the institution's management would need.

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
###### Please, make sure that you have turned your postgresql service off or you will be greeted with an error message saying that port 5432 is taken.
###### You can do that by running the command `sudo systemctl stop postgresql`

You can just run the [startup.sh](https://github.com/Shannarra/rails7template/edit/master/startup.sh) script:
```console
sh ./startup.sh --run
```

This will bootstrap the application with sample data and profiles with different authorizations. Please, note that __*Registering endpoints are disabled intentionally*__ (see [Usage](#Usage))

> Since this operation will seed the database with several thousand items and their relations, the initial setup can be slow, but seeding will provide useful feedback in the console.

Alternatively, if you can't run the shell script, you can bootstrap the application yourself by running the following few commands:

```sh
# make sure the binaries of the project have the privileges to work as expected
chmod u+x -R ./bin/*

# copy/rename the environment variables file
cp .env.example .env

# build the initial containers
docker compose build

# setup the database, including migrations and seeding
docker compose run --rm web rails db:setup
```

## Usage
Once the app has been set up you can just run it via one of the following commands:
#### Running the app
```console
docker compose up --build
```
Then just navigate to http://localhost:3000

### First time logging in
When logging in for the first time, please read the  [first time logging in docs](./docs/users/first_time_login.md) if you are confused on how to use the system.

I would also suggest you go through the [entire documentation folder](./docs/) if you want a crash course on how to use the system.

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
docker compose run --rm web rails c
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
