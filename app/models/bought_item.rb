class BoughtItem < ApplicationRecord
  belongs_to :user
  belongs_to :shopping_list
  belongs_to :product
end
