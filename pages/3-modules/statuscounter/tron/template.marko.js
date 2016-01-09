function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<!DOCTYPE html> <html class="widgetBorder"><head><meta charset="UTF-8"><link rel="stylesheet" type="text/css" href="/style"></head><body id="tronStatus" class="widgetBorder"><section class="TronTable"><header class="TronHeader">Test</header><section class="TronBody"><div class="TronStatusWidget"><div class="loaders-container"><div class="container"><div class="line1"></div><div class="line2"></div><div class="line3"></div><div class="line4"></div></div></div><div class="tronStatusInfo"><span class="tronTeamName">Team</span><hr><span class="tronImp1Label">IMPACT 1:</span><span class="tronImp1Value">0</span></div></div></section></section><script src="/script"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);