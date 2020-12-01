class RecruitmentsController < ApplicationController
  before_action :signed_in_user_to_recruitments, only: [:top]
  before_action :signed_out_to_root, except: [:top]
  before_action :recruiter_to_recruits_path, only: [:new_later, :create_later, :new_now, :create_now]
  before_action :not_recruiter_to_recruits_path, only: [:edit_later, :edit_now, :update_later, :update_now, :destroy]

  def top
    
  end

  def index
    recruits_all = Recruit.includes([:user, :later, :now]).order("created_at DESC")
    @recruits_of_friend = []
    @current_user_recruit = Recruit.recruit?(current_user)

    #フレンドと自分の募集のみ抽出
    recruits_all.each do |recruit|
      if current_user.friend?(recruit.user) || current_user == recruit.user
        @recruits_of_friend << recruit
      end
    end
  end

  def new_later
    render json: {info: current_user, image: url_for(current_user.image)}
  end
  
  def new_now
    render json: {info: current_user, image: url_for(current_user.image)}
  end

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
  
  def edit_later
    render json: {info: {recruit: @recruit, later: @recruit.later}, user: {info: @recruit.user, image: url_for(current_user.image)}}
  end
  
  def edit_now
    render json: {info: {recruit: @recruit, now: @recruit.now}, user: {info: @recruit.user, image: url_for(current_user.image)}}
  end

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

  def show
    @recruit = Recruit.find(params[:id])
    if @recruit.user.id == current_user.id #募集作成者であれば
      @page_name = "マイ募集ルーム"
    elsif @recruit.entries.find_by(user_id: current_user.id) #募集の参加者であれば
      @page_name = "参加中のルーム"
    else
      redirect_to recruitments_path
    end
  end

  def destroy
    @recruit.destroy
    flash[:success] = "募集を削除しました"
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

  #ログインユーザーが募集状態だったら募集一覧画面に戻る
  def recruiter_to_recruits_path
    if Recruit.recruit?(current_user)
      flash[:danger] = "失敗しました"
      redirect_to recruitments_path
    end
  end
  
  #ログインユーザーが募集状態でなければ募集一覧画面に戻る
  def not_recruiter_to_recruits_path
    @recruit = Recruit.recruit?(current_user)
    unless @recruit
      flash[:danger] = "失敗しました"
      redirect_to recruitments_path
    end
  end  
  
end
