function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<html><head><title>Test</title></head><body><script src="/test/handler"></script><script src="/test/instance"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);