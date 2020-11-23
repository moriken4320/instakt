class UsersController < ApplicationController
  before_action :signed_out_to_root

  def profile
    @user = current_user
  end

  def update
    user = User.find(current_user.id)
    user.update(user_param(user))
    render json: {data: user}
  end
  
  private
  def user_param(user)
    params.require(:user).permit(:name, :email, :image).merge(provider: user.provider, uid: user.uid)
  end
  
  
end
