function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<section><header id="widget_slot1"></header></section><section><div class="primarycontent"><div class="panicMap widget map highlight"></div><div class="panicAssets widget table"></div></div><div class="secondarycontent"><div class="panicTickers widget table"></div><div class="panicGraphs widget table"></div></div></section><section><footer></footer></section>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);