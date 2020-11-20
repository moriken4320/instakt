class RecruitmentsController < ApplicationController
  before_action :sign_in?, only: [:top]
  before_action :sign_out?, except: [:top]

  def top
    
  end

  def index
    
  end
  
  private

  #ログイン状態であれば、recruitments_path(index)へリダイレクト
  def sign_in?
    if user_signed_in?
      redirect_to recruitments_path
    end
  end

  #ログアウト状態であれば、root_pathへリダイレクト
  def sign_out?
    unless user_signed_in?
      redirect_to root_path
    end
  end
  
  
  
end
