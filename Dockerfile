FROM nginx:latest
MAINTAINER Achim Christ

# Install prerequisites
RUN apt-get update
RUN apt-get install -y git xsltproc nodejs npm

# Get the code
RUN git clone https://github.com/acch/XML-to-bootstrap.git /build

# Get the submodules
RUN git submodule init
RUN git submodule update

# Temporary workaround for node-sass
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install build tools
cd /build
RUN npm install
RUN npm install -g grunt-cli
RUN npm install -g bower

# Build the code
RUN grunt

# Publish results
cp -r publish/* /usr/share/nginx/html

