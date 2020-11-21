class UsersController < ApplicationController
  # before_action :signed_in_user_to_recruitments, only: [:top]
  before_action :signed_out_to_root

  def my_profile
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_param(@user))
      redirect_to my_profile_path
    else
      render action: :my_profile
    end
  end
  
  private
  def user_param(user)
    params.require(:user).permit(:name, :email, :image).merge(provider: user.provider, uid: user.uid)
  end
  
  
end
