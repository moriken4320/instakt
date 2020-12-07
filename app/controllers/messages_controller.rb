class MessagesController < ApplicationController
  before_action :signed_out_to_root
  before_action :nil_recruit_to_recruits_path

  def create
    @recruit = Recruit.find(params[:recruitment_id])
    message = Message.new(message_param)
    if message.valid? && (current_user.my_recruit?(@recruit) || current_user.my_entry?(@recruit).present?)
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

  private
  def message_param
    params.require(:message).permit(:text, :image).merge(sender_id: current_user.id, room_id: @recruit.id)
  end
  
  
end
