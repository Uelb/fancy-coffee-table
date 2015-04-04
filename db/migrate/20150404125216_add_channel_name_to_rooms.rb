class AddChannelNameToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :channel_name, :string
  end
end
