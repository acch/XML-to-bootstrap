FROM debian:stretch
MAINTAINER Achim Christ

# Install prerequisites
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update \
&& apt-get -qqy install \
  curl \
  gnupg \
&& curl -sL https://deb.nodesource.com/setup_6.x | bash - \
&& apt-get -qqy install \
  git \
  g++ \
  gcc \
  graphicsmagick \
  make \
  npm \
  openjdk-8-jre \
  python \
  xsltproc \
&& rm -rf /var/lib/apt/lists/*

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

# Populate and expose volumes
COPY sass/ /build/sass
COPY src/ /build/src
VOLUME ["/build/src", "/build/sass", "/build/publish"]

# Expose ports
EXPOSE 8000

# Declare Grunt as entrypoint
ENTRYPOINT ["/build/node_modules/grunt/bin/grunt"]
CMD ["default"]
