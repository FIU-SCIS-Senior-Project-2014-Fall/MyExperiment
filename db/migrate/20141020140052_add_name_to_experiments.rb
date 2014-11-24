class AddNameToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :name, :string
  end
end
