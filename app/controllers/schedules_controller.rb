class SchedulesController < ApplicationController

  def home

  end

  def index
    @staff = Staff.find(params[:staff_id])
    @today = Time.zone.today # + 10.hours # 10:00 から表示
    @schedules = @staff.schedules.where('date >= ?', @today)
    @time_slots = @schedules.map { |s| s.time_slots.order(:start_time) }.flatten
  end

  def search
    search_start_time = Time.zone.today + 15.5.hours
    search_end_time = search_start_time + 4.hours

    # 希望した開始日時より、スタートが同じか早いタイムスロットを取得
    # 希望した終了日時より、エンドがちょうどか遅いタイムスロットを取得
    @time_slots = Schedule.search(search_start_time, search_end_time, 90)

    @search_start_time = search_start_time
  end

  def confirm

  end
end
