class Staff < ApplicationRecord
  def create_schedule(start_time, end_time)
    Schedule.create!(date:'2023-01-01', staff_id: id, start_time: start_time, end_time: end_time)
  end
end
