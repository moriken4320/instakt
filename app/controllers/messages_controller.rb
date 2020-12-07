class MessagesController < ApplicationController
  before_action :signed_out_to_root

  def create
    @recruit = Recruit.find(params[:recruitment_id])
    message = Message.new(message_param)
    if message.valid? && (current_user.my_recruit?(@recruit) || current_user.my_entry?(@recruit).present?)
      message.save
      # render json: {message: message}
    end
    redirect_to recruitment_path(@recruit)
  end

  private
  def message_param
    params.require(:message).permit(:text, :image).merge(sender_id: current_user.id, room_id: @recruit.id)
  end
  
  
end
