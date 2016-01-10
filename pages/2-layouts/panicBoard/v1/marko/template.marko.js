function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXmlAttr = __helpers.xa;

  return function render(data, out) {
    out.w('<!DOCTYPE html5> <html><head><title>Panic Board</title><meta charset="UTF-8"><link rel="stylesheet" href="/layouts/' +
      escapeXmlAttr(data.name) +
      '/v1/css"></head><body><section><header><iframe src="/widgets/' +
      escapeXmlAttr(data.header) +
      '/html"></iframe></header></section><section><div class="primarycontent"><div class="panicMap widget map highlight"><iframe src="/widgets/' +
      escapeXmlAttr(data.primary) +
      '/html"></iframe></div><div class="panicAssets widget table"><iframe src="/widgets/' +
      escapeXmlAttr(data.secondary) +
      '"></iframe></div></div><div class="secondarycontent"><div class="panicTickers widget table"><iframe src="/widgets/' +
      escapeXmlAttr(data.tertiary) +
      '"></iframe></div><div class="panicGraphs widget table"><iframe src="/widgets/' +
      escapeXmlAttr(data.quaternary) +
      '"></iframe></div></div></section><section><footer><iframe src="/widgets/' +
      escapeXmlAttr(data.footer) +
      '"></iframe></footer></section><script type="text/javascript" src="/layouts/' +
      escapeXmlAttr(data.name) +
      '/v1/js"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);