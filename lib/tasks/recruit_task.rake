require 'active_record'

namespace :recruit_task do
  desc 'AM5:00を過ぎたら全ての募集を削除する'
  task delete_all: :environment do
    Recruit.destroy_all
  end
end
