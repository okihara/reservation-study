class TimeSlot < ApplicationRecord
  belongs_to :schedule

  BOTTOM_RESERVE_MINUTES = 0

  def can_reserve?(time)
    return false if duration(time) / 60 < BOTTOM_RESERVE_MINUTES

    !reserved && includes_time?(time)
  end

  def includes_time?(time)
    start_time <= time && time < end_time
  end

  def duration(time = nil)
    (end_time - (time || start_time))
  end

  def actual_start_time(search_start_time)
    if start_time < search_start_time
      search_start_time
    else
      start_time
    end.strftime("%H:%M スタートで予約可能")
  end
end
