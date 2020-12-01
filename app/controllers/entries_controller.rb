class EntriesController < ApplicationController
  before_action :recruiter_to_recruits_path
  before_action :entrant_to_recruits_path, only: [:create]

  def create
    recruit_id = params[:recruitment_id]
    entry = Entry.new(user_id: current_user.id, recruit_id: recruit_id)
    if entry.valid?
      entry.save
      flash[:success] = "参加しました"
      redirect_to recruitment_path(recruit_id)
    else
      flash[:danger] = "参加に失敗しました"
      redirect_to recruitments_path
    end
  end
  
  def destroy
    
  end
  
end
