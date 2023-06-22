require 'faker'

puts 'Creating Users'

3.times do
  User.create(nickname: Faker::Name.unique.name)
end

puts 'Creating Events'

5.times do
  start_time = Faker::Time.forward(days: 5, period: :evening, format: :long)
  end_time = Faker::Time.forward(days: 5, period: :evening, format: :long)

  while end_time <= start_time
    end_time = Faker::Time.forward(days: 5, period: :evening, format: :long)
  end

  event = Event.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    #start_time: Faker::Time.between_dates(from: DateTime.now, to: DateTime.now + 30, format: :long),
    #end_time: Faker::Time.between_dates(from: DateTime.now + 31, to: DateTime.now + 60, format: :long),
    start_time: start_time,
    end_time: end_time,
    address: Faker::Address.full_address,
    user: User.all.sample
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
