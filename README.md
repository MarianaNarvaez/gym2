# GYM  

## By: Mariana Narvaez - mnarvae3@eafit.edu.co

# 1.Descripción de aplicación

Esta aplicación esta orientada a personas que practican actividades físicas, permitiendo a los diferentes usuarios logearse, subir y compartir imágenes que muestren el progreso que han tenido mientras realizan determinado ejercicio, con el fin de motivar tanto a otras personas como a ellos mismos para seguir trabajando en su entrenamiento personal y  asi mejorar su salud, autoestima, físico y energía.

La aplicación esta construida con el patron MVC. Utiliza un framework backend moderno -> Rails que permite logear usuarios, crear, editar, borrar imagenes, compartir y buscar contenido.


# 2. Análisis

## 2.1 Requisitos funcionales:

	* Registro de usuarios por medio del correo electronico y contraseña
	* Login de usuarios por medio del correo electronico y contraseña
	* Visualizacion de contenido propio al iniciar sesión.
	* Buscar contenido por nombre, ubicacion o autor al estar logeado.
	* Actualizar contenido.
	* Borrar Contenido.
	* Compartir contenido.
	* Visualizar contenido publico

## 2.2 Definición de tecnología de desarrollo y ejecución para la aplicación:

	* Lenguaje de Programación: Ruby 2.4.1
	* Framework web backend: Rails 5.1.1
	* Framework web frontend: no se usa - se utilizará *Templates HTML para Vista (V)
	* Base de datos: Postgres
	* Web App Server: Puma
	* Web Server: Apache web server

# 3. Ambiente de Desarrollo, Pruebas y Producción:

Para que los 3 ambientes funcionen correctamente se reealizaron las siguientes modificaciones en config/database.yml

	default: &default
	  adapter: postgresql
	  pool: 5
	  username: mari
	  password: 9611
	  host: localhost
	  port: 5432

	development:
	  database: mari
	  adapter: postgresql
	  pool: 5
	  username: mari
	  password: 9611
	  host: localhost

	test:
	  database: mari
	  adapter: postgresql
	  pool: 5
	  username: mari
	  password: 9611
	  host: localhost
	  port: 5432

	production:
	  database: mari
	  adapter: postgresql
	  pool: 5
	  username: mari
	  password: 9611
	  host: localhost
	  port: 5432

## 3.1 Desarrollo

Se generó la base MVC, con rails:

	$rails new gym

Generación de controladores para pagina de inicio e imagenes:

	$rails generate controller welcome index
	$rails generate controller images index

Generación de modelos

	$rails generate model Image nombre:string ubicacion:string fecha:string autor:string peso:string
	$rake db:migrate

Creacion de vistas para controller images en view images

	new file _form.htm.erb
	new file edit.htm.erb
	new file new.htm.erb
	new file show.htm.erb

Gestion de usuarios

En Gemfile:

	gem 'devise', '~> 4.2'

	$bundle install
	$rails g devise:install
	$rails g devise User
	$rails g devise:views

Realización de search:

En images_controlles.rb

	def index
		@images = Image.all
		if params[:search]
			@images = Image.search(params[:search])
		else
			@images = Image.all.order('created_at DESC')
      	 	end
	end 

En image.rb

	def self.search(search)
		where("nombre || ubicacion || autor LIKE ?", "%#{search}%")
	end 

En views/image/index.html.erb

	<%= form_tag(images_path, :method => "get", id: "search-form") do %> 
		<%= text_field_tag :search, params[:search], placeholder: "Buscar Imagen", class:"camposearch" %>
		<%= submit_tag "Search", class:"botonsearch" %>
	<% end %>

Definicion de rutas en config routes.rb

	get 'images/index'
	resources :images
	devise_for :users
	get 'welcome/index'
	root 'welcome#index'

Rutas para el DCA

	scope '/marigym' do
	    get 'welcome/index'
	    resources :images
	    root 'welcome#index'
	end

## 3.2 Pruebas en el DCA
conectarse al servidor:
	
	ssh user1@10.131.137.180
	password: ******

Agregar un nuevo usuario:

	sudo adduser mnarvae3

Darle permisos de supersusuario en el archivo sudoers

Preparación del ambiente: 

	* Instalar rvm
	
		mnarvae3@10.131.137.180$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
		mnarvae3@10.131.137.180$ \curl -sSL https://get.rvm.io | bash

	* Intalar ruby
		mnarvae3@10.131.137.180$ rvm install 2.4.1

	* Instalar rails
		mnarvae3@10.131.137.180$ gem install rails

	* Instalar postgresql
		mnarvae3@10.131.137.180$ sudo yum install -y postgresql-server postgresql-contrib postgresql-devel
		mnarvae3@10.131.137.180$ sudo postgresql-setup initdb

	* Crear usuario, password y base de datos
		createuser --mari
		psql
		postgres=# \password mari
		Enter new password: ******
		postgres=# \q
		exit
		sudo -u mari psql
		createdb mari_dca

	* Clonar repositorio
		mnarvae3@10.131.137.180$git clone https://github.com/MarianaNarvaez/gym2.git

Seguir los siguientes pasos
https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/apache/oss/el7/deploy_app.html


 ## 3.3 Producción

El despliegue se realizo en heroku, para ello se llevaron a cabo los siguientes pasos:

1. Creacion de cuenta en heroku.com
2. Instalar postgresql

	sudo apt-get update
	sudo apt-get install postgresql postgresql-contrib

3. Crear usuario, password y base de datos en postgresql

	createuser --mari
	psql
	postgres=# \password mari
	Enter new password: 123456
	postgres=# \q
	exit
	sudo -u mari psql
	createdb mari

4. Hacer el deploy en heroku:
instalar heroku

		-wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

hacer commit

		git commit -m "subiend el log"

Precompilar assets

		rake assets:precompile
		git commit -m "con assets"

logearse en heroku

		heroku login

Crear sitio para deploy

		heroku create

Hacer push

		git push heroku master

Realizar migracion

		heroku run rake db:migrate
		heroku open

Renombrar direccion

		heroku rename marigym

https://marigym.herokuapp.com/

# 4. Diseño:

## 4.1 Modelo de datos:

	Image:
	{
	nombre: String,
	ubicacion: String,
	fecha: String,
	autor: String,
	peso: String,
	user: integer
	}

	User:
	{
	email: String,
	password: String,
	}

## 4.2 Servicios Web

	/* Servicio Web: Consulta las imagenes del usuario logeado
	  Método: GET
	  URI: /images/index
	*/

	/* Servicio Web: Guarda imagenes en la base de datos
	  Método: POST
	  URI: /images?nombre=foto1&ubicacion=medellin&fecha=12032017&compartir=si
	*/

	/* Servicio Web: Expone la vista para crear una nueva imagen
	  Método: GET
	  URI: /images/new
	*/

	/* Servicio Web: Expone la vista para editar una nueva imagen
	  Método: GET
	  URI: /images/:id
	*/

	/* Servicio Web: Actualiza los registros de las imagenes en la base de datos.
	   Método: PUT
	   URI: /images/:id?nombre=otronombre
	*/

	/* Servicio Web: Borra los registros de las imagenes de la base de datos.
	   Método: DELETE
	   URI: /images/:id
	*/

	/* Servicio Web: Expone la vista para logear un usuario
	   Método: GET
	   URI: /users/sign_in
	*/

	/* Servicio Web: Realiza el login
	   Método: POST
	   URI: /users/sign_in?email=mari@gmail.com&password=123456
	*/

	/* Servicio Web: destruye la sesion iniciada
	   Método: DELETE
	   URI: /users/sign_out
	*/

	/* Servicio Web: Muestra la vista para hacer el registro de un usuario
	   Método: GET
	   URI: /users/sign_up
	*/	

	/* Servicio Web: Guarda el registro del nuevo usurio en la base de datos
	   Método: POST
	   URI: /users?email=micorreco@hotmail.com&password=123456
	*/

	/* Servicio Web: Obtiene la vista inicial de la aplicación
	   Método: GET
	   URI: /welcome/index
	*/
