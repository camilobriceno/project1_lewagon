class Task < ApplicationRecord
  belongs_to :group
  validates :group, presence: true
  default_scope -> { order('created_at DESC') }
  scope :completed, -> { where(completed: true) }
  scope :incomplete,-> { where(completed: false) }


  include PgSearch::Model
  pg_search_scope :search_by_task_and_name,
    against: [ :name, :assigned_to_id ],
    using: {
      tsearch: { prefix: true }, # <-- now `superman batm` will return something!
}

end
