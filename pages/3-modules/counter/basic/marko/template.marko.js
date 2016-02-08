function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<div class="box"><div class="box header">Header</div><div class="box data"><div class="box data count">Count</div><div class="box data label">Sublabel</div></div><div class="box footer">Footer</div></div>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);