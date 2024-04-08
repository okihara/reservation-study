class SchedulesController < ApplicationController

  def home

  end

  def index
    @staff = Staff.find(params[:staff_id])
    @today_str = Time.current.strftime('%Y-%m-%d')
    @schedules = @staff.schedules.where('date >= ?', @today_str)
    @time_slots = @schedules.map { |s| s.time_slots.order(:start_time) }.flatten
  end

  def search
    search_start_time = Time.current.strftime('%Y-%m-%d 15:30:00')
    search_end_time = Time.current.strftime('%Y-%m-%d 23:50:00')

    # 希望した開始日時より、スタートが同じか早いタイムスロットを取得
    # 希望した終了日時より、エンドがちょうどか遅いタイムスロットを取得
    @time_slots = Schedule.search(search_start_time, search_end_time, 90)

    @search_start_time = Time.parse(search_start_time)
  end

  def confirm

  end
end
