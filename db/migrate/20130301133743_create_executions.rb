class CreateExecutions < ActiveRecord::Migration
  def change
    create_table :executions do |t|

      t.string :taverna_id
      t.integer :status, :default => 1
      t.text :input_parameters
      t.references :user
      t.timestamps
    end
  end
end
