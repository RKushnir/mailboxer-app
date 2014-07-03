class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_messageable

  # You'd, probably, want to have a separate name column instead
  def name
    email
  end

  def mailboxer_email(object)
    email
  end
end
