# == Schema Information
#
# Table name: staffs
#
#  id         :bigint           not null, primary key
#  age        :integer
#  category   :string(255)
#  name       :string(255)      not null
#  op         :string(255)
#  photo_name :string(255)
#  size       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  staff_id   :string(255)      not null
#
class Staff < ApplicationRecord
  has_many :schedules
  def create_schedule(start_time, end_time)
    Schedule.find_or_create_by!(date:start_time, staff_id: id, start_time: start_time, end_time: end_time)
  end

  def image_url
    "/images/#{photo_name}"
  end
end
