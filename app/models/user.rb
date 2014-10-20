class User < ActiveRecord::Base
  has_many :donations
  has_many :nonprofits, through: :donations	
  has_many :topics
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
