class AddPublishableToNoprofits < ActiveRecord::Migration
  def change
  	add_column :nonprofits, :publishable_key, :string
  end
end
