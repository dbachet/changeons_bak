# -*- encoding : utf-8 -*-
class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :path => "/ckeditor_assets/attachments/:id/:filename",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :url  => ":s3_eu_url"
  
  validates_attachment_size :data, :less_than => 100.megabytes
  validates_attachment_presence :data
	
	def url_thumb
	  @url_thumb ||= begin
	    extname = File.extname(filename).gsub(/^\./, '')
      "/javascripts/ckeditor/filebrowser/images/thumbs/#{extname}.gif"
	  end
	end
end
