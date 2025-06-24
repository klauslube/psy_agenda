class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.references :psychologist, null: false, foreign_key: { to_table: :users }
      t.references :patient, null: false, foreign_key: { to_table: :users }
      t.datetime :start_session
      t.datetime :end_session
      t.string :status

      t.timestamps
    end
  end
end
