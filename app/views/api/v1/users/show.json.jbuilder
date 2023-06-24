json.extract! @user, :id, :nickname
json.events_created_count @user.events.count
json.bookings_count @user.bookings.count
json.events_created @user.events do |event|
  json.id event.id
  json.title event.title
  json.start_time event.start_time.strftime('%b %e, %l:%M %p')
  json.start_time event.end_time.strftime('%b %e, %l:%M %p')
  json.address event.address
end
json.bookings @user.bookings do |booking|
  json.id booking.id
  json.event_id booking.event_id
end
