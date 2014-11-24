class AddTagsToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :tags, :string
  end
end
