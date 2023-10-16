# Working with images

#Outcomes

You should be able to:

 - Understand how images are built and created

#Outline
1. Create a CentOS image from scratch:

    ```Dockerfile
    FROM scratch
    ADD centos‐7‐docker.tar.xz /
    LABEL org.label‐schema.schema‐version="1.0" \
        org.label‐schema.name="CentOS Base Image" \
        org.label‐schema.vendor="CentOS" \
        org.label‐schema.license="GPLv2" \
        org.label‐schema.build‐date="20180804"
    CMD ["/bin/bash"]
    ```

2. Build the image

    ```bash
    docker build --tag centos:7 .
    ```

3. Run the image

    ```bash
    docker run -ti centos:7
    ```
