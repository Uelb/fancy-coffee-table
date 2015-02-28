class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :reviewer, index: true
      t.references :reviewed_user, index: true
      t.integer :score, size: 1, null: false

      t.timestamps
    end
  end
end
