# スタッフの勤務時間を表すクラス
class Reservation
  include ActiveModel::Model

  attr_accessor :staff_id, :date, :start_time, :duration

  def includes_time?(time)
    start_time <= time && time < end_time
  end

  private

  def end_time
    start_time + duration * 60
  end
end
