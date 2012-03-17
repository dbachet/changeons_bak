# -*- encoding : utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# creates the first admin user 
u = User.find_or_create_by_email(:email => "admin@changeons.org", :password => "adminadmin", :role => "admin") { |u| u.skip_confirmation!}
u = User.find_or_create_by_email(:email => "newsletter@changeons.org", :password => "adminadmin", :role => "admin") { |u| u.skip_confirmation!}

c = Category.find_or_create_by_name(:name => "Informatique")

# t = PostType.find_or_create_by_name(:name => "Article")

# changeons_quoi_qui = Post.find_or_create_by_title(:title => "Changeons - Quoi / Qui ?", :content => "<p>La question est dans le titre. Ajoutez un commentaire pour répondre à la question, et il sera publié en page d'accueil du site !</p>", :post_type_id => PostType.find_by_name("Article"), :post_image => "<p>
  # <img alt='' src='/images/blur.png' style='width: 50px; height: 50px; opacity: 0.5; margin-left: 0px; '></p>", :short_description => "La question est dans le titre. Ajoutez un commentaire pour répondre à la question, et il sera publié en page d'accueil du site !") { |p| p.user_id = User.find_by_email("admin@changeons.org").id, p.tag_list = "changeons", p.category_ids = [Category.find_by_name("Informatique")] }

# changeons_pourquoi = Post.find_or_create_by_title(:title => "Changeons - Pourquoi ?", :content => "<p>La question est dans le titre. Ajoutez un commentaire pour répondre à la question, et il sera publié en page d'accueil du site !</p>", :post_type_id => PostType.find_by_name("Article"), :post_image => "<p>
  # <img alt='' src='/images/blur.png' style='width: 50px; height: 50px; opacity: 0.5; margin-left: 0px; '></p>", :short_description => "La question est dans le titre. Ajoutez un commentaire pour répondre à la question, et il sera publié en page d'accueil du site !") { |p| p.user_id = User.find_by_email("admin@changeons.org").id, p.tag_list = "changeons", p.category_ids = [Category.find_by_name("Informatique")] }

