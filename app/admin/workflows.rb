ActiveAdmin.register Workflow do
  index do
    column :id
    column :user
    column :name
    column :taverna_workflow_file_name
    column :created_at
    column :updated_at
    default_actions
  end
end
