require "rails_helper"

RSpec.describe RequestMessagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/request_messages").to route_to("request_messages#index")
    end


    it "routes to #show" do
      expect(:get => "/request_messages/1").to route_to("request_messages#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/request_messages").to route_to("request_messages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/request_messages/1").to route_to("request_messages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/request_messages/1").to route_to("request_messages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/request_messages/1").to route_to("request_messages#destroy", :id => "1")
    end

  end
end
