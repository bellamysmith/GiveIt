class TopicJunctionTable < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  belongs_to :nonprofit
end
