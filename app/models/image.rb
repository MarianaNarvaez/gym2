class Image < ApplicationRecord
	belongs_to :user
#	after_create :save_users 

	def self.search(search)
  		where("nombre || ubicacion || autor LIKE ?", "%#{search}%")
	end 

	#def users=(value)
	#	@users = value
		
	#end

	#def save_users
	#	@users.each do |user_id|
	#		HasCategory.create(user_id: user_id, image_id: self.id)
	#	end
	#end

end
