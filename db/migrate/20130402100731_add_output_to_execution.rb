class AddOutputToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :results, :text
  end
end
