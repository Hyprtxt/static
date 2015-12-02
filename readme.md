# Hyprtxt Static

## Get Started

You'll need some things!

* Node installed with NVM, to a BASH Environment

### Install NVM

`curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.28.0/install.sh | bash`

#### Install Bower and Gulp globally

`npm i -g bower gulp`

#### Install `node_modules` and `bower_components`

`npm install;bower install`

#### Fire it up!

`gulp watch`

That will create the `static_generated` directory, where you final web site lives.

### Webserver

You want to serve up the `static_generated` directory.

From the root of the project: `cd ./static_genrated;python -m SimpleHTTPServer 8080`

Then check http://127.0.0.1:8080

# What is it doing?

## Configuration

`./view-data/global.coffee` is passed to all Jade templates. Use it for global front-end configuration values.

# Node Package Manager

Well, you're here after all, so I'd guess you already know why `npm` is so great. What follows is a an explanation of the major packages in use by the project.

# Bower

Bower is used to manage OP's (other peoples) client side code. Things like:

* jQuery
* Bootstrap
* Font Awesome

## Gulp

[Gulp](http://gulpjs.com/) is a task runner that enables awesome like:

* Automated moving of the things (copies files for us, enables Bower)
* SASS (Source Mapping, AutoPrefixing)
* CoffeeScript (Source Mapping)
* Jade ([Dynamic](http://hapijs.com/) or [Static](http://nginx.org/en/))
* LiveReload (Via Chrome Extension)
* Static website building
* All of the above, on demand (when you save a file)

Files in the `./src` directory are compiled and output to the `./static_generated` directory

### SASS

Okay this one is technically a Ruby module. Better than CSS.

### Jade

Preferred HTML template language. RIP closing tags and `<>`. Uses JavaScript for template logic

### Coffee Script

Coffee Script compiles to JavaScript, Nice and terse like Jade and Sass
