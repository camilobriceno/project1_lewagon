class ShoppingList < ApplicationRecord
  belongs_to :group, optional: true
  has_many :products, through: :bought_items
end
