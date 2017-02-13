FROM nginx:latest
MAINTAINER Achim Christ

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update \
&& apt-get install -qqy \
  curl \
  git \
  graphicsmagick \
  npm \
  xsltproc \
&& rm -rf /var/lib/apt/lists/* \
&& ln -s /usr/bin/nodejs /usr/bin/node \
&& npm install -g \
  grunt-cli \
  n \
&& n stable # Update Nodejs to latest version

# Create non-root user
RUN useradd -d /build build \
&& mkdir /build \
&& chown build:build /build

# Switch to non-root user
USER build

# Change to build directory
WORKDIR /build

# Get the code
RUN git clone https://github.com/acch/XML-to-bootstrap.git . \
&& git submodule update --init

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
RUN ln -sf /build/publish/* /usr/share/nginx/html/
