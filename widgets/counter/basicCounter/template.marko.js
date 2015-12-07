function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXml = __helpers.x,
      escapeXmlAttr = __helpers.xa;

  return function render(data, out) {
    out.w('<html><head><title>' +
      escapeXml(data.title) +
      '</title><link rel="stylesheet" type="text/css" href="/style/widget/' +
      escapeXmlAttr(data.format) +
      '/' +
      escapeXmlAttr(data.type) +
      '"></head><body><section id="body"><section id="break"></section><section id="header">' +
      escapeXml(data.name.toUpperCase()) +
      '</section><section id="data-case"><div id="data">1050</div><span id="units">tickets<span></span></span></section></section><script type="text/javascript" src="/script/widget/' +
      escapeXmlAttr(data.format) +
      '/' +
      escapeXmlAttr(data.type) +
      '">\n\t\t</script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);