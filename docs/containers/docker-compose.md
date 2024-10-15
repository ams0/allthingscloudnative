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
