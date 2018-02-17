
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # トークンによる認証
  before_action :authenticate_user_from_token!



  def current_ability
    @current_ability ||= Ability.new(current_hct)
  end


  # 権限無しのリソースにアクセスしようとした場合
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render json: {message: exception.message}, status: :unauthorized }
    end
  end

  # トークンによる認証
  def authenticate_user_from_token!
    authenticate_or_request_with_http_token do |token, options|
      hct = Hct.find_by_authentication_token(token)

      #タイミング攻撃対策
      if hct && Devise.secure_compare(hct.authentication_token, token)
        sign_in hct, store: false
      end

      hct.present?
    end
  end
end
