class AddNameAndDescriptionToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :name, :string
    add_column :executions, :description, :text
  end
end
