class AddAppointments < ActiveRecord::Migration[5.2]
  def change
  	create_table :appointments do |t|
      t.belongs_to :doctor
      t.belongs_to :patient
      t.datetime :appointment_date
      t.timestamps
  	end
  end
end
