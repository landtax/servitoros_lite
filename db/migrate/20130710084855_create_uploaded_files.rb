class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.string :name
      t.text :description
      t.references :user
      t.attachment :file

      t.timestamps
    end
  end
end
