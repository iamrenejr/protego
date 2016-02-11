function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<div class="header"><span class="header title widget-option"></span></div>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);