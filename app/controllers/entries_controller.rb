class EntriesController < ApplicationController
  before_action :signed_out_to_root
  before_action :nil_recruit_to_recruits_path
  before_action :recruiter_to_recruits_path, except: [:index]
  before_action :entrant_to_recruits_path, only: [:create]
  before_action :not_entrant_to_recruits_path, only: [:destroy]
  before_action :set_recruit

  def index
    users = []
    flash = flash_hash("danger", "参加者がいません")
    if current_user.friend?(@recruit.user) || @recruit.user.id == current_user.id
      @recruit.users.each do |user|
        users << {info: user, image: url_for(user.image)}
      end
    else
      flash = flash_hash("danger", "あなたはこの募集作成者とフレンドではありません")
    end
    render json: {users: users, flash: flash}
  end
  

  def create
    entry = Entry.new(user_id: current_user.id, recruit_id: @recruit.id)
    if entry.valid? && !@recruit.close?
      entry.save
      flash[:success] = "参加しました"
      InquiryMailer.send_mail(current_user, @recruit.user, "参加通知", "があなたの募集に参加しました。").deliver_later
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
      InquiryMailer.send_mail(current_user, @recruit.user, "参加取り消し通知", "があなたの募集への参加を取り消しました。").deliver_later
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
