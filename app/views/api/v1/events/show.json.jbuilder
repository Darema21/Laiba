    json.extract! @event, :id, :title, :description, :address, :user_id, :category
    json.start_time @event.start_time.strftime('%b %e, %l:%M %p')
    json.end_time @event.end_time.strftime('%b %e, %l:%M %p')
    json.bookings_count @event.bookings.count
    json.organizer do
      json.extract! @event.user, :id, :nickname
    end
