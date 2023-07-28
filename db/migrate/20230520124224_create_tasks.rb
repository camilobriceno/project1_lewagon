class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :assigned_to_id
      t.boolean :done
      t.boolean :urgent
      t.text :comments
      t.date :deadline
      t.date :recurrence
      t.boolean :recurring
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
