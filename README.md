# 🐳 Inception Project – 1337 / 42

<img width="1147" height="652" alt="Screenshot from 2025-09-18 17-13-49" src="https://github.com/user-attachments/assets/0b4ef82d-9609-4b35-b065-2cb298faaa2e" />

## 🌟 Project Overview

**Inception** is an advanced educational and practical project focused on **DevOps and Infrastructure as Code**, designed to teach students how to build a fully integrated, balanced, and modular environment using **Docker** and **Docker Compose**.

<img width="1148" height="731" alt="Screenshot from 2025-09-18 17-19-53" src="https://github.com/user-attachments/assets/ae0f0316-0a20-4422-bb36-f41bad41bb25" />
The core idea is **containerization**: each service runs in its own isolated container, yet all containers communicate seamlessly to simulate a **production-like environment**.

This project covers fundamental and advanced concepts in system management and application deployment, including:

* **Virtual Machines vs Containers:** Understand the difference between fully virtualized systems and lightweight, isolated environments.
* **Docker Engine, Daemon & CLI:** Learn Docker internals and how to interact with it through commands.
* **Isolation & Resource Management:** Use namespaces and cgroups to secure and manage container resources.
* **Images & Containers:** Build images via Dockerfile, understand layers and Copy-on-Write, and run live container instances.
* **Networks & Volumes:** Connect services internally, manage persistent storage, and define communication rules.
* **Reverse Proxy & TLS/SSL:** Use NGINX to route requests and secure connections.
* **Databases & Caching:** Manage persistent data using MariaDB and optimize performance with Redis.
* **Web Services & CMS:** Run WordPress with PHP-FPM, add FTP, Adminer/phpMyAdmin, and optional bonus services like static websites and microservices.

---

## 🎯 Project Objectives

1. Understand differences between Virtual Machines and Containers.
2. Build a multi-service environment using **Docker Compose**.
3. Manage internal networks and persistent storage.
4. Deploy applications like WordPress, MariaDB, and Redis in isolated containers.
5. Ensure infrastructure is **modular, scalable, and secure**.
6. Master best practices for Docker images, Dockerfiles, and environment variables.
7. Gain practical experience with web servers, reverse proxies, and TLS certificates.

---

## 💡 Key Concepts Explained

### What are Containers?

* Containers are **lightweight, portable, and isolated environments** for applications.
* They share the **host OS kernel** but remain separated from other containers.
* Fast to start, easy to replicate, and resource-efficient.
* Example: Running WordPress and its dependencies in a container ensures consistency across machines.
<img width="1280" height="720" alt="image" src="https://github.com/user-attachments/assets/c277bf23-dc9c-4ca5-a602-00f8aeaddb12" />

### What are Virtual Machines?

* Virtual Machines (VMs) are **full systems** with their own OS and kernel on top of a hypervisor.
* Each VM includes OS, libraries, and applications.
* Heavyweight, slower to start, strong isolation.
* Example: Running multiple OS instances for testing legacy software.
<img width="1150" height="728" alt="Screenshot from 2025-09-18 17-31-49" src="https://github.com/user-attachments/assets/ca970584-1bd5-4e39-a1ad-c559e49395c1" />


### Why Docker? What problem does it solve?

* Docker **solves the "it works on my machine" problem**.
* Packages apps and dependencies into containers, ensuring **consistent environments**.
* Enables **modular, scalable, maintainable infrastructures**.
* Reduces resource usage and speeds up deployment.

### Why Virtual Machines? What problem do they solve?

* VMs provide **full isolation** for testing different OS environments.
* Useful for running software that requires a separate kernel or specific OS configurations.

### 🔍 Difference between Docker and Virtual Machines

| Feature        | 🚢 Docker Container  | 🖥️ Virtual Machine  | Quick Explanation                                                    |
| -------------- | ----------------- | ----------------- | ------------------------------------------------------------------------  |
| Isolation      | ⚡ Process-level   | 🛡️ Full OS-level  | Docker shares the host OS kernel; VM has its own OS for strong isolation. |
| Startup        | ⏱️ Seconds        | ⏳ Minutes        | Containers boot almost instantly; VMs take longer as full OS loads.       |
| Resource Usage | 🪶 Low            | 🏋️ High           | Containers are lightweight; VMs consume more CPU, RAM, and storage.       |
| Portability    | 🌍 High           | 📦 Medium         | Docker images can run anywhere; VMs depend on hypervisor compatibility.   |
| OS Kernel      | 🔗 Shared         | 🖤 Own Kernel     | Containers share host kernel; VMs have independent kernels.               |

![docker-vs-vm drawio](https://github.com/user-attachments/assets/5bb779f1-1709-4351-a3f5-7753301c25ac)

### Docker Commands

* `docker run`: Start a new container.
* `docker build`: Build an image from Dockerfile.
* `docker pull`: Download an image from a repository.
* `docker push`: Upload an image to a repository.
* `docker ps`: List running containers.
* `docker stop`: Stop a container.
* `docker rm`: Remove a container.
* `docker rmi`: Remove an image.

### Docker Compose Commands

* `docker-compose up`: Start multiple services.
* `docker-compose down`: Stop multiple services.
* `docker-compose build`: Build images.
* `docker-compose stop`: Stop services without removing.
* `docker-compose ps`: Show container status.
* `docker-compose up --build`: Rebuild and start containers.

### Docker Network

* Connect containers over a private network.
* Define which containers communicate and with what permissions.
* Example: WordPress container communicates with MariaDB container only.

### Docker Volumes

* Store persistent data across container runs.
* Share data between containers.
* Maintain data integrity even if a container crashes.
* Example: WordPress uploads and MariaDB database files stored in volumes.

---

## 📂 Project Structure

```
Project/
├── Makefile                        # Automates build, run, stop, clean commands
├── srcs/                           # Source files for all services
│   ├── docker-compose.yml          # Multi-container orchestration
│   ├── .env                        # Environment variables (DB, user, passwords)
│   └── requirements/               # All mandatory + bonus services
│       ├── nginx/                  # NGINX container
│       │   ├── conf/               # NGINX configuration files
│       │   │   └── default.conf    # Main NGINX virtual host config
│       │   └── Dockerfile          # Build instructions for NGINX image
│       ├── wordpress/              # WordPress container
│       │   ├── Dockerfile          # Build WP + PHP-FPM image
│       │   └── tools/              # Init + setup scripts
│       │       └── script.sh       # Automates WordPress installation
│       ├── mariadb/                # MariaDB container
│       │   ├── conf/               # Database configuration
│       │   │   └── 50-server.conf  # Custom MariaDB server settings
│       │   ├── Dockerfile          # Build MariaDB image
│       │   └── tools/              # Init scripts
│       │       └── script.sh       # Create DB, users, privileges
│       ├── bonus/                  # Bonus services (extra containers)
│       │   ├── redis/              # Redis caching system
│       │   │   ├── Dockerfile
│       │   │   └── tools/
│       │   │       └── redis.sh    # Launch Redis server
│       │   ├── ftp/                # FTP server for file transfer
│       │   │   ├── conf/
│       │   │   │   └── vsftpd.conf # FTP server configuration
│       │   │   ├── Dockerfile
│       │   │   └── tools/
│       │   │       └── ftp.sh      # Setup FTP users & permissions
│       │   ├── adminer/            # Adminer DB management tool
│       │   │   ├── Dockerfile
│       │   │   └── tools/
│       │   │       └── adminer.sh  # Start Adminer
│       │   ├── static-website/     # Simple static site (HTML)
│       │   │   ├── Dockerfile
│       │   │   └── index.html      # Website homepage
│       │   └── web_service/        # Custom web microservice
│       │       ├── conf/
│       │       │   └── nginx.conf  # Web service reverse proxy config
│       │       ├── Dockerfile
│       │       └── tools/
│       │           ├── script.sh   # Service init script
│       │           └── website/    # Service files/content
└── Subject/                        # School project subject
    └── subject.pdf
```

---

## 🚀 Services Overview

### 🌐 NGINX

* High-performance web server and reverse proxy.
* Handles TLS/SSL for HTTPS.
* Routes requests to backend services like WordPress.

### 📝 WordPress + PHP-FPM

* PHP-based CMS.
* PHP-FPM manages FastCGI requests.
* Volume stores plugins, themes, uploads.
* Networked with MariaDB and Redis.

### 🛢 MariaDB

* Relational database for WordPress data.
* Persistent storage via volumes.
* Networked with WordPress and Adminer/phpMyAdmin.

### 🧠 Redis (Bonus)

* In-memory cache for performance.
* Networked with WordPress only.

### 📂 FTP (Bonus)

* Direct upload of files to WordPress.
* Secure via FTPS.
* Networked with WordPress.

### 🛠 Adminer / phpMyAdmin (Bonus)

* Web-based database management.
* Networked with MariaDB.

### 🌐 Static Website (Bonus)

* HTML, CSS, JS container.
* Serves as portfolio or documentation site.
* Networked with NGINX.

### 🔧 Web Service (Bonus)

* Small API or microservice.
* Networked with other internal containers.

---

## ⚙️ Docker Concepts

### Virtualization vs Containerization

* **Virtual Machine:** full OS + kernel + apps running on hypervisor. Heavy.
* **Docker Container:** shares host kernel, lightweight, isolated.
* Containers = isolated environments.

### Core Docker Components

* **Docker Engine:** core system running Docker.
* **Docker Daemon:** background service that builds, runs, and manages containers.
* **Docker CLI:** command-line interface (`docker run`, `docker build`, etc.).
* **Docker API:** programmatic interface for tools to communicate with Docker.

### Isolation & Resource Control

* **Namespaces:** isolate processes, network, mounts, users.
* **Cgroups:** limit resources like CPU and RAM.

### Images & Containers

* **Dockerfile:** defines how to build an image.
* **Layer:** each instruction in Dockerfile creates a new layer.
* **Copy-on-Write (CoW):** shared layers between containers.
* **Docker Image:** template.
* **Docker Container:** live instance of an image.
* **PID 1:** first process inside container, handles signals and child processes.

### Data & Networking

* **Volumes:** store persistent data (e.g., WordPress uploads, MariaDB tables).
* **Networks:** connect containers internally.
* **Ports:** expose container ports externally.
* **ENV:** environment variables for configuration.
* **Configuration:** service-specific configuration files.

### Orchestration

* **Docker Compose:** define and run multiple containers with one YAML file.

### Servers & Web

* **Server:** system or software listening for requests.
* **Web Server:** handles HTTP/HTTPS.
* **NGINX:** high-performance web server.
* **Reverse Proxy:** routes requests to backend services.
* **TLS/SSL:** secure communication.

### Application Layer

* **WordPress:** PHP CMS.
* **PHP-FPM:** FastCGI process manager.
* **FastCGI:** protocol connecting NGINX to PHP-FPM.

### Databases & Caching

* **MariaDB:** relational database storing users, posts, settings.
* **Redis:** in-memory cache for better performance.

### Extra Services

* **FTP:** upload files directly to WordPress container.
* **Adminer / phpMyAdmin:** web-based database management interfaces.

---

## 📚 Recommended Resources

* [Docker Documentation](https://docs.docker.com/)
* [Docker Compose Documentation](https://docs.docker.com/compose/)
* [NGINX Documentation](https://nginx.org/en/docs/)
* [WordPress Documentation](https://wordpress.org/support/)
* [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
* [Redis Documentation](https://redis.io/documentation)
* [PHP-FPM Documentation](https://www.php.net/manual/en/install.fpm.php)
* [Adminer Documentation](https://www.adminer.org/)
* [phpMyAdmin Documentation](https://www.phpmyadmin.net/docs/)

---

## ✅ Conclusion

The Inception project equips students with practical knowledge to build, manage, and scale a complete infrastructure using Docker, connecting multiple services, ensuring security, and understanding the inner workings of modern DevOps environments.

Thank you for exploring the Inception project! Stay tuned for more challenges. 🔥
