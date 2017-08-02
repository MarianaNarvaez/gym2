class ImagesController < ApplicationController
	#GET 
	def index
  		@images = Image.all
  		if params[:search]
    		@images = Image.search(params[:search])
  		else
    		@images = Image.all.order('created_at DESC')
  		end
	end	

	#GET
	def show
		@image = Image.find(params[:id])
	end

	#GET
	def new
		@image = Image.new
		#
		@users = User.all
	end

	#POST
	def create
		@image = current_user.images.new(image_params)
		@image.users = params[:users]
		if @image.save
			redirect_to @image
		else
			render :new
		end	
	end

	#DELETE
	def destroy
		@image = Image.find(params[:id])
		@image.destroy
		redirect_to image_path 
	end

	def edit
		@image = Image.find(params[:id])
	end

	#UPDATE
	def update
		@image = Image.find(params[:id])
		if @image.update(image_params)
			redirect_to @image
		else
			render :edit
		end	
	end

	private

	def image_params
		params.require(:image).permit(:nombre,:ubicacion,:fecha,:autor, :peso, :users)
	end
end
