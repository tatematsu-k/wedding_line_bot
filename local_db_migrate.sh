bundle exec rails db:create
bundle exec ridgepole -E development -c config/database.yml --apply
bundle exec ridgepole -E test -c config/database.yml --apply
bundle exec annotate
