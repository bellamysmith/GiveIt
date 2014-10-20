class Nonprofit < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :donations
  has_many :users, through: :donations
  has_many :TopicJunctionTables
  has_many :topics, through: :TopicJunctionTables
end
