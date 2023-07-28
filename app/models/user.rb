class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, through: :groups,  through: :multiple_groups
  has_many :fixed_costs, through: :groups

  validates :first_name, presence: true

  belongs_to :group,  optional: true

  has_one_attached :photo
  has_many :groups, through: :multiple_groups
  # has_many :properties, :class_name => "Group", :foreign_key => "owner_id"  # This is the dwellings the user owns
end
