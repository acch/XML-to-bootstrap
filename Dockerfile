FROM nginx:latest
MAINTAINER Achim Christ

# Install prerequisites
RUN apt-get update && apt-get install -y \
  git \
  npm \
  xsltproc \
&& rm -rf /var/lib/apt/lists/*
RUN npm install -g grunt-cli bower

# Temporary workaround for node-sass on Debian
RUN ln -s /usr/bin/nodejs /usr/bin/node

WORKDIR /build

# Get the code
RUN git clone https://github.com/acch/XML-to-bootstrap.git .

# Get submodules
RUN git submodule update --init

# Install build tools
RUN npm install

# Copy custom content
COPY src/*.xml src/
COPY sass/customvars.scss sass/

# Build the site
RUN grunt

# Publish results
RUN cp -r publish/* /usr/share/nginx/html
