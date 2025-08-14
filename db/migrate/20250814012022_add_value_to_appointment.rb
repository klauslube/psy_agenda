class AddValueToAppointment < ActiveRecord::Migration[7.2]
  def change
    add_column :appointments, :session_value, :decimal
  end
end
