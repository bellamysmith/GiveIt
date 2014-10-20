class CreateTopicJunctionTables < ActiveRecord::Migration
  def change
    create_table :topic_junction_tables do |t|
      t.references :user, index: true
      t.references :topic, index: true
      t.references :nonprofit, index: true

      t.timestamps
    end
  end
end
