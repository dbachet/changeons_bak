# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# creates the first admin user 
u = User.find_or_create_by_email(:email => "admin@changeons.org", :password => "adminadmin", :role => "admin")
u.skip_confirmation!
u.save(false)

c = Category.find_or_create_by_name(:name => "Informatique")
c.save

t = PostType.find_or_create_by_name(:name => "Article")
t.save