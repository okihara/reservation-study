class Staff < ApplicationRecord
  has_many :schedules
  def create_schedule(start_time, end_time)
    Schedule.create!(date:start_time, staff_id: id, start_time: start_time, end_time: end_time)
  end

  def image_url
    # "/images/987SCHE.jpg"
  end
end
