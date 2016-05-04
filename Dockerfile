FROM nginx:latest
MAINTAINER Achim Christ

# Install prerequisites
RUN apt-get update && apt-get install -y \
  git \
  nodejs \
  npm \
  xsltproc \
&& rm -rf /var/lib/apt/lists/*

# Temporary workaround for node-sass on Debian
RUN ln -s /usr/bin/nodejs /usr/bin/node

WORKDIR /build

# Get the code
RUN git clone https://github.com/acch/XML-to-bootstrap.git .

# Get submodules
RUN git submodule init
RUN git submodule update

# Install build tools
RUN npm install
RUN npm install -g grunt-cli
RUN npm install -g bower

# Build the site
RUN grunt

# Publish results
RUN cp -r publish/* /usr/share/nginx/html

