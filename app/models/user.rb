class User < ActiveRecord::Base
  has_secure_password

  has_many :products
  has_many :products_sold,through: :transaction,source: :product
  has_many :transactions, dependent: :destroy

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name,:last_name,presence:true
  validates :email,presence:true,format:{with:EMAIL_REGEX},uniqueness:{case_sensitive:false}
  validates :password,presence:true,on: :update, allow_blank: true
  validates_length_of :password, minimum: 6


end
