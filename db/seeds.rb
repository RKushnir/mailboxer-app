# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def seed(msg)
  time_start = Time.now
  print msg
  yield
  puts " #{(Time.now - time_start).seconds}"
end

password = ENV['MAILBOXER_APP_PASSWORD']
if password.blank?
  puts 'MAILBOXER_APP_PASSWORD is not set, please use: `MAILBOXER_APP_PASSWORD=secret rake db:seed`'
  exit
end

seed('Creating users...') do
  User.transaction do
    10.times do |i|
      user = User.create(
        email: "user#{i}@example.com",
        password: password,
        password_confirmation: password
      )

      raise user.errors.full_messages.join("\n") if user.errors.any?
    end
  end
end

puts 'Done.'
