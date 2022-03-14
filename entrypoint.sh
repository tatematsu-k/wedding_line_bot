#!/bin/sh
set -e

bundle exec rails db:create
bundle exec ridgepole -E production -c config/database.yml --apply

exec "$@"
