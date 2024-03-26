class TimeSlot < ApplicationRecord
  belongs_to :schedule

  def can_reserve?(time)
    !reserved && includes_time?(time)
  end

  def includes_time?(time)
    start_time <= time && time < end_time
  end

  def duration
    (end_time - start_time)
  end
end
