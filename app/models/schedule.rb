class Schedule < ApplicationRecord
  has_many :reservations
  has_many :time_slots

  # staff_id, start_time, end_time でユニーク制約
  validates :staff_id, uniqueness: { scope: [:start_time, :end_time] }

  after_create :create_time_slots

  # このスケジュール内に予約を作る
  def create_reservation(start_time, duration)
    end_time = start_time + duration

    # トランザクション
    ActiveRecord::Base.transaction do
      base_slot = time_slots.where('start_time <= ? AND ? <= end_time', start_time, end_time).where(reserved: false).first!

      reserved_slot = time_slots.create!(start_time: start_time, end_time: end_time, reserved: true)

      if end_time != base_slot.end_time
        time_slots.create!(start_time: end_time, end_time: base_slot.end_time)
      end

      if start_time == base_slot.start_time
        base_slot.destroy!
      else
        base_slot.update!(end_time: start_time)
      end

      reserved_slot
    end
  end

  private

  def create_time_slots
    # 最初に同じサイズのタイムスロットを作成する
    time_slots.create(start_time: start_time, end_time: end_time)
  end
end
