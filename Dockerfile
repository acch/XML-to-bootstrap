FROM nginx:latest
MAINTAINER Achim Christ

# Install prerequisites
RUN apt-get update && apt-get install -y \
  git \
  npm \
  xsltproc \
&& rm -rf /var/lib/apt/lists/* \
&& ln -s /usr/bin/nodejs /usr/bin/node \
&& npm install -g grunt-cli

# Create non-root user
RUN useradd -d /build build \
&& mkdir /build \
&& chown build:build /build

# Switch to non-root user
USER build

# Switch to build directory
WORKDIR /build

# Get the code
RUN git clone https://github.com/acch/XML-to-bootstrap.git .

# Get submodules
RUN git submodule update --init

# TODO: optionally build custom bootstrap theme
#RUN echo '@import "customvars";' >> modules/bootstrap/scss/_custom.scss \
#&& ln -s ../../../sass/customvars.scss modules/bootstrap/scss/ \
#&& npm install \
#&& grunt dist

# Install build tools
RUN npm install

# Copy custom content
COPY sass/ sass/
COPY src/ src/

# Build the site
RUN grunt default

# Switch back to root user
USER root

# Publish results
#RUN cp -r publish/* /usr/share/nginx/html/
RUN ln -sf /build/publish/* /usr/share/nginx/html/
