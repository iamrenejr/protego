function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXmlAttr = __helpers.xa;

  return function render(data, out) {
    out.w('<!DOCTYPE html5> <html><head><title>Panic Board Header</title><meta charset="UTF-8"><link rel="stylesheet" href="/widgets/' +
      escapeXmlAttr(data.format) +
      '/' +
      escapeXmlAttr(data.name) +
      '/css"></head><body><section class="header"><div class="logo"><img src="http://bestanimations.com/Balls&amp;Buttons/amazing-3d-computer-ball-sphere-art-animated-gif-1.gif"></div><div class="title">Panic Board</div></section><script type="text/javascript" src="/widgets/' +
      escapeXmlAttr(data.format) +
      '/' +
      escapeXmlAttr(data.name) +
      '/js"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);