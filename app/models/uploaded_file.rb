class UploadedFile < ActiveRecord::Base
  attr_accessible :description, :name, :file
  has_attached_file :file
  
  validates_attachment_presence :file
  validates :name, :presence => true
  belongs_to :user
end
