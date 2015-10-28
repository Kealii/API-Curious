class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    user = find_or_create_by(uid: auth_info[:uid])

    user.update_attributes(
      uid:                auth_info.uid,
      name:               auth_info.extra.raw_info.name,
      image_url:          auth_info.extra.raw_info.profile_image_url,
      followers_count:    auth_info.extra.raw_info.followers_count,
      friends_count:      auth_info.extra.raw_info.friends_count,
      screen_name:        auth_info.extra.raw_info.screen_name,
      oauth_token:        auth_info.credentials.token,
      oauth_token_secret: auth_info.credentials.secret
    )

    user
  end
end
