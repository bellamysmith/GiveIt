class AddColumnsToNonprofits < ActiveRecord::Migration
  def change
    add_column :nonprofits, :provider, :string
    add_column :nonprofits, :uid, :string
  end
end
