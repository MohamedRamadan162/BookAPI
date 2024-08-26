#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# If the database exists, migrate. Otherwise setup (create and migrate)
# bundle exec rake db:drop db:create db:migrate db:seed 2>/dev/null || bundle exec rake db:drop db:create db:migrate db:seed
echo "Done!!!!!!!!"
# wait for elasticsearch
# until nc -vz $ELASTICSEARCH_HOST 9200; do
#   echo "Elasticsearch is not ready, sleeping..."
#   sleep 1
# done
if [ -z "$IS_WORKER" ]; then
  # echo "Elasticsearch is ready, starting Rails."
  echo "Sidekiq should not start here"
  rails db:migrate 2>/dev/null || rails db:create db:migrate
  # rails rswag
  exec "$@"
else
  bundle exec rails s -d
  echo "Sidekiq should start here"
  bundle exec sidekiq -C /myapp/config/sidekiq.yml
fi


# Then exec the container's main process (what's set as CMD in the Dockerfile).
