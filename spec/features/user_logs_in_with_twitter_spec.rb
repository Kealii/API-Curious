require 'spec_helper'

RSpec.feature 'user' do

  before do
    stub_omniauth
  end

  scenario 'logs in with twitter' do
    visit '/'
    click_link 'Login'
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Test User')
    expect(page).to have_content('Logout')
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider:           'twitter',
      extra: {
        raw_info: {
          user_id:     '1',
          name:        'Test User',
          screen_name: 'TestScreenName',
        }
      },
      credentials: {
        oauth_token:        '123',
        oauth_token_secret: '321'
      }
    })
  end
end