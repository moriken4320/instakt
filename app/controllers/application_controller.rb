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

  #ログインユーザーが募集状態だったら募集一覧画面に戻る
  def recruiter_to_recruits_path
    if current_user.recruit?
      redirect_to recruitments_path
    end
  end
  
  #ログインユーザーが募集状態でなければ募集一覧画面に戻る
  def not_recruiter_to_recruits_path
    @recruit = current_user.recruit?
    unless @recruit
      redirect_to recruitments_path
    end
  end 
  
  #ログインユーザーが参加状態であれば募集一覧画面に戻る
  def entrant_to_recruits_path
    if current_user.entry?
      redirect_to recruitments_path
    end
  end
  
end
