class Bulletin < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :draft, default: true
    state :under_moderation
    state :rejected
    state :published
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :archive do
      transitions from: %i[draft under_moderation rejected published], to: :archived
    end
  end
  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg'].freeze

  has_one_attached :image

  belongs_to :user
  belongs_to :category

  validates :image, attached: true, size: { less_than: 5.megabytes }, content_type: ACCEPTED_CONTENT_TYPES
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
end
