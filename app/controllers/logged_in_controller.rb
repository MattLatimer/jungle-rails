class LoggedInController < ApplicationController

  before_action do
    redirect_to '/login' unless current_user
  end
  
end
