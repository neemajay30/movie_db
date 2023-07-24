class Location < ApplicationRecord
  validates :name, presence: true

  belongs_to :country
  has_and_belongs_to_many :movies
end
