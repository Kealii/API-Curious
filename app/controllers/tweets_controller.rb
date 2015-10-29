class TweetsController < ApplicationController
  def new
  end

  def create
    @user = current_user
    if @user
      service = TwitterService.new(@user)
      service.tweet(twitter_params[:message])
    end
    redirect_to root_path
  end

  private

    def twitter_params
      params.require(:tweet).permit(:message)
    end
end
