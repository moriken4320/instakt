class ApplicationController < ActionController::Base

  private
 
  #ログイン状態であれば、recruitments_path(index)へリダイレクト
  def signed_in_user_to_recruitments
    if user_signed_in?
      redirect_to recruitments_path
    end
  end

  #ログアウト状態であれば、root_pathへリダイレクト
  def signed_out_to_root
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
