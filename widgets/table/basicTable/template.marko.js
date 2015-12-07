function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXml = __helpers.x,
      escapeXmlAttr = __helpers.xa,
      forEach = __helpers.f;

  return function render(data, out) {
    out.w('<html><head><title>' +
      escapeXml(data.title) +
      '</title><link rel="stylesheet" type="text/css" href="/style/widget/' +
      escapeXmlAttr(data.format) +
      '/' +
      escapeXmlAttr(data.type) +
      '"></head><body><table class="table-minimal"><thead><tr><th>Queue</th><th>Size</th></tr></thead><tbody>');

    forEach(data.tableTeamData, function(team) {
      out.w('<tr><td>' +
        escapeXml(team) +
        '</td><td>31</td></tr>');
    });

    out.w('</tbody></table></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);