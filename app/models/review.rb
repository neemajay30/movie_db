class Review < ApplicationRecord
  validates :comment, :stars, presence: true
  validates :stars, numericality: { only_integer: true }, length: { in: 0..5 }

  belongs_to :user
  belongs_to :movie
end
