# Containers

Getting started:

#Outcomes

You should be able to:

- Understand the install and use a docker runtime and client
- Containerize an application

#Outline

1. Install Docker

    The best way, on Linux nodes, is to use the script:
    
    ```bash
    curl -fsSL get.docker.com -o get-docker.sh && sudo sh get-docker.sh && sudo systemctl start docker && sudo systemctl enable docker
    ```
    
    Don't forget to add your user to the docker group:
    
    ```bash
    sudo usermod -aG docker $USER
    ```
    
    You'll need to logout and login again for the group change to take effect.

2. Run a container

    ```bash
    docker run busybox echo Hello World
    ```
    
    What just happened?
        
    1. The docker client contacted the docker daemon process
    2. The docker daemon pulled the "busybox" image from the docker hub
    3. The docker daemon created a new container from that image which runs the executable that produces the output you are currently reading
    4. The docker daemon streamed that output to the docker client, which sent it to your terminal
    5. The docker daemon then exited
    6. The docker client exited
    7. The container was destroyed


3. Run a container in the background

    ```bash
    docker run -d -p 80:80 nginx
    ```
    
    Connect to the nginx container:
    
    ```bash
    curl localhost
    ```
    
4. Run a container in the background

```bash
docker run -d -p 80:80 nginx
```
