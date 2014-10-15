class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end
