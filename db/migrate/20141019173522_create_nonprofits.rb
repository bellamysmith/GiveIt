class CreateNonprofits < ActiveRecord::Migration
  def change
    create_table :nonprofits do |t|
      t.string :name
      t.string :website
      t.string :city
      t.string :state
      t.string :phone
      t.text :description
      t.string :main_topic
      t.string :uuid
      t.string :ein
      t.string :logo

      t.timestamps
    end
  end
end
