require 'twitter'

class TwitterService
  attr_reader :client
  def initialize(user)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def tweets_for_user
    @client.home_timeline
  end

  def tweet(tweet_message)
    @client.update(tweet_message)
  end

  def fetch_tweet(tweet_id)
    @client.status(tweet_id)
  end

  def favorite(tweet)
    @client.fav(tweet)
  end
end