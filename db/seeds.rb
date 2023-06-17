require 'faker'

puts 'Creating Users'

users = Array.new(3) do
  User.create(nickname: Faker::Name.unique.name)
end

puts 'Creating Events'

5.times do
  event = Event.new(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    start_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30),
    end_time: Faker::Time.between(from: DateTime.now + 31, to: DateTime.now + 60),
    address: Faker::Address.full_address,
    user: User.all.sample  # Assign a random user as the event's user
  )

  if event.save
    p "Event '#{event.title}' created successfully"
  else
    p "Error creating event: #{event.errors.full_messages.join(', ')}"
  end
end

puts 'Creating Bookings'

10.times do
  Booking.create(
    user: User.all.sample,        # Assign a random user as the booking's user
    event: Event.all.sample       # Assign a random event as the booking's event
  )
end
