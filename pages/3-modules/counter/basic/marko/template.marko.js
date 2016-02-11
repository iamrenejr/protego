function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<div class="box"><div class="box header widget-option"></div><div class="box data"><div class="box data count widget-option"></div><div class="box data label widget-option"></div></div><div class="box footer widget-option"></div></div>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);