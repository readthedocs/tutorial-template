Definitions
=========

# What is docker?

Docker is a platform that provides the tools/services that enable developers, system administrators, DevOps engineers, etc. to package, build, deploy and run an application as a lightweight executable unit or in a sandbox (called a **Container**).

It's used for building and running applications in a **container** that is (mostly) isolated from the rest of the system, and has everything it needs to run self-contained.

You can have many different applications running in their own docker containers on the same machine, and not conflicting with each other.

# Why do we use docker?

The main use case of docker in web development is for being able to deploy your application on any server without having to worry about installing any other dependencies or getting conflicts with other applications on the same server.

# Sounds a lot like a virtual machine…

Containers and virtual machines have similar resource isolation and allocation benefits, but function differently because containers virtualize the operating system instead of hardware. Containers are more portable and efficient.

## Containers

Containers are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. Containers take up less space than VMs (container images are typically tens of MBs in size), can handle more applications and require fewer VMs and Operating systems.

![image](https://www.docker.com/wp-content/uploads/2021/11/docker-containerized-appliction-blue-border_2.png)

## Virtual Machines

Virtual machines (VMs) are an abstraction of physical hardware turning one server into many servers. The hypervisor allows multiple VMs to run on a single machine. Each VM includes a full copy of an operating system, the application, necessary binaries and libraries - taking up tens of GBs. VMs can also be slow to boot.
