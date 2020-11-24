class FriendsController < ApplicationController
  before_action :signed_out_to_root

  def index
    @friends = current_user.matchers
  end
  
  #フレンドユーザー情報を返す
  def mutual
    image_in_friends = [];
    friends = current_user.matchers
    friends.each do |friend|
      image_in_friends << {info: friend, image: url_for(friend.image), follower_flag: current_user.follower?(friend)}
    end
    render json: image_in_friends
  end
  
  #ログイン中のユーザーから一方的にハートを押されているユーザー情報を取得
  def oneway_followers
    image_in_friends = [];
    friends = current_user.oneway_followers
    friends.each do |friend|
      image_in_friends << {info: friend, image: url_for(friend.image), follower_flag: current_user.follower?(friend)}
    end
    render json: image_in_friends
  end
  
  #ログイン中のユーザーに対して一方的にハートを押しているユーザー情報を取得
  def oneway_followings
    image_in_friends = [];
    friends = current_user.oneway_followings
    friends.each do |friend|
      image_in_friends << {info: friend, image: url_for(friend.image), follower_flag: current_user.follower?(friend)}
    end
    render json: image_in_friends
  end
  
  
end
