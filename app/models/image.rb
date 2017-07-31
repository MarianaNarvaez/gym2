class Image < ApplicationRecord
	belongs_to :user

	def self.search(search)
  		where("nombre || ubicacion || autor LIKE ?", "%#{search}%")
	end
end
