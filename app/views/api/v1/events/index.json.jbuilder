json.events @events do |event|
  json.extract! event, :id, :title, :description, :address, :user_id, :category
  json.start_time event.start_time.strftime('%b %e, %l:%M %p')
  json.end_time event.end_time.strftime('%b %e, %l:%M %p')
  json.address event.address.truncate(30, omission: '...')
  json.bookings_count event.bookings.count
  json.bookings event.bookings

  json.has_booking event.bookings.exists?(user_id: 1)
end
