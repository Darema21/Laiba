json.extract! @user, :id, :nickname, :for_hire
json.events_created_count @user.events.count
json.bookings_count @user.bookings.count

  json.id @event.id
  json.title @event.title
  json.start_time @event.start_time.strftime('%b %e, %l:%M %p')
  json.end_time @event.end_time.strftime('%b %e, %l:%M %p')
  json.address @event.address
  json.bookings_count @event.bookings.count
  json.total_bookings_count @user.events.joins(:booking).count



  json.id @booking.id
    json.id @booking.event.id
    json.title @booking.event.title
    json.start_time @booking.event.start_time.strftime('%b %e, %l:%M %p')
    json.end_time @booking.event.end_time.strftime('%b %e, %l:%M %p')
    json.address @booking.event.address
