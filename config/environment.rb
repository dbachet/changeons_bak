# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# Initialize the rails application
Changeons::Application.initialize!

# AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"