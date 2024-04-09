module ReserveHelper
  def confirm_path(staff_id, start_time)
    "/reserve/staff/#{staff_id}/confirm?start_time=#{start_time.strftime('%Y-%m-%d %H:%M')}"
  end
end
