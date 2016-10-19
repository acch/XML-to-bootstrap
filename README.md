# XML-to-Bootstrap

Transforms a generic XML document into Bootstrap HTML pages.

## Overview

XML-to-Bootstrap is a set of tools to generate static web pages.
Input is defined in the form of an *Extensible Markup Language* ([XML](https://en.wikipedia.org/wiki/XML)) document.
The output is a web page comprising [HTML](https://en.wikipedia.org/wiki/HTML), [CSS](https://en.wikipedia.org/wiki/Cascading_Style_Sheets) and [JavaScript](https://en.wikipedia.org/wiki/JavaScript) files. The transformation is performed by using *Extensible Stylesheet Language Transformations* ([XSLT](https://en.wikipedia.org/wiki/XSLT)), as well as several JavaScript utilities invoked as [Grunt](https://gruntjs.com/) tasks.

### Features

Take a look at the [Demo](https://acch.github.io/XML-to-bootstrap/) site to learn how generated pages look like.

- Produces clean, fast HTML5 code
- Generates static web pages compatible with any web server
- Compatible with latest and greatest Bootstrap v4
- Fully themable with custom Bootstrap builds
- Uses [schema.org](https://schema.org) vocabularies to optimize pages for search engines [WIP]

### Differentiation and limitations

XML-to-Bootstrap is a static site generator, similar to popular [Jekyll](https://jekyllrb.com/), [GitBook](https://www.gitbook.com/), or [Pelican](http://blog.getpelican.com/). But as opposed to these projects, which provide flexible general purpose tools, XML-to-Bootstrap (currently) focuses on a single, very specific use case. It only generates a certain type of web page. If you're looking for something more customizable then I strongly suggest to check out Jekyll or [the like](https://www.staticgen.com/).

## Installation

### Manual installation

1. XML-to-Bootstrap requires a XSLT processor such as [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html), as well as [Node.js](https://www.nodejs.org/):

  On RedHat-like Linux:

      # sudo dnf install libxslt npm

  On Debian-like Linux:

      # sudo apt-get install xsltproc npm
      # sudo ln -s /usr/bin/nodejs /usr/bin/node

  On Arch-like Linux:

      # sudo pacman -S libxslt npm

2. Several options are available for getting the code:

   - Download the latest [release](https://github.com/acch/XML-to-bootstrap/releases/latest) and extract to a local directory
   - Clone the Git repository: `git clone https://github.com/acch/XML-to-bootstrap.git`

3. Once code is downloaded, `cd` into the directory and install necessary prerequisites (including [Grunt](https://gruntjs.com/) and [Bower](https://bower.io/)):

        # npm install
        # sudo npm install -g grunt-cli
        # sudo npm install -g bower

4. Bootstrap is integrated as a Git [submodule](https://git-scm.com/docs/git-submodule). Fetch it with the following command:

        # git submodule update --init

5. With all prerequisites installed and submodules updated, build the project:

        # grunt

6. If all goes well you end up with a set of static web pages in the `/publish` directory. Transfer them to your web server and enjoy!

### Container deployment

The installation can also be performed automatically by building a [Docker](https://www.docker.com/) image and running a container from it:

        # docker build -t x2b .
        # docker run --name x2b-1 -d -p 8000:80 x2b

## Usage

To get started with your own content, simply modify the source files in `src/` directory and rebuild using `grunt`.

The following Grunt tasks are available:

Task | Description
--- | ---
clean | Deletes previously generated output and temporary files
default | Generates minified output - use this for production
debug | Skips minification and instead generates readable output - use this for development
connect | Start a minimal web server on port 8000 used for development

When populating the XML document with your own content, remember to use character entity numbers instead of names. Character entity names are not defined in XML. For example, `&nbsp;` will not work - you will need to use `&#160;` instead. Refer to the [HTML5 Reference](https://dev.w3.org/html5/html-author/charref) for a complete list with mappings.

Here are some popular characters to use:

&#160; | Entity Name | Entity Number | Description
--- | --- | --- | ---
&#160; | &amp;nbsp; | &amp;#160; | Non-breaking space
&#8212; | &amp;mdash; | &amp;#8212; | Em dash
&#8230; | &amp;hellip; | &amp;#8230; | Ellipsis

## Contents

The project comprises files in the following directories:

Directory | Description
--- | ---
. | Contains build instructions and documentation
./css | Contains 3rd party CSS stylesheets during build
./js | Contains JavaScript code during build
./modules | Contains Git submodules such as Bootstrap
./publish | Contains the generated static web pages
./sass | Contains SASS templates which are compiled into CSS stylesheets during build
./src | Contains XML document
./src/sample | Contains sample XML document
./style | Contains XSLT stylesheets

## Development and extension

You have a question, found a bug, or have an idea how to make this tool better? Great - your feedback is highly appreciated! Please use the [issue tracker](https://github.com/acch/XML-to-bootstrap/issues) to get in touch.

Please consider making your modifications and extensions available to others. Refer to the [CONTRIBUTING](CONTRIBUTING.md) document for details.

## Copyright and license

Copyright Achim Christ, released under the [MIT license](LICENSE).
