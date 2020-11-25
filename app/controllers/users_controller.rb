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
    # users = User.search(params[:keyword])
    users = User.where(id: params[:keyword])
    if users.present? && users[0].id != current_user.id
      image_in_users << {info: users[0], image: url_for(users[0].image), follower_flag: current_user.follower?(users[0])}
    else
      image_in_users << {info: nil, image: nil}
    end

    
    render json: image_in_users
  end

  
  private
  def user_param(user)
    params.require(:user).permit(:name, :email, :image).merge(provider: user.provider, uid: user.uid)
  end
  
  
end
