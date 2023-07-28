class CreateFixedCosts < ActiveRecord::Migration[7.0]
  def change
    create_table :fixed_costs do |t|
      t.string :name
      t.integer :price
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
