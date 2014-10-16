class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string  :type
      t.integer :nodes
      t.integer :user_id

      t.timestamps
    end
    add_index :experiments, [:user_id, :created_at]
  end
end
