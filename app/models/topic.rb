class Topic < ActiveRecord::Base
  has_many :TopicJunctionTables	
  has_many :users, through: :TopicJunctionTables
  has_many :nonprofits, through: :TopicJunctionTables
end
