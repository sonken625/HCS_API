require 'rails_helper'

RSpec.describe "RequestMessages", type: :request do
  describe "GET /request_messages" do
    it "works! (now write some real specs)" do
      get request_messages_path
      expect(response).to have_http_status(200)
    end
  end
end
