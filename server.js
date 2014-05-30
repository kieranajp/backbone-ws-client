/* jshint laxcomma:true */

var express = require('express')
  , app = express()
  , io = require('backbone.io')
  , util = require('util')
  ;

app.use(express.static(__dirname))


var server = app.listen(3000);

var backend = io.createBackend();
backend.use(io.middleware.memoryStore());

io.listen(server, { testbackend: backend });
