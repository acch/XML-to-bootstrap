#!/usr/bin/sh

# Stop an remove all containers
docker stop x2b-test-1 
docker rm x2b-test-1

# Delete image
#docker rmi XML-to-Bootstrap

# Build image based on Dockerfile
docker build -t XML-to-Bootstrap .

# Run container based on image
docker run --name x2b-test-1 -d -p 9000:80 XML-to-Bootstrap
