=====================
Setting Up Docker
=====================

	- Download and Install Docker:
	==============================
		
		- Link:  https://docs.docker.com/get-docker/
		
		- Should be ready to install via the executable. Follow the installation wizard.

			- Make sure to pick ESL 2 on the configuration page. This way you will be able to select which backend

			you can use. (Important detail)
		

		- Don't forget to add yourself to the "docker-users" group if you are not the admin. Run "Computer 

		Management" as administrator and navigate to "Local Users and Groups > Groups > docker-users".
		
		Log out, then log back in.


	-Starting the official Docker Tutorial Container:
	=================================================

		- Run the following command in Docker desktop: 
			
		.. toctree::
			
			docker run -d -p 80:80 docker/getting-started


		- Documentation
			
			Access to the official Docker documentation should now be available on the local host to ports "80:80".

			The rest is just following the tutorial on the official Docker website for the containerization.

			!!! For this project make sure to use Node.js and NGINX !!!
