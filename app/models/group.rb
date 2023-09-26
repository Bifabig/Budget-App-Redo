class Group < ApplicationRecord
  has_and_belongs_to_many :entities
  belongs_to :author, class_name: 'User'

  has_one_attached :icon

  validates :name, presence: true
  validates :icon, presence: true
end
