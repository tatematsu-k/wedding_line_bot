#!/bin/sh
set -e

rm -f /myapp/tmp/pids/server.pid
# bundle exec rails db:create
# bundle exec ridgepole -E production -c config/database.yml --apply

exec "$@"