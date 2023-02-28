Deploying App Using Nginx
=======================

Installing and running nginx typically involves the following steps:

1.  Install nginx:
    On Ubuntu or Debian: sudo apt-get install nginx
    On CentOS or Fedora: sudo yum install nginx
    On macOS: brew install nginx
    Once nginx is installed, you can start the nginx service using the following command:

2.  On Ubuntu or Debian: sudo systemctl start nginx
    On CentOS or Fedora: sudo systemctl start nginx
    On macOS: sudo nginx
    To test if nginx is running, you can check the status of the nginx service using the following command:

3.  On Ubuntu or Debian: sudo systemctl status nginx
    On CentOS or Fedora: sudo systemctl status nginx
    On macOS: sudo nginx -t
    Once nginx is running, you can access its default web page by typing the IP address of your server in your web browser. If you're using a local server, you can access the default page by typing http://localhost/ or http://127.0.0.1/ in your web browser.

4.  To configure nginx to serve your own web content, you'll need to modify its configuration file. The location of this file can vary depending on your system, but it's typically located at /etc/nginx/nginx.conf. You can use a text editor to modify this file and specify the location of your web content.

5.  After modifying the configuration file, you'll need to reload the nginx service to apply the changes. You can do this using the following command:

6.  On Ubuntu or Debian: sudo systemctl reload nginx
    On CentOS or Fedora: sudo systemctl reload nginx
    On macOS: sudo nginx -s reload

7.  Once nginx is configured to serve your web content, you can access it by typing the IP address of your server in your web browser. If you're using a local server, you can access it by typing http://localhost/ or http://127.0.0.1/ in your web browser.

To use Nginx with Docker, you first need to create a Dockerfile to specify the container configuration. In this file, you can specify the base image to use, copy any necessary files to the container, and set the necessary environment variables.
![image](https://user-images.githubusercontent.com/126193839/221335048-e9e29a95-fec1-42f9-9f25-f2751f59e0cc.png)

After creating a Dockerfile, you can use Docker CLI to build a container. After building the container, you can use Docker CLI to run it, which will start the Nginx web server in the container.


To access the Nginx web server from outside the container, you need to expose the port of the container to the host system. This can be done by using the - p flag when running the container.
![image](https://user-images.githubusercontent.com/126193839/221338286-1fce975d-6082-44bc-b59a-f716b057b042.png)


In short, using Nginx with Docker involves creating Dockerfile, building containers, running container, and exposing container ports to host systems. With this setting, you can use Nginx to provide web content in a container environment.

Here is what your project should look like

Folder structure

![image](https://user-images.githubusercontent.com/126193839/221742316-5bf934d9-40af-4062-a85a-7a9115bc7b61.png)

nginx conf file

![image](https://user-images.githubusercontent.com/126193839/221742700-e60ecbd5-b81a-4e96-9fff-39a5d312105a.png)

Dockerfile for nginx to create the container

![image](https://user-images.githubusercontent.com/126193839/221742853-8e559375-e37f-4948-bc06-1157e5cf3055.png)

Docker file for the node.js app. with comments

![image](https://user-images.githubusercontent.com/126193839/221742963-7aaa77f8-e94a-4a68-857d-e9b37795136f.png)

Docker ignores files. ignoring node_modules directory since they are installed once the app is on the container using npm install.

![image](https://user-images.githubusercontent.com/126193839/221743057-e57e92c3-cc93-46da-93f0-48fb9e61d054.png)

Moving them there would take longer and be less consistent. The apps HTML files, with imbedded templating js code. using EJS

![image](https://user-images.githubusercontent.com/126193839/221743209-6020e265-2f0e-4f8b-a312-048e9a4f4850.png)

The backend of the app using node.js

![image](https://user-images.githubusercontent.com/126193839/221743283-398da5eb-a65b-40cc-85c3-b7295bebb4d8.png)

And lastly the docker-compose file. Creates the two containers and gets them running using the specified directory (Docker finds the DockerFiles within them and runs the DockerFile on its own).

![image](https://user-images.githubusercontent.com/126193839/221743352-09a44c4f-0056-421b-aacb-40886fe23a08.png)
