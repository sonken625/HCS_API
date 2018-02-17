require "rails_helper"

RSpec.describe HctsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/hcts").to route_to("hcts#index")
    end


    it "routes to #show" do
      expect(:get => "/hcts/1").to route_to("hcts#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/hcts").to route_to("hcts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/hcts/1").to route_to("hcts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/hcts/1").to route_to("hcts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/hcts/1").to route_to("hcts#destroy", :id => "1")
    end

  end
end
