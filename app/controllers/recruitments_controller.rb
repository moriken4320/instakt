class RecruitmentsController < ApplicationController
  before_action :signed_in_user_to_recruitments, only: [:top]
  before_action :signed_out_to_root, except: [:top]
  before_action :move_to_recruits_path, only: [:new_later, :create_later]

  def top
    
  end

  def index
    recruits_all = Recruit.includes([:user, :later, :now]).order("created_at DESC")
    @recruits_of_friend = []

    #フレンドと自分の募集のみ抽出
    recruits_all.each do |recruit|
      if current_user.friend?(recruit.user) || current_user == recruit.user
        @recruits_of_friend << recruit
      end
    end

    @recruits_of_friend
  end

  def new_later
    @recruit_later = RecruitLater.new
  end
  
  def new_now

  end

  def create_later
    @recruit_later = RecruitLater.new(recruit_later_param)
    if @recruit_later.valid?
      @recruit_later.save
      redirect_to recruitments_path
    else
      flash[:danger] = "値が正常に入力されていません"
      render action: :new_later
    end
  end
  
  def create_now
    
  end
  
  
  private
  def recruit_later_param
    params.require(:recruit_later).permit(
      :start_at_hour_top,
      :start_at_minute_top,
      :start_at_hour_bottom,
      :start_at_minute_bottom,
      :end_at_hour_top,
      :end_at_minute_top,
      :end_at_hour_bottom,
      :end_at_minute_bottom,
      :place,
      :message,
      :close_condition_count
    ).merge(user: current_user)
  end
  
  def recruit_now_param
    
  end

  def move_to_recruits_path
    if Recruit.recruit?(current_user)
      redirect_to recruitments_path
    end
  end
end
