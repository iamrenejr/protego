function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXmlAttr = __helpers.xa;

  return function render(data, out) {
    out.w('<!DOCTYPE html> <html class="widgetBorder"><head><meta charset="UTF-8"><title>Exploding Map</title><link rel="stylesheet" type="text/css" href="/widgets/' +
      escapeXmlAttr(data.format) +
      '/' +
      escapeXmlAttr(data.name) +
      '/css"></head><body id="basicMap" class="widgetBorder"><div id="mapContainer" class="widgetBorder"></div><script src="/widgets/' +
      escapeXmlAttr(data.format) +
      '/' +
      escapeXmlAttr(data.name) +
      '/js"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);