# == Schema Information
#
# Table name: time_slots
#
#  id          :bigint           not null, primary key
#  end_time    :datetime         not null
#  reserved    :boolean          default(FALSE), not null
#  start_time  :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  schedule_id :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_time_slots_on_schedule_id  (schedule_id)
#
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
      logger.debug("start_time: #{start_time}, #{start_time.class}, search_start_time: #{search_start_time}")
      start_time
    end.strftime("%m/%d %H:%M %z")
  end
end
