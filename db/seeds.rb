# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
AppConfig.roles.each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

puts 'DEFAULT USERS'
admin = User.new(
  username: 'admin',
  email: 'admin@cascadetechnologies.com',
  first_name: 'Admin', 
  last_name: 'User',
  password: '12345678',
  password_confirmation: '12345678'
)
admin.save!
admin.add_role :admin
puts 'user: ' << admin.full_name