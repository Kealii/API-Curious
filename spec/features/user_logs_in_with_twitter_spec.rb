require 'spec_helper'

RSpec.feature 'user' do

  before do
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  scenario 'logs in with twitter' do
    VCR.use_cassette('user#logs_in twitter') do
      stub_omniauth
      login_user

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Logged In.')
      expect(page).to have_content('Test User')
      expect(page).to have_content('Logout')
    end
  end

  scenario 'logs in with bad twitter credentials' do
    VCR.use_cassette('user#logs_in bad twitter credentials') do
      bad_omniauth_credentials
      login_user

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Login')
      expect(page).to have_content('Invalid Credentials. Please try again.')
    end
  end

  scenario 'logs out with twitter' do
    VCR.use_cassette('user#logs_out twitter') do
      stub_omniauth
      login_user
      click_link('Logout')

      expect(page).to have_content('Logged Out.')
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Login')
      expect(page).to_not have_content('Test User')
    end
  end
end