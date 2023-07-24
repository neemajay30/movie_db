class Movie < ApplicationRecord
  validates :name,
            :description,
            :year,
            presence: true

  validates :year, numericality: { only_integer: true }, length: { is: 4 }

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :locations
  belongs_to :director
  has_many :reviews
end
