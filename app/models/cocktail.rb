class Cocktail < ApplicationRecord
  mount_uploader :photo, PhotoUploader

  has_many :doses, dependent: :destroy
  has_many :ingredients, :through => :doses
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :instruction, presence: true
  validates :photo, presence: true
end
