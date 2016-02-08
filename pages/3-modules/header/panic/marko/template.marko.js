function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<div class="logo"><img src="http://bestanimations.com/Balls&amp;Buttons/amazing-3d-computer-ball-sphere-art-animated-gif-1.gif"></div><div class="title">Panic Board</div>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);