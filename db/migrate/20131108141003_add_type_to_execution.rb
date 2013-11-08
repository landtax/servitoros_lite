class AddTypeToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :type, :string
  end
end
