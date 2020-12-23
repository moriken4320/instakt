require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"
job_type :rake, "export AWS_SECRET_ACCESS_KEY=\"#{ENV['AWS_SECRET_ACCESS_KEY']}\"; export AWS_ACCESS_KEY_ID=\"#{ENV['AWS_ACCESS_KEY_ID']}\"; export MYSQL_PASSWORD=\"#{ENV['MYSQL_PASSWORD']}\"; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"


# AM5:00に全募集を削除する（JSTは+9:00なので-9:00の時間を記述）
# every 1.day, at: '08:00 pm' do
every 1.day, at: '10:17 am' do
    rake "recruit_task:delete_all"
end

# 設定の確認
# bundle exec whenever 

# cronにデータを反映
# bundle exec whenever --update-crontab 

# cronからデータを削除
# bundle exec whenever --clear-crontab

# 反映したか確認
# crontab -l 