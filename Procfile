web: bundle exec rails server -p $PORT
worker: bundle exec sidekiq -c 2 -C ./config/sidekiq.yml
release: bundle exec rake db:migrate
