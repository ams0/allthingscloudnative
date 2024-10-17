# Create an application and containerize it

# Outcomes

You should be able to:

 - Containerize a node.js application

# Outline

## Nodejs

1. Create a nodejs app

    ```javascript
    // copied from https://nodejs.org/en/about/
    const http = require('http');
    
    const hostname = '127.0.0.1';
    const port = 3000;
    
    const server = http.createServer((req, res) => {
      res.statusCode = 200;
      res.setHeader('Content-Type', 'text/plain');
      res.end('Hello World');
    });
    
    server.listen(port, () => { // <-- changed this line
      console.log(`Server running at http://${hostname}:${port}/`);
    });
    ```

2. Create a Dockerfile

    ```Dockerfile
    FROM node:alpine
    WORKDIR /app
    COPY . /app
    EXPOSE 3000
    CMD ["node", "server"]
    ```

3. Build the image

    ```bash
    docker build --tag hellonode:0.1 .
    ```

    List the image:
    
    ```bash
    docker image list
```

4. Run the image as a container

    ```bash
    docker run -p 3000:3000 -d hellonode:0.1
    ```

5. Connect to the app

    Open a browser to http://localhost:3000. Success!
    
    Check the running containers:
    
    ```bash
    docker container list
    ```

4. Create a Go app and containerize it

    Create a file with the following content:
    
    ```go
    package main
    
    import "fmt"
    
    func main() {
        fmt.Println("hello world")
    }
    ```
    
    Now you have two options:
    
    - compile the app and run the binary in a docker container:
    
    ```bash
    GOOS=linux GOARCH=amd64 go build -o hello
    ```
    
    - run the app in a docker container without compiling it:
    
    ```bash 
    docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:1.14 go run hello.go
    ```
    
    Create a basic dockerfile that does the same:
    
    ```
    FROM scratch
    
    COPY hello /
    
    ENTRYPOINT ["/hello"]
    ```
    
    ```bash
    docker build -t hello:scratch .
    docker run hello:scratch
    ```
    
    - Without installing any local dependencies, build the app and the image::
    
    ```Dockerfile
    FROM golang:1.14 AS builder
    COPY hello.go .
    RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello .
    
    FROM scratch
    COPY --from=builder /go/hello /hello
    ENTRYPOINT ["/hello"]
    ```
    
    ```bash
    docker build -t hello:multibuild .
    ```
    
    Run the container with:
    
    ```bash
    docker run hello:multibuild
    ```

## Python

1. Create a Python app

This Flask application listens on port 5000 and returns a simple "Hello, Docker!" message when accessed.

-  Python script (app.py)
    ```python
    # app.py
    from flask import Flask

    app = Flask(__name__)

    @app.route('/')
    def hello_world():
        return 'Hello, Docker!'

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000)
    ```

- requirements.txt
    This file lists the Python dependencies needed for the app. In this case, you only need Flask and Werkzeug:

    ```makefile
    Werkzeug==2.2.2
    Flask==2.0.2
    ```

2. Python Dockerfile

    ```Dockerfile
    # Use an official Python runtime as a base image
    FROM python:3.9-slim
    # Set the working directory
    WORKDIR /app
    # Copy the current directory contents into the container
    COPY . /app
    # Install any needed dependencies
    RUN pip install -r requirements.txt
    # Make port 5000 available to the world outside this container
    EXPOSE 5000
    # Run app.py when the container launches
    CMD ["python", "app.py"]
    ```

3. Build the image

    ```bash
    docker build -t my-python-app .
    ```

4. Run the image as a container

    ```bash
    docker run -p 5000:5000 my-python-app
    ```

## Java

1. Create a Java app

You can generate a Spring Boot application using Spring Initializr. Here are the basic steps:

- Project: Maven
- Language: Java
- Spring Boot: 2.7.x or later
- Dependencies: Spring Web

Once you generate the project, you will get a Maven project structure. Add the following simple Java code to your `Application.java` file.

    ```java
    package com.example.myapp;

    import org.springframework.boot.SpringApplication;
    import org.springframework.boot.autoconfigure.SpringBootApplication;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.RestController;

    @SpringBootApplication
    public class MyAppApplication {

        public static void main(String[] args) {
            SpringApplication.run(MyAppApplication.class, args);
        }

        @RestController
        class HelloController {
            @GetMapping("/")
            public String hello() {
                return "Hello, Docker!";
            }
        }
    }
    ```

Build the Java Application
Once you have the code and `pom.xml` in place, you need to build the project to generate the JAR file. Run the following Maven command from the root directory of your project:

```bash
mvn clean package
```
This will generate a JAR file in the `target/` directory, e.g., `target/myapp-0.0.1-SNAPSHOT.jar`.

2. Java Dockerfile

    ```Dockerfile
    # Use an official Java runtime as a base image
    FROM openjdk:11-jre-slim
    # Copy the jar file into the container
    COPY target/myapp.jar /app/myapp.jar
    # Expose port 8080
    EXPOSE 8080
    # Run the jar file when the container launches
    CMD ["java", "-jar", "/app/myapp.jar"]
    ```

3. Build the image

    ```bash
    docker build -t my-java-app .
    ```


4. Run the image as a container

    ```bash
    docker run -p 8080:8080 my-java-app
    ```