class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :name, :email, :password, :provider, :uid, presence: true


  def self.from_omniauth(auth)
    #パスワードを自動生成
    pass = Devise.friendly_token

    #該当のユーザーが存在すればそのままログイン、しなければ作成してログイン
    user = User.where(name: auth.info.name, email: auth.info.email, provider: auth.provider, uid: auth.uid).first_or_create(
      name: auth.info.name, email: auth.info.email, password: pass, password_confirmation: pass, provider: auth.provider, uid: auth.uid
    )
  end
end
