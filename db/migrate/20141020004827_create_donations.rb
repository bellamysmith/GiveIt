class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :amount
      t.references :user, index: true
      t.references :nonprofit, index: true
      t.timestamps
    end
  end
end
