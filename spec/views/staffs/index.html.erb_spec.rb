require 'rails_helper'

RSpec.describe "staffs/index", type: :view do
  before(:each) do
    assign(:staffs, [
      Staff.create!(),
      Staff.create!()
    ])
  end

  it "renders a list of staffs" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
