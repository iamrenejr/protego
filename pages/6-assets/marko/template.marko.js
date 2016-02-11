function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<!DOCTYPE html5> <html><head><title>Landing</title></head><body><section id="activePage"></section><script type="text/javascript" src="/assets/js"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);