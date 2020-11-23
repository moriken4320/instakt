class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_one_attached :image

  validates :name, :email, :provider, :uid, :image, presence: true
  validates :name, length: {maximum:10}

  def self.from_omniauth(auth)
    #パスワードを自動生成
    pass = Devise.friendly_token
    #該当のユーザーが存在すればそのままログイン、しなければ作成してログイン
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_initialize(
      name: auth.info.name, email: auth.info.email, password: pass, password_confirmation: pass, provider: auth.provider, uid: auth.uid
    )
    unless user.persisted?
      image = open(auth.info.image)
      user.image.attach(io: image, filename: "#{auth.info.name}.png")
      user.save
    end
    user
  end

  

  #フレンド関連のメソッド
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def matchers #友達判定
    followings & followers
  end
end
