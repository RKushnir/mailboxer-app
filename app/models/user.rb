class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  def name
    email
  end
end
