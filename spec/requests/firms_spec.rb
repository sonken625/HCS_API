require 'rails_helper'

RSpec.describe "Firms", type: :request do
  describe "GET /firms" do
    before do
      create(:firm, name: "test_firm1")
      create(:firm, name: "test_firm2")
    end

    context 'アドミン権限HCTの場合' do
      let(:admin_hct) {create(:hct, :with_admin)}
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

    context '通常権限HCTの場合' do
      let(:normal_hct) {create(:hct)}

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

    context 'ヘッダーにTokenがない場合' do
      before do
        get firms_path
      end

      it "ステータス401が返る" do
        expect(response).not_to be_success
        expect(response).to have_http_status(401)
      end

      it "HTTP Token: Access denied.が返る" do
        expect(response.body).to match "HTTP Token: Access denied."
      end

    end

  end



  describe "POST /firms" do
    context 'アドミン権限HCTの場合' do
      let(:admin_hct) {create(:hct, :with_admin)}
      context '正しいパラメータの場合' do
        before do
          @right_params = {firm: attributes_for(:firm, name: "test_firm")}
          @admin_header = {Authorization: "Bearer #{admin_hct.authentication_token}",Accept:'application/json'}
        end

        it 'ステータス２０1が返る' do
          post firms_path,params: @right_params, headers: @admin_header

          expect(response).to be_success
          expect(response).to have_http_status(201)
        end

        it 'test_firmという名前のactiveな企業が登録される' do
          post firms_path,params:  @right_params, headers: @admin_header

          json = JSON.parse(response.body)
          expect(json["name"]).to eq "test_firm"
          expect(json["active"]).to be_truthy
        end

        it 'firmが一件増える' do
          expect {
            post firms_path, params: @right_params, headers: @admin_header
          }.to change{Firm.count}.by(1)
        end
      end

      context 'nameが入っていないとき' do
        before do
          @wrong_params = {firm: attributes_for(:firm, name: "")}
          @admin_header = {Authorization: "Bearer #{admin_hct.authentication_token}"}
        end

        it 'ステータス422が返る' do
          post firms_path,params:  @wrong_params, headers: @admin_header

          expect(response).not_to be_success
          expect(response).to have_http_status(422)
        end

        it 'エラーメッセージが返る' do
          post firms_path, params:  @wrong_params, headers: @admin_header

          json = JSON.parse(response.body)
          expect(json["name"]).to include "can't be blank"
        end

        it 'firmが増減しない' do
          expect {post firms_path, params:  @wrong_params, headers: @admin_header}.not_to change{Firm.count}
        end


      end

    end

    context '通常権限HCTの場合' do
      let(:normal_hct) {create(:hct)}
      before do
        @right_params = {firm: attributes_for(:firm)}
        @normal_header = {Authorization: "Bearer #{normal_hct.authentication_token}",Accept:'application/json'}
      end

      it 'ステータス401が返る' do
        post firms_path,params:  @right_params, headers: @normal_header
        expect(response).not_to be_success
        expect(response).to have_http_status(401)
      end

      it 'You are not authorized to access this page.が返る' do
        post firms_path ,params: @right_params, headers: @normal_header
        expect(response.body).to match "You are not authorized to access this page."
      end


    end

    context 'ヘッダーにTokenがない場合' do
      before do
        @right_params = {firm: attributes_for(:firm)}
        @non_auth_header = {Accept:'application/json'}
      end

      it 'ステータス401が返る' do
        post firms_path , params: @right_params,headers:   @non_auth_header
        expect(response).not_to be_success
        expect(response).to have_http_status(401)
      end

      it 'HTTP Token: Access denied.が返る' do
        post firms_path ,params: @right_params,headers: @non_auth_header
        expect(response.body).to match "HTTP Token: Access denied."
      end

    end

  end
end
