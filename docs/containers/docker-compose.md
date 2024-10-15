# Docker Compose

## Outcomes

- Understand what Docker Compose is.
- Understand how to use Docker Compose.
- Understand how to use Docker Compose with a Dockerfile.
- Understand how to use Docker Compose with a Dockerfile and a `.env` file.

## What is Docker Compose?

Docker Compose is a tool used for defining and running multi-container Docker applications. It allows you to configure your application’s services using a simple YAML file, which makes it easier to start, stop, and manage all of the services that comprise your application.

In essence, Docker Compose helps manage complex environments by simplifying multi-container setups. With Compose, you can:
- Define services (such as databases, web servers, etc.) in a single file.
- Spin up all defined services with a single command (`docker-compose up`).
- Scale services as needed (e.g., run multiple instances of a web application).

### Key Benefits of Docker Compose:
- **Simplified multi-container management**: Compose orchestrates the entire environment of containers.
- **Declarative syntax**: The use of YAML configuration files makes defining services clear and concise.
- **Reusability**: Compose files can be shared or reused across environments like development, testing, and production.

## How to Use Docker Compose

### Step 1: Define Your Services in a `docker-compose.yml` File

In the `docker-compose.yml` file, you define the services that make up your application. For example, a typical multi-service app might have a web server and a database. Here's a basic example:

```yaml
version: '3'
services:
  web:
    image: nginx
    ports:
      - "80:80"
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: example
```

In this file:

We define two services: `web` and `db`.
The `web` service uses the nginx image and maps port 80 on the container to port 80 on the host.
The `db` service uses the postgres image and sets an environment variable for the database password.

### Step 2: Starting Services
Once the `docker-compose.yml` file is defined, you can start your application using the following command:

```bash
docker-compose up
```

This will start all the services defined in your Compose file. To stop the services, you can use:

```bash
docker-compose down
```

### Step 3: Scaling Services
To scale a service (for example, to run multiple instances of the web service), you can use:

```bash
docker-compose up --scale web=3
```

This command will create three instances of the web service.

## Using Docker Compose with a Dockerfile
You can instruct Docker Compose to build an image from a Dockerfile instead of pulling it from a registry like Docker Hub. This is especially useful when you need to customize your container images.

Example: docker-compose.yml with a Dockerfile
```yaml
version: '3'
services:
  web:
    build: .
    ports:
      - "80:80"
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: example
```

In this case:

- The `web` service uses a Dockerfile located in the same directory as the `docker-compose.yml` file to build its image.
- The `db` service still uses the postgres image from Docker Hub.
You would need a Dockerfile in your project directory, like this:

```dockerfile
# Dockerfile
FROM nginx
COPY ./html /usr/share/nginx/html
```

When you run `docker-compose up`, it will automatically build the web service image from the Dockerfile.

## Using Docker Compose with a Dockerfile and a .env File
You can further customize your Docker Compose environment by using a .env file. This file contains environment variables that you can reference in the `docker-compose.yml` file.

Example: .env File
```bash
POSTGRES_PASSWORD=supersecretpassword
```

Example: docker-compose.yml Using .env

```yaml
version: '3'
services:
  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
```

In this example:

- The password for the db service is read from the .env file.
- You can use environment variables in your `docker-compose.yml` file by referring to them with `${VARIABLE_NAME}`.

## Summary

Docker Compose simplifies the process of managing multi-container Docker applications. With a single `docker-compose.yml` file, you can define multiple services, build images using Dockerfiles, and pass environment variables through .env files. These features make Compose an essential tool for orchestrating and managing containerized applications.