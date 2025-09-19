# 🐳 Inception Project – 1337 / 42

<img width="1173" height="656" alt="Screenshot from 2025-09-19 09-13-09" src="https://github.com/user-attachments/assets/e920ac02-0014-4db8-86ef-470ea24f0222" />

## 🌟 Project Overview

**Inception** is an advanced educational and practical project focused on **DevOps and Infrastructure as Code**, designed to teach students how to build a fully integrated, balanced, and modular environment using **Docker** and **Docker Compose**.

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
* Your NGINX container must be the only entry point to your infrastructure, accessible exclusively through port 443, using only the TLSv1.2 or TLSv1.3 protocol.
* This diagram provided in the subject should help clarify the setup:
<img width="1148" height="731" alt="Screenshot from 2025-09-18 17-19-53" src="https://github.com/user-attachments/assets/ae0f0316-0a20-4422-bb36-f41bad41bb25" />

---

# 🎯 Project Objectives -- Inception

01. Understand differences between Virtual Machines and Containers.
02. Learn system administration with Docker.
03. Build a multi-service infrastructure using **Docker Compose**.
04. Write Dockerfiles for each service (NGINX, WordPress + PHP-FPM, MariaDB).
05. Configure NGINX as the single entry point (HTTPS only, TLSv1.2/1.3).
06. Set up persistent volumes for database and WordPress files.
07. Manage internal Docker networks for container communication.
08. Ensure infrastructure is **modular, scalable, and secure**.
09. Ensure containers are resilient and restart automatically.
10. Apply Docker best practices (PID 1, daemons, no hacky fixes).
11. Master best practices for Dockerfiles, images, and environment variables.
12. Gain practical experience with web servers, reverse proxies, and TLS certificates.
13. Add Redis caching for WordPress.
14. Add an FTP server connected to WordPress files.
15. Deploy a static website (HTML/CSS/JS).
16. Add Adminer for database management.
17. Set up a custom service of your choice and justify it during defense.
---

## 💡 Key Concepts Explained

❓ **What are Containers?**

Containers are lightweight, portable, and isolated environments that package an application together with everything it needs to run — such as code, runtime, libraries, and dependencies.

Unlike Virtual Machines (VMs), which simulate an entire operating system with its own kernel, containers share the host OS kernel while keeping applications isolated from each other.

**Key advantages of Containers:**
- Fast: Start in seconds, not minutes like VMs  
- Lightweight: No need to run a full OS  
- Isolated: Each container has its own filesystem, processes, and network stack  
- Portable: Runs consistently across different environments (development, testing, production)  

**In simple terms:**  
A container is like a shippable box containing your app and all its ingredients, ensuring it runs the same anywhere — on your laptop, a server, or in the cloud.

![Containers image](https://github.com/user-attachments/assets/c277bf23-dc9c-4ca5-a602-00f8aeaddb12)

---

❓ **What are Virtual Machines (VMs)?**

Virtual Machines are full-fledged emulations of physical computers. They run their own operating system (OS) on top of a hypervisor, which sits on the host machine and manages multiple VMs.

Unlike containers, each VM includes its own OS kernel, libraries, and applications, making it heavier but fully isolated from other VMs.

**Key characteristics of VMs:**
- Slower to start: Booting can take minutes  
- Heavy: Each VM runs a full OS, consuming more memory and storage  
- Fully isolated: Each VM has its own OS, filesystem, processes, and network stack  
- Portable (with limitations): Can run on different hosts but may require hypervisor compatibility  

**In simple terms:**  
A VM is like a computer inside a computer — it’s fully independent, runs its own OS, and can host multiple applications, but it’s heavier and slower than a container.

![VM image](https://github.com/user-attachments/assets/ca970584-1bd5-4e39-a1ad-c559e49395c1)

---

❓ **Why Docker? What problem does it solve?**

Docker is a platform that uses containers to simplify the way applications are built, shipped, and run. It solves several common problems in software development and deployment:

**Problems Docker solves:**
- "It works on my machine" problem: Applications behave the same in development, testing, and production  
- Dependency management: All libraries, runtimes, and dependencies are packaged inside the container  
- Environment consistency: Eliminates differences between operating systems or setups  
- Rapid deployment: Containers start in seconds, making scaling and updates much faster  
- Resource efficiency: Multiple containers can run on the same host without needing full VMs  

**In simple terms:**  
Docker is like a shipping container for software — it keeps everything your app needs inside, so it works anywhere, reliably and consistently.

---

❓ **Why Virtual Machines? What problem do they solve?**

Virtual Machines (VMs) allow multiple operating systems to run on a single physical computer, fully isolated from each other. They solve several key problems in computing and IT infrastructure:

**Problems VMs solve:**
- Hardware consolidation: Multiple VMs can run on one physical server, reducing hardware costs  
- Isolation: Each VM is fully separated, so crashes or security issues in one VM don’t affect others  
- Environment flexibility: Developers and IT teams can run different OS versions or configurations on the same host  
- Testing and sandboxing: Safe environment for testing software without affecting the main system  
- Migration and portability: VMs can be moved between hosts with minimal changes  

**In simple terms:**  
A VM is like a computer inside a computer — it’s fully independent, runs its own OS, and can host multiple applications safely, making IT infrastructure flexible and secure.

---

🔍 **Difference between Docker and Virtual Machines**

| Feature                  | Docker (Containers)                     | Virtual Machines (VMs)                  |
|--------------------------|----------------------------------------|----------------------------------------|
| Isolation                | Processes isolated, share host OS kernel | Full OS isolated, includes kernel       |
| Startup Time             | Seconds                                | Minutes                                 |
| Resource Usage           | Lightweight, minimal overhead          | Heavy, needs full OS per VM            |
| Portability              | Very portable across environments      | Portable, but requires compatible hypervisor |
| Environment Consistency  | Same environment across dev, test, prod | Same environment, but OS-level differences may exist |
| Use Case                 | Microservices, rapid deployment, lightweight apps | Running multiple OS, legacy apps, full isolation |
| Size                     | Small (MBs)                            | Large (GBs)                             |

**In simple terms:**  
- Docker is like a shippable box for your app — fast, light, and portable  
- VMs are like a computer inside a computer — heavy but fully independent and isolated  

**Key takeaway:**  
Use Docker for lightweight, fast, and portable deployments, and VMs when you need full OS isolation, legacy support, or multiple OS environments on a single host.

![Docker vs VM image](https://github.com/user-attachments/assets/5bb779f1-1709-4351-a3f5-7753301c25ac)

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

### 🔗 Docker Network

**Docker Network** allows containers to communicate with each other and with the outside world while keeping isolation and security.

📌 **Key points about Docker Networking:**
- Containers can talk to each other if they are on the same network.
- Docker provides several types of networks:
  - **bridge (default):** Isolated network where containers can communicate through IP addresses.
  - **host:** Container shares the host’s network stack (less isolation, more performance).
  - **overlay:** Connects containers across multiple Docker hosts (used in Swarm/Kubernetes).
  - **macvlan:** Containers get their own MAC address on the physical network.
- Each network ensures **isolation**, so containers on different networks cannot access each other unless explicitly allowed.
- You can assign **custom network names**, subnets, and gateways for better organization and security.

💡 **In simple terms:**  
👉 Docker Network is like the **invisible wiring 🪢** that connects your containers, letting them communicate safely and efficiently without interfering with the host or other networks.

### 💾 Docker Volumes

**Docker Volumes** are persistent storage mechanisms that allow containers to store and share data outside their own filesystem. They ensure that data remains safe even if the container is deleted or recreated.

📌 **Key points about Docker Volumes:**
- Volumes exist **outside the container**, managed by Docker.  
- Data in a volume **persists** even when containers are removed.  
- Volumes can be **shared** between multiple containers.  
- Use **named volumes** or **bind mounts** depending on your needs:
  - **Named volumes:** Managed by Docker, easier to backup and migrate.  
  - **Bind mounts:** Map a host directory into the container, useful for development.  
- Volumes improve **data safety, separation, and portability** of containerized applications.

💡 **In simple terms:**  
👉 Docker Volumes are like **external hard drives 🗄️** for your containers — they keep your important data safe, even if the container itself is deleted or recreated.

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
│       │   └── web_service/        # Set up a service of your choice that you think is useful. During the defense, you will have to justify your choice.
│
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
