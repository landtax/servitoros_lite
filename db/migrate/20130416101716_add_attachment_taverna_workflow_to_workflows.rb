class AddAttachmentTavernaWorkflowToWorkflows < ActiveRecord::Migration
  def self.up
    change_table :workflows do |t|
      t.attachment :taverna_workflow
    end
  end

  def self.down
    drop_attached_file :workflows, :taverna_workflow
  end
end
