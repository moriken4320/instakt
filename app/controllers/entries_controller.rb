class EntriesController < ApplicationController
  before_action :recruiter_to_recruits_path, except: [:index]
  before_action :entrant_to_recruits_path, only: [:create]
  before_action :not_entrant_to_recruits_path, only: [:destroy]
  before_action :set_recruit

  def index
    users = []
    @recruit.users.each do |user|
      users << {info: user, image: url_for(user.image)}
    end
    render json: users
  end
  

  def create
    entry = Entry.new(user_id: current_user.id, recruit_id: @recruit.id)
    if entry.valid? && !@recruit.close?
      entry.save
      flash[:success] = "参加しました"
      redirect_to recruitment_path(@recruit)
    else
      flash[:danger] = "参加に失敗しました"
      redirect_to recruitments_path
    end
  end
  
  def destroy
    entry = Entry.find_by(user_id: current_user.id, recruit_id: @recruit.id)
    if entry.present?
      entry.destroy
      flash[:success] = "参加を取り消しました"
      redirect_to recruitments_path
    else
      flash[:danger] = "参加の取り消しに失敗しました"
      redirect_to recruitments_path
    end
  end

  private
  def set_recruit
    @recruit = Recruit.find(params[:recruitment_id])
  end
  
end
