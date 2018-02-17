require 'rails_helper'

RSpec.describe "Firms", type: :request do
  describe "GET /firms" do
    before do
      create(:firm,name: "test_firm1")
      create(:firm,name: "test_firm2")
    end

    context 'アドミン権限HCTの場合'do
      let(:admin_hct){ create(:hct,:with_admin)}
      before do
        get firms_path, headers: {Authorization: "Bearer #{admin_hct.authentication_token}"}
      end

      it "ステータス２００が返る" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "企業一覧を取得できる" do
        json = JSON.parse(response.body)
        expect(json[0]["name"]).to eq "test_firm1"
        expect(json[1]["name"]).to eq "test_firm2"
        expect(json[2]["name"]).to eq "1:admin"
      end


    end

    context '通常権限HCTの場合'do
      let(:normal_hct){create(:hct)}

      before do
        get firms_path, headers: {Authorization: "Bearer #{normal_hct.authentication_token}"}
      end

      it "ステータス２００が返る" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "企業一覧を取得できる" do
        json = JSON.parse(response.body)
        expect(json[0]["name"]).to eq "test_firm1"
        expect(json[1]["name"]).to eq "test_firm2"
        expect(json[2]["name"]).to eq "1:normal_firm"
      end


    end

    context 'ヘッダーにTokenがない場合'do
      before do
        get firms_path
      end

      it "ステータス401が返る"do
        expect(response).to have_http_status(401)
      end

      it "HTTP Token: Access denied.が返る"do
        expect(response.body).to match "HTTP Token: Access denied."
      end

    end

  end
end
