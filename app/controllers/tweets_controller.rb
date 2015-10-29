class TweetsController < ApplicationController
  def new
  end

  def create
    if current_user
      service = TwitterService.new(current_user)
      service.tweet(twitter_params[:message])
    end
    redirect_to root_path
  end

  def update
    if current_user
      service = TwitterService.new(current_user)
      tweet = service.fetch_tweet(params[:id])
      service.favorite(tweet)
    end
    redirect_to root_path
  end

  private

    def twitter_params
      params.require(:tweet).permit(:message)
    end
end
