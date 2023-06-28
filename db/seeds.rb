require 'faker'

puts 'Creating Users'

users = []

5.times do
  user = User.create(nickname: Faker::Name.unique.name, for_hire: [true, false].sample)
  users << user
end


puts 'Creating Events'

categories = ['food', 'music', 'sports', 'nightlife', 'art']

8.times do
  category = categories.sample
  start_time = Faker::Time.forward(days: 5, period: :evening, format: :long)
  end_time = Faker::Time.forward(days: 5, period: :evening, format: :long)

  while end_time <= start_time
    end_time = Faker::Time.forward(days: 5, period: :evening, format: :long)
  end

  title = Faker::TvShows::BigBangTheory.quote[0, 50] # Limit title to 50 characters
  description = Faker::Lorem.paragraph(sentence_count: 5, supplemental: false, random_sentences_to_add: 4)[0, 300] # Limit description to 200 characters

  user = users.sample

  event = Event.create(
    title: title,
    description: description,
    start_time: start_time,
    end_time: end_time,
    address: Faker::Address.full_address,
    user: user,
    category: category
  )

  if event.save
    p "Event '#{event.id}' created successfully by User '#{user.id}'"
  else
    p "Error creating event: #{event.errors.full_messages.join(', ')}"
  end
end

puts 'Creating Bookings'

7.times do
  user = users.sample
  event = Event.all.sample

  booking = Booking.create(
    user: user,
    event: event
  )

  if booking.save
    p "Booking created successfully: User '#{user.id}' booked Event '#{event.id}'"
  else
    p "Error creating booking: #{booking.errors.full_messages.join(', ')}"
  end
end
