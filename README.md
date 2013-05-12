epcr-portal
===========

The ePCR Portal Web UI

This portal will serve as the user interface to use the data collected by the eprc-ingest before its picked up and finalized by another process.

It will require credentials to login.

Setup:
 * Node JS 0.10.x (required)
 * Yeoman 1.0-beta4 (required - after Node is installed: ```$ npm install -g yo```) - http://yeoman.io
 * Bower (required - after Yeoman is installed: ```$ npm install -g bower```) -  https://github.com/bower/bower/blob/master/README.md
 * Grunt (required - after Bower is installed: ```$ npm install -g grunt-cli```) - https://github.com/gruntjs/grunt-cli/blob/master/README.md
 * IntelliJ IDEA 12.1 (with JavaScript, CoffeeScript and Grep Console plugins) - (Optional)
 * Grunt Devtools (optional)
 * Chrome Web Browswer (optional)
 * Grunt Devtools Plugin for Chrome (optional)
 * AngularJS Boomerang Plugin for Chrome (optional)

If working on a Mac, Homebrew is recommended (install Node JS)

Startup (Dev Environment)
=========================

Once you have the above setup, you will need to pull down all the NPM dependencies.  Do this by running the following from the project root directory:

```
$ npm install
```

It will run for a few minutes downloading all sorts of stuff needed - this all goes into the node_modules folder.

When that is complete, you can startup the project locally by simply running the following from the project root directory:

```
$ grunt server
```

That should launch your default browser with the application landing page.  From there, test away.

Or if you want to use the Chrome devtools plugin:

```
$ grunt devtools
```

Then right click, choose 'Inspect Element' and you can launch any Grunt related task from that console.  Click 'server' to start it and then press on the (B) to background the process.