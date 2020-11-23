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


  #google認証関連-----------------------------------------------
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

  
  #フレンド関連のメソッド---------------------------------------
  #ハートを押す
  def follow(other_user)
    following_relationships.create(following_id: other_user.id)
  end

  #ハートを解除する
  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  #ログイン中のユーザーにハートを押されているか
  def follower?(other_user)
    follower_relationships.find_by(follower_id: other_user.id)
  end

  #ログイン中のユーザーに対してハートを押しているか
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  #友達判定
  def matchers
    followings & followers
  end

  #ログイン中のユーザーから一方的にハートを押されているユーザーを取得(フレンド申請中)
  def oneway_followers
    followers - (followings & followers)
  end

  #ログイン中のユーザーに対して一方的にハートを押しているユーザー(フレンド回答待ち)
  def oneway_followings
    followings - (followings & followers)
  end
  
end
