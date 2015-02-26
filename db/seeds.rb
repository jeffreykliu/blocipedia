require 'faker'

# Create Users
5.times do 
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

# Note: by calling 'User.new' instead of 'create',
# we create an instance of User which isn't immediately saved to the database.

# The 'skip_confirmation!' method sets the 'confirmed_at' attribute
# to avoid the triggering an confirmation email when the User is saved.

# The 'save' method then saves this User to the database.

# Create Wikis
25.times do
  Wiki.create!(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
    )
end
wikis = Wiki.all


# Create an admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save!

# Create a premium member
premium = User.new(
  name:     'Premium User',
  email:    'premium@example.com',
  password: 'helloworld',
  role:     'premium'
)
premium.skip_confirmation!
premium.save!

# Create a standard (free) member
standard = User.new(
  name:     'Standard User',
  email:    'standard@example.com',
  password: 'helloworld'
  )
standard.skip_confirmation!
standard.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"