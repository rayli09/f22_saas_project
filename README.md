# COMS W4152 SaaS Project

## Github Link
https://github.com/rl3250/f22_saas_project/

## Deployment
Deployed on Heroku: https://f22-saas-wemeet.herokuapp.com/

## Team members
1. Ruize Li (rl3250)
2. Ken Xiong (kx2175)
3. Jianyang Duan (jd3794)
4. Moxin Xu (mx2237)

## Dependency
1. install `postgreSql` on your local computer. [Reference here](https://www.postgresql.org/download/)
 
## How to build and run locally
1. Run `bundle install --without production` to install dependencies and related gems
2. Run `rake db:seed` to load initial values
3. Run `rake db:migrate:reset` to load up all migrations
4. RUn `rails s` to start the server

## How to run tests
1. `rake cucumber` for BDD tests.
2. `rake spec` for TDD Rspec tests.
3. coverage reports are generated seperated for both `Spec` and `Cucumber` and both are under the `coverage` folder.

