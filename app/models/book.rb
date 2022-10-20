class Book < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(book) { "books" }, inserts_by: :prepend
end
