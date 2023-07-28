class CreateBoughtItems < ActiveRecord::Migration[7.0]
  def change
    create_table :bought_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shopping_list, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
