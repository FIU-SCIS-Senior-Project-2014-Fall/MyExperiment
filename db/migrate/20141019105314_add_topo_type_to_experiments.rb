class AddTopoTypeToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :topoType, :Integer
    remove_column :experiments, :type
  end
end
