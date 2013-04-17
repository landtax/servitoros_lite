class AddWorkflowToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :workflow_id, :integer
  end
end
