class FriendsController < ApplicationController
  before_action :signed_out_to_root

  def index
    @friends = current_user.matchers
  end
  
  #フレンドユーザー情報を返す
  def mutual
    friends = current_user.matchers
    render json: friends
  end
  
  #ログイン中のユーザーから一方的にハートを押されているユーザー情報を取得
  def oneway_followers
    friends = current_user.oneway_followers
    render json: friends
  end
  
  #ログイン中のユーザーに対して一方的にハートを押しているユーザー情報を取得
  def oneway_followings
    friends = current_user.oneway_followings
    render json: friends
  end
  
end
