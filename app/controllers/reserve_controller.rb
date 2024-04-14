class ReserveController < ApplicationController
  def home

  end

  def schedule
    @staff = Staff.find(params[:staff_id])
    @today = Time.zone.today # + 10.hours # 10:00 から表示
    @schedules = @staff.schedules.where('date >= ?', @today)
    @time_slots = @schedules.map { |s| s.time_slots.order(:start_time) }.flatten
  end

  def search
    @start_time_from = params[:start_time_from]

    now = Time.zone.now
    search_time_from_now = Time.new(now.year, now.month, now.day, now.hour, (now.min / 10) * 10, 0, '+09:00') + 30.minutes

    search_start_time = if @start_time_from.present?
                          h, m = @start_time_from.split(':')
                          Time.new(now.year, now.month, now.day, h, m, 0, '+09:00')
                        else
                          @start_time_from = search_time_from_now.strftime('%H:%M')
                          search_time_from_now
                        end

    @select_array = []
    temp_time = search_time_from_now
    tomorrow = Time.zone.today + 24.hours
    while temp_time < tomorrow
      @select_array << temp_time.strftime('%H:%M')
      temp_time += 10.minutes # 10分刻み
    end

    # 希望した開始日時より、スタートが同じか早いタイムスロットを取得
    # 希望した終了日時より、エンドがちょうどか遅いタイムスロットを取得
    # @shop.search
    @time_slots = Schedule.search(search_start_time, nil, 90)

    @search_start_time = search_start_time
  end

  def staff_all
    @start_date = Time.zone.today
    @end_date = @start_date + 1.days
    @schedules = Schedule.where('date >= ? AND date <= ?', @start_date, @end_date).includes(:staff).order(:start_time)
    @staffs = @schedules.map(&:staff).uniq
  end

  def confirm
    @staff = Staff.find(params[:staff_id])
  end

  def create_reservation
    @staff = Staff.find(params[:staff_id])
    @duration = 90.minutes
    @schedule = @staff.schedules.find_by!(date: Time.zone.today)
    @schedule.create_reservation(Time.zone.parse(params[:start_time]), @duration)
    redirect_to '/'
  end
end
