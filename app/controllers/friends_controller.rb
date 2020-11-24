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
  
  #ハートをクリックした際のアクション
  def heart
    target_user = User.find(params[:id])
    flash_type = "notice"
    flash_message = ""

    if current_user.follower?(target_user) #target_userのハートが付与された状態？
      if current_user.unfollow(target_user) #ハートを解除する
        flash_type = "success"
        flash_message = "#{target_user.name}   への申請を取り消しました"
        if current_user.following?(target_user)
          flash_message = "#{target_user.name}   がフレンドから解除されました"
        end
      else
        flash_type = "danger"
        flash_message = "ハートの解除に失敗しました"
      end
    else #target_userのハートが解除された状態？
      if current_user.follow(target_user) #ハートを付与する
        flash_type = "success"
        flash_message = "#{target_user.name}   に申請しました"
        if current_user.following?(target_user)
          flash_message = "#{target_user.name}   がフレンドに追加されました"
        end
      else
        flash_type = "danger"
        flash_message = "ハートの付与に失敗しました"
      end
    end

    render json: {heart: current_user.follower?(target_user), flash: {type: flash_type, message: flash_message}}
  end
  
  
end
