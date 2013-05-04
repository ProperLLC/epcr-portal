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

Once you have the above setup, you can startup the project locally by simply running:

```
$ grunt server
```

That should launch your default browser with the application landing page.  From there, test away.