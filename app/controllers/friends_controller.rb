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

    if current_user.follower?(target_user) #target_userのハートが付与された状態？
      flash = heart_delete(target_user)
    else #target_userのハートが解除された状態？
      flash = heart_create(target_user)
    end

    render json: {heart: current_user.follower?(target_user), flash: flash}
  end
  

  private

  # ハートを解除するメソッド
  def heart_delete(target_user)
    if target_user.recruit? && current_user.my_entry?(target_user.recruit?) # target_userの募集に参加しているか
      flash = flash_hash("danger", "#{target_user.name}   の募集に参加中のためフレンド解除できません")
    elsif current_user.unfollow(target_user) #ハートを解除する
      flash = flash_hash("success", "#{target_user.name}   への申請を取り消しました")
      if current_user.following?(target_user)
        flash = flash_hash("success", "#{target_user.name}   がフレンドから解除されました")
      end
    else
      flash = flash_hash("danger", "ハートの解除に失敗しました")
    end

    flash
  end

  # ハートを付与するメソッド
  def heart_create(target_user)
    if current_user.follow(target_user) #ハートを付与する
      flash = flash_hash("success", "#{target_user.name}   にフレンド申請しました")
      if current_user.following?(target_user)
        flash = flash_hash("success", "#{target_user.name}   がフレンドに追加されました")
      end
    else
      flash = flash_hash("danger", "ハートの付与に失敗しました")
    end

    flash
  end
  
  
end
