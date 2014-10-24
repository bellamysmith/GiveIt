class User < ActiveRecord::Base
  has_many :donations
  has_many :nonprofits, through: :donations	
  has_many :topicJunctionTables
  has_many :topics, through: :topicJunctionTables
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :omniauthable, :omniauth_providers => [:stripe_connect]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #THIS SHOULD BE IN THE NONPROFIT MODEL! 
  def interested 
  	nonprofits = []
  	self.topics.each do |a|
  	  TopicJunctionTable.where(topic_id: a.id).where.not(nonprofit_id: nil).each do |a|
  	  	nonprofit = Nonprofit.find(a.nonprofit_id)
        if nonprofits != [] && nonprofits.include?(nonprofit) == false
  	  	  nonprofits << nonprofit
        elsif nonprofits == []
          nonprofits << nonprofit 
        end
  	  end
  	end
  	return nonprofits

  end      

end
