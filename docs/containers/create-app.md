# Create an application and containerize it

#Outcomes

You should be able to:

 - Containerize a node.js application

#Outline

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
