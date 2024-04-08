# == Schema Information
#
# Table name: time_slots
#
#  id          :bigint           not null, primary key
#  end_time    :datetime         not null
#  reserved    :boolean          default(FALSE), not null
#  start_time  :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  schedule_id :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_time_slots_on_schedule_id  (schedule_id)
#
require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
