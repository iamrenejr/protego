function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<!DOCTYPE html> <html><head><meta charset="UTF-8"><link rel="stylesheet" type="text/css" href="/style/widget/map/basicMap"></head><body><script src="/script/widget/map/basicMap"></script></body></html>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);