class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.references :sender, index: true
      t.references :recipient, index: true
      t.references :room, index: true

      t.timestamps
    end
  end
end
