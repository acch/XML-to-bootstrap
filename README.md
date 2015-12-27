# XML-to-Bootstrap

Transforms a generic XML document into Bootstrap HTML pages.

## Overview

XML-to-Bootstrap is a set of tools to generate web pages.
Input is defined in the form of an *Extensible Markup Language* ([XML](https://en.wikipedia.org/wiki/XML)) document.
The output is a web page comprising [HTML](https://en.wikipedia.org/wiki/HTML), [CSS](https://en.wikipedia.org/wiki/Cascading_Style_Sheets) and [JavaScript](https://en.wikipedia.org/wiki/JavaScript) files. The transformation is performed by using *Extensible Stylesheet Language Transformations* ([XSLT](https://en.wikipedia.org/wiki/XSLT)), as well as several JavaScript utilities invoked as [Grunt](https://gruntjs.com/) tasks.

## Highlights

- Produces clean, fast HTML5 pages
- Uses [schema.org](https://schema.org) vocabularies to optimize pages for search engines [WIP]

## Installation

XML-to-Bootstrap requires a XSLT processor such as [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html), [Node.js](https://www.nodejs.org/) and [Bower](http://bower.io/).

Several options are available for installation:

- Download the latest [release](https://github.com/acch/XML-to-bootstrap/releases/latest)
- Clone the repo: `git clone https://github.com/acch/XML-to-bootstrap.git`

## Usage

Available Grunt tasks:

- default
- debug

## Development and Extension

How to read the code.

Please consider making your modifications and extensions available to others. Refer to the [CONTRIBUTING](CONTRIBUTING.md) document for details.

## Copyright and license

Copyright 2015 Achim Christ, released under the [MIT license](LICENSE).
