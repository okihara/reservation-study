# スタッフの勤務時間を表すクラス
class Schedule
  include ActiveModel::Model

  attr_accessor :staff_id, :date, :start_time, :end_time

  def save
    return false if invalid?
    schedule = Staff::Schedule.new(
      staff_id: staff_id,
      date: date,
      start_time: start_time,
      end_time: end_time
    )
    schedule.save
  end

  def invalid?
    return true if staff_id.nil?
    return true if date.nil?
    return true if start_time.nil?
    return true if end_time.nil?
    return true if start_time > end_time
    false
  end
end
