class Image < ActiveRecord::Base
  belongs_to :myad
  mount_uploader :url, FileUploader
end
