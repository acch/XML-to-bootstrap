FROM debian:jessie
MAINTAINER Achim Christ

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update \
&& apt-get -qqy install \
  curl \
  git \
  graphicsmagick \
  npm \
  xsltproc \
&& rm -rf /var/lib/apt/lists/* \
&& ln -s /usr/bin/nodejs /usr/bin/node \
&& npm install -g n \
&& n -q stable  # update Nodejs to latest version

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

# Expose ports
EXPOSE 8000

# Expose volumes
VOLUME ["/build/src", "/build/sass", "/build/publish"]

# Declare Grunt as entrypoint
ENTRYPOINT ["/build/node_modules/grunt/bin/grunt"]
CMD ["default"]
