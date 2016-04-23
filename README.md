# XML-to-Bootstrap

Transforms a generic XML document into Bootstrap HTML pages.

## Overview

XML-to-Bootstrap is a set of tools to generate web pages.
Input is defined in the form of an *Extensible Markup Language* ([XML](https://en.wikipedia.org/wiki/XML)) document.
The output is a web page comprising [HTML](https://en.wikipedia.org/wiki/HTML), [CSS](https://en.wikipedia.org/wiki/Cascading_Style_Sheets) and [JavaScript](https://en.wikipedia.org/wiki/JavaScript) files. The transformation is performed by using *Extensible Stylesheet Language Transformations* ([XSLT](https://en.wikipedia.org/wiki/XSLT)), as well as several JavaScript utilities invoked as [Grunt](https://gruntjs.com/) tasks.

### Features

- Produces clean, fast HTML5 pages
- Static web pages compatible with any web server
- Uses [schema.org](https://schema.org) vocabularies to optimize pages for search engines [WIP]

## Installation

1. XML-to-Bootstrap requires a XSLT processor such as [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html), as well as [Node.js](https://www.nodejs.org/):

  On Red Hat-like Linux:

      # sudo dnf install xsltproc nodejs

  On Debian-like Linux:

      # sudo apt-get install xsltproc nodejs

  On Arch-like Linux:

      # sudo pacman -S libxslt nodejs

2. Several options are available for getting the code:

   - Download the latest [release](https://github.com/acch/XML-to-bootstrap/releases/latest) and extract to a local directory
   - Clone the repo: `git clone https://github.com/acch/XML-to-bootstrap.git`

3. Once code is downloaded, `cd` into the directory and install necessary prerequisites (including [Grunt](https://gruntjs.com/) and [Bower](https://bower.io/)):

        # npm install
        # npm install -g grunt-cli
        # npm install -g bower

4. Bootstrap is integrated as a git submodule. Fetch it with the following commands:

        # cd modules/bootstrap
        # git submodule init
        # git submodule update
        # cd ../..

5. With all prerequisites installed and submodules updated, build the project:

        # grunt

6. If all goes well you end up with a set of static web pages in the `/publish` directory. Transfer them to your web server and enjoy!

## Usage

The following Grunt tasks are available:

- clean -
  Deletes previously produced output
- default -
  Produces minified output
- debug -
  Skips minification and instead produces pretty output

## Development and Extension

TODO: How to read the code.

Please consider making your modifications and extensions available to others. Refer to the [CONTRIBUTING](CONTRIBUTING.md) document for details.

## Copyright and license

Copyright 2015 Achim Christ, released under the [MIT license](LICENSE).
