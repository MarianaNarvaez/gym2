GYM

By: Mariana Narvaez - mnarvae3@eafit.educo

1. Descripción de aplicación

Aplicación web que permite gestionar imagenes.

Se generó la base, con rails http://rubyonrails.org/

$ gym rails
(este generador, crea una app base ejemplo MVC para gestión de imagenes)

Aplicación para gestionar usuarios e imagenes de un gimnasio, que cubre:

Aplicación del patron MVC a una aplicación Web
Uso de un framework backend moderno -> Rails
Configuración de ambientes: Desarrollo, Pruebas y Producción.

2. Análisis

2.1 Requisitos funcionales:

Crear Articulo.
*Registro de usuarios por medio del correo electronico y contraseña
*Login de usuarios por medio del correo electronico y contraseña
*Visualizacion de contenido propio al iniciar sesión.
*Buscar contenido por nombre, ubicacion o autor al estar logeado.
*Actualizar contenido.
*Borrar Contenido.
*Compartir contenido.
*Visualizar contenido publico

2.2 Definición de tecnología de desarrollo y ejecución para la aplicación:

*Lenguaje de Programación: Ruby 2.4.1
*Framework web backend: Rails 5.1.1
*Framework web frontend: no se usa - se utilizará *Templates HTML para Vista (V)
*Base de datos: Sqlite3
*Web App Server: Puma
*Web Server: Apache web server

Ambiente de Desarrollo, Pruebas y Producción:

Desarrollo:

*Sistema Operativo: Ubuntu 16.04
*Lenguaje de Programación: Ruby 2.4.1
*Framework web backend: Rails 5.1.1
*Framework web frontend: no se usa - se utilizará *Templates HTML para Vista (V)
*Base de datos: Sqlite3
*Editor: Sublime
*GIT (CLI Y GUI): Git source tree 2.7.4 
*Pruebas: Postman

Pruebas
en el DCA:

se instala nvm local para el usuario
source: https://www.liquidweb.com/kb/how-to-install-nvm-node-version-manager-for-node-js-on-centos-7/

se instala la version de node:

$ nvm install v7.7.4

se instala el servidor mongodb

como root:

# yum install mongodb-server -y
ponerlo a correr:

# systemctl enable mongod
# systemctl start mongod
lo instala de los repositorios propios de Centos.

tambien lo puede instalar de un repo de mongodb:

ver pág: https://www.liquidweb.com/kb/how-to-install-mongodb-on-centos-7/

Produccion:


3. Diseño:

3.1 Modelo de datos:

article:

{
    title: String,
    url: String,
    text: String
}
3.2 Servicios Web

/* Servicio Web: Inserta un registro de Articulo en la Base de datos
  Método: POST
  URI: /newarticle
*/

/* Servicio Web: Realiza la búsqueda en la base de datos, por campo titulo
  Método: GET
  URI: /findbytitle?title=val
*/

/* Servicio Web: Realiza la búsqueda en la base de datos de todos los articulos
  Método: GET
  URI: /articles
*/

/* Servicio Web: Borra un Articulo de la Base de datos.
  Método: GET
  URI: /delarticle?id=val
 */

 /* Servicio Web: Borra un Articulo de la Base de datos.
   Método: DELETE
   URI: /delarticle/id
  */
4. Desarrollo:

5. Implementación o Despliegue (DCA y PaaS):

5.1 despliegue en el data center academico (DCA):

se instala un manejador de procesos de nodejs, se instala: PM2 (http://pm2.keymetrics.io/)

emontoya$ npm install -g pm2
emontoya$ cd articulosEM
emontoya$ pm2 start app.ps
emontoya$ pm2 list
ponerlo como un servicio, para cuando baje y suba el sistema:

emontoya$ pm2 startup systemd
abrir los puertos en el firewall que utilizara la app:

# firewall-cmd --zone=public --add-port=3000/tcp --permanent
# firewall-cmd --reload
# firewall-cmd --list-all
como medida desesperada, puede parar y desactivar el firewalld, cosa que no es recomendable:

# systemctl stop firewalld   
# systemctl disable firewalld
# systemctl start firewalld
Instalar NGINX:

# yum install -y nginx

# systemctl enable nginx
# systemctl start nginx
Abrir el puerto 80

# firewall-cmd --zone=public --add-port=80/tcp --permanent
# firewall-cmd --reload
MUY MUY IMPORTANTE: Deshabilitar SELINUX

# vim /etc/sysconfig/selinux

      SELINUX=disabled
      
# reboot