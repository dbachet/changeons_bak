# # -*- encoding : utf-8 -*-
# # load the libraries
# require 'aws'
# # log requests using the default rails logger
# AWS.config(:logger => Rails.logger)
# # load credentials from a file
# config_path = File.expand_path(File.dirname(__FILE__)+"/../aws.yml")
# # AWS.config(YAML.load(File.read(config_path)))
# 
# AWS_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/aws.yml")