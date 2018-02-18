class Firm < ApplicationRecord
  has_many :hcts
  validates :name,presence: true
  validates :active ,presence: true
end
