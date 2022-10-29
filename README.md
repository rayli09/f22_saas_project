# COMS W4152 SaaS Project

## Team members
1. Ruize Li
2. Ken Xiong
3. Jianyang Duan
4. Moxin Xu

## For Fast Development
1. Run `make serve` to streamline dev process. It'll setup env, prepare database, and start server.
 
## How to build and run locally
1. Run `bundle install --without production` to install dependencies
2. Run `rake db:seed` to load initial values
3. Run `rake db:migrate` to migrate DB
4. Run `rake db:test:prepare` to initialize testing DB
5. (TODO DB setup for prod?)

## How to run tests
1. `rake cucumber` for BDD tests.
2. `rake spec` for TDD Rspec tests.

## API Documentation
(TODO)
## Third-party code in use
(TODO)
## How To Deploy(TODO)
1. install `pg` using brew and `bundle install` again.(TBD)
2. 