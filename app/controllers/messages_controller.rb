class MessagesController < ApplicationController
  before_action :signed_out_to_root
  before_action :nil_recruit_to_recruits_path
  before_action :my_recruit_or_my_entry?

  def create
    message = Message.new(message_param)
    if message.valid?
      message.save
      
      if message.was_attached?
        render json: {message: {info: message, image: url_for(message.image)}}
      else
        render json: {message: {info: message, image: nil}}
      end
    else
      render json: {message: nil}
    end
  end

  def reload
    last_message_id = params[:id].to_i
    messages_with_users = []
    @messages = @recruit.messages.includes(:sender).where("id > ?", last_message_id).order("created_at ASC")
    @messages.each do |message|
      if message.was_attached?
        messages_with_users << {message: {info: message, image: url_for(message.image)}, user: {info: message.sender, image: url_for(message.sender.image)}}
      else
        messages_with_users << {message: {info: message, image: nil}, user: {info: message.sender, image: url_for(message.sender.image)}}
      end
    end
    render json: messages_with_users
  end
  

  private
  def message_param
    params.require(:message).permit(:text, :image).merge(sender_id: current_user.id, room_id: @recruit.id)
  end
  
  def my_recruit_or_my_entry?
    @recruit = Recruit.find(params[:recruitment_id])
    unless current_user.my_recruit?(@recruit) || current_user.my_entry?(@recruit).present?
      redirect_to recruitments_path
    end
  end
  

end
