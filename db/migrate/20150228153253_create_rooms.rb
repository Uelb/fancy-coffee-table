class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.references :first_user, index: true
      t.references :second_user, index: true
      t.boolean :displayed_for_first_user, null: false, default: true
      t.boolean :displayed_for_second_user, null: false, default: true
      t.boolean :first_user_profile_displayed, null: false, default: false
      t.boolean :second_user_profile_displayed, null: false, default: false
      t.timestamps
    end
  end
end
