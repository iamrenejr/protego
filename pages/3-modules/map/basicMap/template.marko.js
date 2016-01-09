function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<!DOCTYPE html> <html class="widgetBorder"><head><meta charset="UTF-8"><link rel="stylesheet" type="text/css" href="/style"></head><body id="basicMap" class="widgetBorder"><div id="mapContainer" class="widgetBorder"></div><script src="/script"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);