require 'rails_helper'

RSpec.describe "ResponseMessages", type: :request do
  describe "GET /response_messages" do
    it "works! (now write some real specs)" do
      get response_messages_path
      expect(response).to have_http_status(200)
    end
  end
end
