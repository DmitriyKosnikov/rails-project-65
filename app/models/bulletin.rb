class Bulletin < ApplicationRecord
  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg'].freeze

  has_one_attached :image

  belongs_to :user
  belongs_to :category

  validates :image, attached: true, size: { less_than: 5.megabytes }, content_type: ACCEPTED_CONTENT_TYPES
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
end
