class CreateStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :staffs do |t|
      t.string :staff_id, null: false
      t.string :name, null: false
      t.integer :age
      t.string :size
      t.string :category
      t.string :op
      t.timestamps
    end
  end
end
