# == Schema Information
#
# Table name: schedules
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  end_time   :datetime         not null
#  start_time :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  staff_id   :bigint           not null
#
# Indexes
#
#  index_schedules_on_staff_id  (staff_id)
#
class Schedule < ApplicationRecord
  belongs_to :staff
  has_many :reservations
  has_many :time_slots

  # staff_id, start_time, end_time でユニーク制約
  validates :staff_id, uniqueness: { scope: [:start_time, :end_time] }

  after_create :create_time_slots

  # def self.search(search_start_time, search_end_time, duration = 90)
  def self.search(search_start_time, _search_end_time, duration = 90)
    TimeSlot.where(reserved: false)
            .where('(end_time - INTERVAL ? MINUTE) >= start_time', duration) # 90 分以上の予約かどうか
            .where('(end_time - INTERVAL ? MINUTE) >= ?', duration, search_start_time)
            # .where('(end_time - INTERVAL ? MINUTE) <= ?', duration, search_end_time)
            .group_by(&:schedule_id)
  end

  # このスケジュール内に予約を作る
  def create_reservation(start_time, duration)
    end_time = start_time + duration

    # トランザクション
    ActiveRecord::Base.transaction do
      base_slot = time_slots.where('start_time <= ? AND end_time >= ?', start_time, end_time).where(reserved: false).first!

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
