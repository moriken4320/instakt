class RecruitmentsController < ApplicationController
  before_action :signed_in_user_to_recruitments, only: [:top]
  before_action :signed_out_to_root, except: [:top]

  def top
    
  end

  def index
    
  end
  
  private


  
  
  
end
