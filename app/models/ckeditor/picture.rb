# -*- encoding : utf-8 -*-
class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :path => "/ckeditor_assets/pictures/:id/:style_:basename.:extension",
	                  :styles => { :content => '800>', :thumb => '118x100#' },
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :url  => ":s3_eu_url"
	
	validates_attachment_size :data, :less_than => 2.megabytes
	validates_attachment_presence :data
	
	def url_content
	  url(:content)
	end
end
