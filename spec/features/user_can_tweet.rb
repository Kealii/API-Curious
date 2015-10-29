require 'spec_helper'

RSpec.feature 'user' do

  before do
    OmniAuth.config.mock_auth[:twitter] = nil
  end

  scenario 'can make a new tweet' do
    VCR.use_cassette('user#tweets twitter') do
      stub_omniauth
      login_user
      fill_in 'Message', with: 'Test Tweet'
      click_button 'Twit'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Test Tweet')
      expect(page).to have_content('Test User')
      expect(page).to have_content('Logout')
    end
  end
end