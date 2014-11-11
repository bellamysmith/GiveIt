class Nonprofit < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :donations
  has_many :users, through: :donations
  has_many :topicJunctionTables
  has_many :topics, through: :topicJunctionTables

  

  def main
  	Topic.find(self.main_topic.to_i).topic
  end
  



end
