class CreateNonprofits < ActiveRecord::Migration
  def change
    create_table :nonprofits do |t|
      t.string :name
      t.string :website
      t.string :city
      t.string :state
      t.string :phone
      t.string :description
      t.string :oauth

      t.timestamps
    end
  end
end
