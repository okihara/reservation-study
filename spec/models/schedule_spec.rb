# == Schema Information
#
# Table name: reserve
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
require 'rails_helper'

RSpec.describe Schedule, type: :model do
  let(:schedule) do
    Schedule.create(
      staff_id: 1,
      date: "2023-01-01",
      start_time: "2023-01-01 14:00:00",
      end_time: "2023-01-01 16:20:00"
    )
  end

  describe 'create_time_slots' do
    it 'should create time slots' do
      expect(schedule.time_slots.count).to eq 1
      expect(schedule.time_slots.first.start_time).to eq Time.new(2023, 1, 1, 14, 0, 0)
      expect(schedule.time_slots.first.end_time).to eq Time.new(2023, 1, 1, 16, 20, 0)
    end
  end

  describe '#create_reservation' do
    it 'should create a reservation' do
      reservation = schedule.create_reservation(Time.new(2023, 1, 1, 14, 10, 0), 30.minutes)

      expect(reservation.start_time).to eq Time.new(2023, 1, 1, 14, 10, 0)
      expect(reservation.end_time).to eq Time.new(2023, 1, 1, 14, 40, 0)
      expect(reservation.duration).to eq 30.minutes
    end

    it '空のタイムスロットが２つできること' do
      schedule.create_reservation(Time.new(2023, 1, 1, 14, 20, 0), 30.minutes)

      time_slots = schedule.time_slots.order(:start_time)

      expect(time_slots.count).to eq 3
      expect(time_slots[0].start_time).to eq Time.new(2023, 1, 1, 14, 0, 0)
      expect(time_slots[0].end_time).to eq Time.new(2023, 1, 1, 14, 20, 0)
      expect(time_slots[1].start_time).to eq Time.new(2023, 1, 1, 14, 20, 0)
      expect(time_slots[1].end_time).to eq Time.new(2023, 1, 1, 14, 50, 0)
      expect(time_slots[2].start_time).to eq Time.new(2023, 1, 1, 14, 50, 0)
      expect(time_slots[2].end_time).to eq Time.new(2023, 1, 1, 16, 20, 0)
    end

    it '終了時間がちょうど取れる' do
      schedule.create_reservation(Time.new(2023, 1, 1, 14, 20, 0), 120.minutes)
      time_slots = schedule.time_slots.order(:start_time)
      expect(time_slots.count).to eq 2
    end

    it 'ちょうど取れる' do
      schedule.create_reservation(Time.new(2023, 1, 1, 14, 00, 0), 140.minutes)
      time_slots = schedule.time_slots.order(:start_time)
      expect(time_slots.count).to eq 1
    end

    it '空き枠がない場合失敗すること' do
      expect do
        schedule.create_reservation(Time.new(2023, 1, 1, 14, 20, 0), 130.minutes)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
