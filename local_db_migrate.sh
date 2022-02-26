source ./.env

bundle exec rails db:create
bundle exec ridgepole -E $RAILS_ENV -c config/database.yml --apply
bundle exec annotate
