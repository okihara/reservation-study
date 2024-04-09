class StaffsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_staff, only: %i[ show edit update destroy ]

  def import
    staffs = params[:staffs]

    if staffs.present?
      staffs.each do |staff_params|
        staff = Staff.find_or_initialize_by(staff_id: staff_params[:id])
        if staff.new_record?
          staff.update!(staff_params.permit(:age, :name, :op, :size, category: staff_params[:type]))
        end

        # あんぷり固有になっている
        m, d = staff_params[:work_date].gsub(/\(.*\)/, '').split('/')
        logger.debug([staff_params[:work_date], m, d])
        start_time, end_time = staff_params[:syukkin].split(' - ')
        time_current_strftime = Time.current.strftime("%Y-#{m}-#{d}")
        start_date = "#{time_current_strftime} #{start_time}"
        end_date = "#{time_current_strftime} #{end_time}"

        logger.debug(start_date)
        staff.create_schedule(Time.zone.parse(start_date), Time.zone.parse(end_date))
      end

      render json: { message: 'Staffs imported successfully' }, status: :created
    else
      render json: { error: 'No staff data provided' }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_staff
    @staff = Staff.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def staff_params
    params.fetch(:staff, {})
  end
end
