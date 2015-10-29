class WelcomeController < ApplicationController
  def index
    if current_user
      service = TwitterService.new(current_user)
      @tweets = service.tweets_for_user
    end
  end
end
