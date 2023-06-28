show.json.jbuilder
json.extract! @user, :id, :nickname, :for_hire

json.booked_events @booked_events

json.organized_events @user.events.joins(:bookings) do |event|
 json.id event.id
 json.title event.title
 json.start_time event.start_time.strftime('%b %e, %l:%M %p')
 json.end_time event.end_time.strftime('%b %e, %l:%M %p')
 json.address event.address
 json.bookings_count event.bookings.count
 json.total_bookings_count event.bookings.sum(:quantity)
end


json.organizer do
  json.extract! @event.user, :id, :nickname
end
