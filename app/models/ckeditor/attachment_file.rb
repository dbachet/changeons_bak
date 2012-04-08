# -*- encoding : utf-8 -*-
class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :path => "/ckeditor_assets/attachments/:id/:filename",
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root.to_s}/config/s3.yml"# ,
                    #                     :url  => ":s3_eu_url"
  
  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data
	
	def url_thumb
	  @url_thumb ||= Ckeditor::Utils.filethumb(filename)
	end
end