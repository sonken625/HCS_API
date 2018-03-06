class Hct < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:authentication_keys=>[]
  devise :recoverable, :rememberable, :trackable

  validates :authentication_token, uniqueness: true
  before_create :generate_authentication_token

  has_many :request_messages

  belongs_to :firm
  enum role: {normal: 0, admin: 1 }
  def generate_authentication_token
    loop do
      token = SecureRandom.urlsafe_base64(24).tr('lIO0', 'sxyz')
      unless Hct.exists?(authentication_token: token)
        self.authentication_token = token
        break
      end
    end
  end

  # 認証トークンの更新
  def update_authentication_token
    loop do
      old_token = self.authentication_token
      token = SecureRandom.urlsafe_base64(24).tr('lIO0', 'sxyz')
      next if(old_token==token)
      break token if(self.update!(authentication_token: token) rescue false)
    end
  end

  def delete_authentication_token
    self.update(authentication_token: nil)
  end


end
