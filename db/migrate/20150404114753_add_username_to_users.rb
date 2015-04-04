class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    remove_column :users, :firstname, :string
    remove_column :users, :lastname, :string
    add_column :users, :authentication_token, :string
  end
end
