class WelcomeController < ApplicationController
  def index
    @user = current_user
    if @user
      @service = TwitterService.new(@user)
      @tweets = @service.tweets_for_user
    end
  end
end

