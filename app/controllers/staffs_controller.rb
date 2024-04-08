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

        start_time, end_time = staff_params[:syukkin].split(' - ')
        start_date = "#{Time.current.strftime("%Y-%m-%d")} #{start_time}"
        end_date = "#{Time.current.strftime("%Y-%m-%d")} #{end_time}"

        staff.create_schedule(DateTime.parse(start_date), DateTime.parse(end_date))
      end

      render json: { message: 'Staffs imported successfully' }, status: :created
    else
      render json: { error: 'No staff data provided' }, status: :unprocessable_entity
    end
  end

  # GET /staffs or /staffs.json
  def index
    start_time = Time.current
    end_time = start_time + 23.hours
    today_schedule = Schedule.where('date >= ? AND date <= ?', start_time.strftime('%Y-%m-%d'), end_time.strftime('%Y-%m-%d')).order(:start_time)
    @staffs = today_schedule.map(&:staff).uniq
  end

  # GET /staffs/1 or /staffs/1.json
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs or /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to staff_url(@staff), notice: "Staff was successfully created." }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1 or /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to staff_url(@staff), notice: "Staff was successfully updated." }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1 or /staffs/1.json
  def destroy
    @staff.destroy

    respond_to do |format|
      format.html { redirect_to staffs_url, notice: "Staff was successfully destroyed." }
      format.json { head :no_content }
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
