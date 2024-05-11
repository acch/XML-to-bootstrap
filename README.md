
---

> **IMPORTANT**: Unfortunately, this project is no longer actively maintained by its original creator(s). While it may no longer receive updates or support, the codebase remains accessible and available for anyone interested in continuing its development.

---

# XML-to-Bootstrap

Transforms a generic XML document into Bootstrap HTML pages.

## Overview

XML-to-Bootstrap is a set of tools to generate static web pages.
Input is defined in the form of an *Extensible Markup Language* ([XML](https://en.wikipedia.org/wiki/XML)) document.
The output is a web page comprising [HTML](https://en.wikipedia.org/wiki/HTML), [CSS](https://en.wikipedia.org/wiki/Cascading_Style_Sheets) and [JavaScript](https://en.wikipedia.org/wiki/JavaScript) files. The transformation is performed by using *Extensible Stylesheet Language Transformations* ([XSLT](https://en.wikipedia.org/wiki/XSLT)), as well as several JavaScript utilities invoked as [Grunt](https://gruntjs.com) tasks.

### Features

Take a look at the [Demo](https://acch.github.io/XML-to-bootstrap/) site to learn how generated pages look like.

- Produces clean, fast, accessible HTML5 code
- Generates static web pages compatible with any web server
- Compatible with [Netlify](https://www.netlify.com) continuous deployment platform
- Compatible with latest and greatest [Bootstrap](https://getbootstrap.com) v4
- Fully themable with custom Bootstrap builds
- Uses [Schema.org](https://schema.org) microdata to optimize pages for search engines
- Pre-built [Docker](https://www.docker.com) image [available](https://hub.docker.com/r/acch/xml-to-bootstrap) to get you started quickly

### Differentiation and limitations

XML-to-Bootstrap is a static site generator, similar to popular [Jekyll](https://jekyllrb.com), [Middleman](https://middlemanapp.com), or [Hugo](https://gohugo.io). But as opposed to these projects, which provide flexible general purpose tools, XML-to-Bootstrap (currently) focuses on a single, very specific use case. It only generates a certain type of web page. If you're looking for something more customizable then I'd strongly suggest to check out Jekyll or [the like](https://www.staticgen.com).

## Installation

### Manual installation

1. XML-to-Bootstrap requires an XSLT processor such as [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html), [GraphicsMagick](http://www.graphicsmagick.org), as well as [Node.js](https://www.nodejs.org):

   On RedHat-like Linux:

   ```
   # sudo dnf install libxslt GraphicsMagick npm
   ```

   On Debian-like Linux:

   ```
   # sudo apt-get install xsltproc graphicsmagick npm
   # sudo ln -s /usr/bin/nodejs /usr/bin/node
   ```

   On Arch-like Linux:

   ```
   # sudo pacman -S libxslt graphicsmagick npm
   ```

2. Several options are available for getting the code:

   - Download the latest [release](https://github.com/acch/XML-to-bootstrap/releases/latest) and extract to a local directory
   - Clone the Git repository: `git clone https://github.com/acch/XML-to-bootstrap.git`

3. Once code is downloaded, `cd` into the directory and install necessary prerequisites (including [Grunt](https://gruntjs.com)):

   ```
   # npm install
   # sudo npm install -g grunt-cli
   ```

4. Bootstrap is integrated as a Git [submodule](https://git-scm.com/docs/git-submodule). Fetch and build it with the following command:

   ```
   # grunt init
   ```

5. With all prerequisites installed, build the project:

   ```
   # grunt
   ```

6. If all goes well you end up with a set of static web pages in the `publish/` directory. Transfer them to your web server and enjoy!

7. Grunt provides a minimal web server, which can be used to preview the results. To do so, run the following command and point your browser to http://localhost:8000:

   ```
   # grunt connect
   ```

To get started with your own content simply modify the source files in the `src/` directory and rebuild using `grunt`. Don't worry, your modifications will not be overwritten by future updates of XML-to-Bootstrap.

### Container deployment

The installation can also be performed automatically by building a [Docker](https://www.docker.com) image and running a container from it. You can simply use the pre-built image [acch/xml-to-bootstrap](https://hub.docker.com/r/acch/xml-to-bootstrap), unless you want to customize the Bootstrap theme. For custom Boootstrap builds you will need to build your own Docker image as explained below.

1. Use the following commands to build a Docker image. This will download the necessary code, compile Bootstrap, and install all prerequisites necessary to build the project. Be patient, this may take a while.

   ```
   # git clone https://github.com/acch/XML-to-bootstrap.git
   # cd XML-to-bootstrap && docker build -t x2b .
   ```

2. The following command will run a container from the image, in turn building your project:

   ```
   # docker run --rm -v $(pwd)/src:/build/src -v $(pwd)/publish:/build/publish x2b
   ```

   Any further arguments will be passed to Grunt directly. Thus, in order to build a debug version of your project simply run:

   ```
   # docker run --rm -v $(pwd)/src:/build/src -v $(pwd)/publish:/build/publish x2b debug
   ```

   Grunt provides a minimal web server, which can be used to preview the results. To do so, run the following command and point your browser to http://localhost:8000:

   ```
   # docker run -d -v $(pwd)/publish:/build/publish -p 8000:8000 x2b connect
   ```

3. After you've successfully built and run the demo pages you can get started with your own content. To do so, modify the source files in the `src/` directory according to your needs. Your static web pages are available in the `publish/` directory after you've run a container to build them.

4. Note that once you've customized the Bootstrap theme (by editing `sass/customvars.scss`) you'll need to (re-)build the image using:

   ```
   # docker build -t x2b .
   ```

## Contents

The project comprises files in the following directories:

```
XML-to-bootstrap/       Contains build instructions and documentation
├── css/                Contains 3rd party CSS stylesheets used during build
├── img/                Contains image resources used during build
├── js/                 Contains JavaScript code used during build
├── lib/                Contains 3rd party libraries fetched with Bower and used during build
├── modules/            Contains Git submodules such as Bootstrap
├── publish/            Contains the generated static web pages
├── sass/               Contains SCSS templates which are compiled into CSS stylesheets
│   └── sample/         Contains sample SCSS to act as template for overriding Bootstrap variables
├── src/                Contains the XML document describing your web pages
│   ├── img/            Contains image resources for your web pages
│   ├── sample/         Contains sample XML to act as template for new web pages
│   └── sampleimg/      Contains sample image resources for demo web pages
└── style/              Contains XSL stylesheets used to generate static web pages from the XML document
```

`css`, `img` and `lib` are temporary directories which can be deleted. They will be recreated during build.

## Usage

The [Grunt](https://gruntjs.com) task runner is used to build static web pages. The following Grunt tasks are available:

Task | Description
--- | ---
init | Initializes Bootstrap submodule and builds custom theme
clean | Deletes previously generated output and temporary files
default | Generates minified output with development URLs &mdash; use this for *development*
debug | Skips minification and instead generates readable output &mdash; use this for *development*
prod | Generates minified output with production URLs &mdash; use this for *production*
connect | Start minimal web server on port 8000 used for development

To get started with your own site simply modify the source files in the `src/` directory. When populating the XML document with your own content, remember to use character entity numbers instead of names. Character entity names are not defined in XML. For example, `&nbsp;` will not work &mdash; you will need to use `&#160;` instead. Refer to the [HTML5 Character Reference](https://dev.w3.org/html5/html-author/charref) for a complete list with mappings.

Here are some popular characters to use:

&#160; | Entity Name | Entity Number | Description
--- | --- | --- | ---
&#160; | &amp;nbsp; | &amp;#160; | Non-breaking space
&#8212; | &amp;mdash; | &amp;#8212; | Em dash
&#8230; | &amp;hellip; | &amp;#8230; | Ellipsis

### Publishing

Generated static web pages end up in the `publish/` directory. During development you will most likely want to invoke `grunt connect` for running a local web server at http://localhost:8000. When publishing the final web pages then the URLs used inside HTML documents need to be adjusted in order to reflect the address of the production web server. Use the `grunt prod` target for generating web pages with production URLs. These URLs are defined with the following options:

```
# options.xml

<option name="site.url" devmode="dev">//localhost:8000/</option>
<option name="site.url" devmode="prod">//acch.github.io/XML-to-bootstrap/</option>
<option name="site.assets.url" devmode="dev">//localhost:8000/assets/</option>
<option name="site.assets.url" devmode="prod">//acch.github.io/XML-to-bootstrap/assets/</option>
```

### Sidebar

XML-to-bootstrap can automatically generate a navigation sidebar for your pages. This happens if you equip your elements (typically headings) with an `id` attribute. Thus, if you use `<h2>`&ndash;`<h6>` tags with a unique `id` attribute to group your content into sections then a sidebar will be generated with links to these anchors. If you skip the `id` attribute then no sidebar will show up.

### Image resources

Image resources are stored in subdirectories underneath `src/img/`. You need to create a separate subdirectory for each article and for each project using images. The naming convention is `src/img/[article|project]/<id>/somepic.jpg`. Note that the directory name must match the *id* of the article / project (as defined by the `id` attribute). If no `id` attribute is defined then the path will be generated from the title &mdash; same as the article / project's *filename* (without extension).

Here's an example:

```
src/
└── img/
    ├── article/
    │   ├── first-article/
    │   │   └ somepic.jpg
    │   ├── another-article/
    │   │   └ somepic.png
    │   └── yet-another-article/
    │       ├ somepic.gif
    │       └ anotherpic.jpg
    └── project/
        ├── project-one/
        │   └ goodpic.jpg
        ├── project-two/
        │   └ betterpic.jpg
        └── project-three/
            └ bestpic.jpg
```

When generating the HTML document, XML-to-Bootstrap will automatically prepend the article / project's path to the image's `src` attribute. This means that in the XML document you can simply use the following syntax to insert images:

```
# articles.xml

<article id="first-article">
  ...
  <img src="somepic.jpg" />
  ...
</article>
```

Or alternatively, if no `id` attribute is defined:

```
# articles.xml

<article>
  ...
  <title>First Article!</title>
  ...
  <img src="somepic.jpg" />
  ...
</article>
```

### Custom Bootstrap theme

The file `sass/customvars.scss` can be used to override Bootstrap variables, resulting in a custom Bootstrap theme. Add any Sass variables you wish to override to this file. Note that Bootstrap needs to be rebuilt after making changes to `customvars.scss` &mdash; use the `grunt init` task for that purpose.

For more information on Bootstrap's customization options refer to the [documentation](https://v4-alpha.getbootstrap.com/getting-started/options) or simply read the definitions and comments in `modules/bootstrap/scss/_variables.scss`.

As the Bootstrap theme is included in the Docker image you will *not* be able to use the pre-built image [acch/xml-to-bootstrap](https://hub.docker.com/r/acch/xml-to-bootstrap), but instead need to build your own image. Furthermore, the Docker image needs to be rebuilt every time after making changes to `customvars.scss`. Use the following command for that purpose:

```
docker build -t x2b .
```

### Known problems

If Grunt complains about JavaScript syntax errors during build then update to the latest version of [Node.js](https://nodejs.org) via `npm install -g n && n stable`. Alternatively, use the [NodeSource](https://nodesource.com) repository to install the latest Node.js version for your platform.

## Development and extension

You have a question, found a bug, or have an idea how to make this tool better? Great &mdash; your feedback is highly appreciated! Please use the [issue tracker](https://github.com/acch/XML-to-bootstrap/issues) to get in touch.

Please consider making your modifications and extensions available to others. Refer to the [CONTRIBUTING](CONTRIBUTING.md) document for details.

## Copyright and license

Copyright Achim Christ, released under the [MIT license](LICENSE).
