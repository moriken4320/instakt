class UsersController < ApplicationController
  before_action :signed_out_to_root

  def profile
    @user = current_user
  end

  def update
    user = User.find(current_user.id)
    if user.update(user_param(user))
      render json: {user: user, flash: {type: "success", message: "更新しました"}}
    else
      user = User.find(current_user.id)
      render json: {user: user, flash: {type: "danger", message: "更新に失敗しました"}}
    end
  end
  
  #ユーザー検索の結果を取得
  def search
    image_in_users = [];
    users = User.search(params[:keyword])
    users.each do |user|
      image_in_users << {info: user, image: url_for(user.image)}
    end
    render json: image_in_users
  end

  
  private
  def user_param(user)
    params.require(:user).permit(:name, :email, :image).merge(provider: user.provider, uid: user.uid)
  end
  
  
end
