function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXml = __helpers.x,
      escapeXmlAttr = __helpers.xa,
      forEachWithStatusVar = __helpers.fv;

  return function render(data, out) {
    out.w('<html><head><title>' +
      escapeXml(data.title) +
      '</title><link rel="stylesheet" type="text/css" href="/style/' +
      escapeXmlAttr(data.layout) +
      '/v' +
      escapeXmlAttr(data.version) +
      '"></head><body><nav>&nbsp;</nav><header>&nbsp;</header><aside id="left-bar">sidebar</aside><section id="dashboard"><section id="top-row">');

    forEachWithStatusVar(data.topRowWidgets, function(widget,loop) {
      out.w('<div class="child' +
        escapeXmlAttr(loop.getIndex()+1) +
        '"><iframe sandbox="allow-scripts allow-same-origin" src="/widget/counter/basicCounter/' +
        escapeXmlAttr(widget) +
        '"></iframe></div>');
    });

    out.w('</section><section id="bottom-row">');

    forEachWithStatusVar(data.bottomRowWidget, function(widget,loop) {
      out.w('<div class="child' +
        escapeXmlAttr(loop.getIndex()+1) +
        '"><iframe sandbox="allow-scripts allow-same-origin" src="/widget/table/basicTable/' +
        escapeXmlAttr(widget) +
        '"></iframe></div>');
    });

    out.w('</section></section></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);