class RoomsController < ApplicationController
  def display
    @recruit = Recruit.find(params[:id])
    if @recruit.user.id == current_user.id
      @page_name = "マイ募集ルーム"
    else
      @page_name = "参加中のルーム"
    end
  end
end
