/////////////////////////////////////
// Taken from ariya/phantomjs#10522
//

'use strict';

var isFunction = function(o) {
  return typeof o === 'function';
};


var bind,
  slice = [].slice,
  proto = Function.prototype,
  featureMap;

featureMap = {
  'function-bind': 'bind'
};

function has(feature) {
  var prop = featureMap[feature];
  return isFunction(proto[prop]);
}

// check for missing features
if (!has('function-bind')) {
  // adapted from Mozilla Developer Network example at
  // https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Function/bind
  bind = function bind(obj) {
    var args = slice.call(arguments, 1),
      self = this,
      Nop = function() { },
      bound = function() {
        return self.apply(this instanceof Nop ? this : (obj || {}), args.concat(slice.call(arguments)));
      };
    Nop.prototype = this.prototype || {}; // Firefox cries sometimes if prototype is undefined
    bound.prototype = new Nop();
    return bound;
  };
  proto.bind = bind;
}
