class Group < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tasks
  has_many :multiple_groups
  has_one  :shopping_list
  # has_many :roomies, :class_name => "User"
  has_one_attached :photo

  include PgSearch::Model
  multisearchable against: [ :name, :description ]


  include PgSearch::Model
    pg_search_scope :search_by_group_and_description,
      against: [ :name, :description ],
      using: {
        tsearch: { prefix: true }, # <-- now `superman batm` will return something!
  }

  # include PgSearch::Model
  #   pg_search_scope :search_by_name, lambda { |name, query|
  #     raise ArgumentError unless [:name].include?(name)
  #     {
  #       against: name_part,
  #       query: query
  #     }
  #   }



end


# include PgSearch::Model
# pg_search_scope :search_by_name, lambda { |name_part, query|
#   raise ArgumentError unless [:first, :last].include?(name_part)
#   {
#     against: name_part,
#     query: query
#   }
# }
# end
