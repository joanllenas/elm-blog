require('./assets/css/normalize.css');
require('./assets/css/skeleton.css');
require('./assets/css//main.css');
var Elm = require('./Main.elm');

var root = document.getElementById('root');

Elm.Main.embed(root);
