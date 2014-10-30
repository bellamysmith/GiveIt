class Nonprofit < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :donations
  has_many :users, through: :donations
  has_many :topicJunctionTables
  has_many :topics, through: :topicJunctionTables
  devise :omniauthable, :omniauth_providers => [:stripe_connect]
  validates_presence_of :oauth
  

  def main
  	Topic.find(self.main_topic.to_i).topic
  end
  def self.from_omniauth(auth)

  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    binding.pry
    user.email = rand(6).to_s + '@example.com'
    user.password = Devise.friendly_token[0,20]
    user.name = "Unknown" # assuming the user model has a name
    user.main_topic = Topic.first.id
    user.oauth = auth.credentials.token
    user.publishable_key = auth.extra.raw_info.stripe_publishable_key

  end
end


end
