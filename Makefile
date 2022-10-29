.PHONY: serve db-reset db-setup db-migrate init bundle clean

serve: init db-setup db-migrate
	rails s

# live-reload: yarn
# 	./bin/webpack-dev-server --host 127.0.0.1

db-reset:
	bundle exec rake db:reset

db-setup: .make.db-setup

db-migrate: .make.db-migrate

init: .make.init

bundle: .make.bundle

clean:
	rm .make.*

.make.db-setup: .make.bundle
	rake db:seed
	touch .make.db-setup

.make.db-migrate: .make.bundle $(shell find db/migrate -type f)
	rake db:migrate
	rake db:test:prepare
	touch .make.db-migrate

.make.bundle: Gemfile
	bundle
	touch .make.bundle

# .make.yarn: package.json
# 	yarn
# 	touch .make.yarn

.make.init:
	bundle install
	touch .make.init