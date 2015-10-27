require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before do
    OmniAuth.config.mock_auth[:twitter] = nil
    OmniAuth.config.mock_auth[:twitter]
  end

  describe "GET #create" do
    xit "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
