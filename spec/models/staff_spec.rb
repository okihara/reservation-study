# == Schema Information
#
# Table name: staffs
#
#  id         :bigint           not null, primary key
#  age        :integer
#  category   :string(255)
#  name       :string(255)      not null
#  op         :string(255)
#  size       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  staff_id   :string(255)      not null
#
require 'rails_helper'

RSpec.describe Staff, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
