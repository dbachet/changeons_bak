# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# creates the first admin user 
u = User.new(:email => "admin@changeons.org", :password => "adminadmin", :role => "admin")
u.skip_confirmation!
u.save(false)