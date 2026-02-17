class User < ApplicationRecord

  has_secure_password # this is a class function from ActiveModel
  # it depends on bcrypt for hash generation

  self.primary_key = "user_id"
  before_create :assign_primarykey


  has_many :todos, foreign_key: :user_id, primary_key: :user_id, dependent: :destroy


  validates :email, presence: {message: "Email Id can't be empty"}, uniqueness: true
  validates :user_name , presence: {message: "Username cannot be empty"}, uniqueness: true

  # No validation is needed for password because
  # has_secure_password class method provies the default validations for password
  # No plain password is stored anywhere.
  # Plain password text will be automatically converted to hash and stored in db

  private
  def assign_primarykey
    # Assign random uuid value only when the user_id is nil. If not it will override existing uuid
    if user_id.nil?
      self.user_id = SecureRandom.uuid
    end
  end

end
