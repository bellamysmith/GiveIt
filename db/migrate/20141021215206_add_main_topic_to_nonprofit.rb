class AddMainTopicToNonprofit < ActiveRecord::Migration
  def change
  	add_column :nonprofits, :main_topic, :integer
  end
end
