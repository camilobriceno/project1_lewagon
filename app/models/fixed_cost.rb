class FixedCost < ApplicationRecord
  belongs_to :group
  belongs_to :user


  def create_fa_icon
    case self.expense_type
    when "Internet"
      "fa-wifi"
    when "Subscription"
      "fa-film"
    when "Rent"
      "fa-people-roof"
    when "TV-Licence"
      "fa-tv"
    when "fa-fire"
    when "Electrcity"
    "fa-bolt"
    else
      "fa-shower"
    end
  end
end
