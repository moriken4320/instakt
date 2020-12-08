require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"
job_type :rake, "export MYSQL_PASSWORD=\"#{ENV['MYSQL_PASSWORD']}\"; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

# AM5:00に全募集を削除する
every 1.minutes do
    rake "recruit_task:delete_all"
end