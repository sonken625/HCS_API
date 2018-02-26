require "rails_helper"

RSpec.describe ResponseMessagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/response_messages").to route_to("response_messages#index")
    end


    it "routes to #show" do
      expect(:get => "/response_messages/1").to route_to("response_messages#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/response_messages").to route_to("response_messages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/response_messages/1").to route_to("response_messages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/response_messages/1").to route_to("response_messages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/response_messages/1").to route_to("response_messages#destroy", :id => "1")
    end

  end
end
