class RecruitmentsController < ApplicationController
  before_action :signed_in_user_to_recruitments, only: [:top]
  before_action :signed_out_to_root, except: [:top]
  before_action :recruiter_to_recruits_path, only: [:new_later, :create_later, :new_now, :create_now]
  before_action :not_recruiter_to_recruits_path, only: [:edit_later, :edit_now, :update_later, :update_now, :destroy, :finish, :restart]
  before_action :entrant_to_recruits_path, only: [:new_later, :create_later, :new_now, :create_now]

  def top
  end

  # 募集一覧表示画面用アクション
  def index
    recruits_all = Recruit.includes([:user, :later, :now]).order("created_at DESC")
    @recruits_of_friend = []

    #フレンドと自分の募集のみ抽出
    recruits_all.each do |recruit|
      if current_user.friend?(recruit.user) || current_user.my_recruit?(recruit)
        @recruits_of_friend << recruit
      end
    end
  end

  # 「これから」の募集作成UI表示用アクション
  def new_later
    render json: {info: current_user, image: url_for(current_user.image)}
  end
  
  # 「いま」の募集作成UI表示用アクション
  def new_now
    render json: {info: current_user, image: url_for(current_user.image)}
  end

  # 「これから」の募集保存用アクション
  def create_later
    recruit_later = RecruitLater.new(recruit_later_param)
    if recruit_later.valid?
      recruit_later.save
      flash[:success] = "「これから」で募集を作成しました"
    else
      flash[:danger] = "保存に失敗しました"
    end
    redirect_to recruitments_path
  end
  
  # 「いま」の募集保存用アクション
  def create_now
    recruit_now = RecruitNow.new(recruit_now_param)
    if recruit_now.valid?
      recruit_now.save
      flash[:success] = "「いま」で募集を作成しました"
    else
      flash[:danger] = "保存に失敗しました"
    end
    redirect_to recruitments_path
  end
  
  # 「これから」の募集編集UI表示用アクション
  def edit_later
    render json: {info: {recruit: @recruit, later: @recruit.later}, user: {info: @recruit.user, image: url_for(current_user.image)}}
  end
  
  # 「いま」の募集編集UI表示用アクション
  def edit_now
    render json: {info: {recruit: @recruit, now: @recruit.now}, user: {info: @recruit.user, image: url_for(current_user.image)}}
  end

  # 「これから」の募集更新用アクション
  def update_later
    recruit_later = RecruitLater.new(recruit_later_param)
    flash_type = "notice"
    flash_message = ""
    if recruit_later.valid?
      recruit_later.update(@recruit)
      flash_type = "success"
      flash_message = "募集内容を編集しました"
    else
      flash_type = "danger"
      flash_message = "更新に失敗しました"
    end
    render json: {recruit_later: {recruit: @recruit, later: @recruit.later}, flash: {type: flash_type, message: flash_message}}
  end
  
  # 「いま」の募集更新用アクション
  def update_now
    recruit_now = RecruitNow.new(recruit_now_param)
    flash_type = "notice"
    flash_message = ""
    if recruit_now.valid?
      recruit_now.update(@recruit)
      flash_type = "success"
      flash_message = "募集内容を編集しました"
    else
      flash_type = "danger"
      flash_message = "更新に失敗しました"
    end
    render json: {recruit_now: {recruit: @recruit, now: @recruit.now}, flash: {type: flash_type, message: flash_message}}
  end

  # 募集のルーム表示用アクション
  def show
    @recruit = Recruit.find(params[:id])
    if current_user.my_recruit?(@recruit) #募集作成者であれば
      @page_name = "マイ募集ルーム"
    elsif current_user.my_entry?(@recruit) #募集の参加者であれば
      @page_name = "参加中のルーム"
    else
      redirect_to recruitments_path
    end
  end

  # 募集削除用アクション
  def destroy
    @recruit.destroy
    flash[:success] = "募集を削除しました"
    redirect_to recruitments_path
  end
  
  # 募集終了用アクション
  def finish
    if @recruit.update(close_flag: 1)
      flash[:success] = "募集を終了しました"
    else
      flash[:danger] = "募集の終了に失敗しました"
    end
    redirect_to recruitments_path
  end
  
  # 募集再開用アクション
  def restart
    unless @recruit.max_entry?
      @recruit.update(close_flag: 0)
      flash[:success] = "募集を再開しました"
    else
      flash[:danger] = "募集人数がMAXのため再開できません"
    end
    redirect_to recruitments_path
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
    params.require(:recruit_now).permit(
      :member_count,
      :end_at_hour_top,
      :end_at_minute_top,
      :end_at_hour_bottom,
      :end_at_minute_bottom,
      :place,
      :message,
      :close_condition_count
    ).merge(user: current_user)
  end
  
end
