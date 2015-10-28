require 'spec_helper'

RSpec.feature 'user' do
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

  def bad_omniauth_credentials
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
  end

  def login_user
    visit login_path
  end

  before do
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  scenario 'logs in with twitter' do
    stub_omniauth
    login_user

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logged In.')
    expect(page).to have_content('Test User')
    expect(page).to have_content('Logout')
  end

  scenario 'logs in with bad twitter credentials' do
    bad_omniauth_credentials
    login_user

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login')
    expect(page).to have_content('Invalid Credentials. Please try again.')
  end

  scenario 'logs out with twitter' do
    stub_omniauth
    login_user
    click_link('Logout')

    expect(page).to have_content('Logged Out.')
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login')
    expect(page).to_not have_content('Test User')
  end
end