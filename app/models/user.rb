class User < ApplicationRecord

  validates    :name,  presence:   true,   length: {maximum:  50}
  VALIDE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates    :email,  presence:   true,   length: {maximum:  150}, format:  {with:   VALIDE_EMAIL_REGEX},  uniqueness:  {case_sensitive:  false}
  has_secure_password()
  validates   :password, length:  {minimum:  8}   
end
