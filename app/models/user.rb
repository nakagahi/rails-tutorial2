class User < ApplicationRecord

  attr_accessor :remember_token, :activation_token, :reset_token

  # before_save {self.email = self.email.downcase}
  before_save   :email_downcase

  before_create :create_activation_digest

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}

  validates :email, presence: true, length: {maximum: 255},
   format: {with: VALID_EMAIL_REGEX}, uniqueness: true

   validates :password, length: {minimum: 6}, presence: true, allow_nil: true

  has_many :microposts, dependent: :destroy


   has_secure_password

   # 渡された文字列をハッシュ化して返す
   def User.digest(string)

     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                              BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost)

   end

   # ランダムなトークンを返す
   def User.new_token

     SecureRandom.urlsafe_base64

   end


   def remember

     self.remember_token = User.new_token

     update_attribute(:remember_digest, User.digest(self.remember_token))

   end

   def authenticated?(attribute, token)

     digest = self.send("#{attribute}_digest")

     return false if digest.nil?

     BCrypt::Password.new(digest).is_password?(token)
   end

   def forget
     self.update_attribute(:remember_digest, nil)
   end

   def create_reset_digest

     self.reset_token = User.new_token

     update_attribute(:reset_digest, User.digest(reset_token))

     update_attribute(:reset_sent_at, Time.zone.now)

   end


   def send_reset_digest_email

     UserMailer.password_reset(self).deliver_now

   end


   def password_reset_expired?
     reset_sent_at < 2.hours.ago
   end

   def feed

     Micropost.where("user_id=?", self.id)

   end

   private



   def create_activation_digest

     # 有効化トークンとダイジェストを作成及び代入する
     self.activation_token = User.new_token

     self.activation_digest = User.digest(self.activation_token)


   end


   def email_downcase

     self.email = self.email.downcase

   end








end
