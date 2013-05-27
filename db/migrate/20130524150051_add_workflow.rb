class AddWorkflow < ActiveRecord::Migration
  def up
    Workflow.create(:name => "First Workflow", :description => "First workflow", :taverna_workflow => File.new(File.join(Rails.root, 'db', 'data', 'txt_corpus_freeling3_with_corpus_analysis_v01.t2flow')))
  end

  def down
    Workflow.destroy_all
  end
end
