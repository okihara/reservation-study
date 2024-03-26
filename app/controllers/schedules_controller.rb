class SchedulesController < ApplicationController
  def index
    @staff = Staff.find(params[:staff_id])
    @schedules = @staff.schedules.where(date: "2024-01-01")
    @time_slots = @schedules.map { |s| s.time_slots.order(:start_time) }.flatten
  end
end
