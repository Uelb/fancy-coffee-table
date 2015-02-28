class AddPicturesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pictures, :json
  end
end
