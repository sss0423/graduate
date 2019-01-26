class Memo < ApplicationRecord
  mount_uploader :icon, IconUploader
  validates:title, presence:true
  validates:content, presence:true
end
