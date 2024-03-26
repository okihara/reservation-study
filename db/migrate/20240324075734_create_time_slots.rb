class CreateTimeSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :time_slots do |t|
      t.references :schedule, null: false
      t.bigint :user_id
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.boolean :reserved, null: false, default: false

      t.timestamps
    end
  end
end
