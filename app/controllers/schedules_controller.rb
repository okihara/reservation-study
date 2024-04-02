class SchedulesController < ApplicationController
  def index
    @staff = Staff.find(params[:staff_id])
    today = '2023-01-01'
    @schedules = @staff.schedules.where('date >= ?', today)
    @time_slots = @schedules.map { |s| s.time_slots.order(:start_time) }.flatten
  end

  def search
    search_start_time = DateTime.parse("2023-01-01 15:30:00")
    search_end_time = search_start_time + 90.minutes

    # 希望した開始日時より、スタートが同じか早いタイムスロットを取得
    # 希望した終了日時より、エンドがちょうどか遅いタイムスロットを取得
    @time_slots = Schedule.search

    @search_start_time = search_start_time
  end

  def confirm

  end
end
