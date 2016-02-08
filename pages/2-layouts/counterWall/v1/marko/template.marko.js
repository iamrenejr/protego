function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne;

  return function render(data, out) {
    out.w('<section class="header-box" id="widget_header"></section><section class="wall-of-counters"><div class="first row"><span class="cell" id="widget_slot1"></span><span class="cell" id="widget_slot2"></span><span class="cell" id="widget_slot3"></span><span class="cell" id="widget_slot4"></span></div><div class="second row"><span class="cell" id="widget_slot5"></span><span class="cell" id="widget_slot6"></span><span class="cell" id="widget_slot7"></span><span class="cell" id="widget_slot8"></span></div><div class="third row"><span class="cell" id="widget_slot9"></span><span class="cell" id="widget_slot10"></span><span class="cell" id="widget_slot11"></span><span class="cell" id="widget_slot12"></span></div><div class="fourth row"><span class="cell" id="widget_slot13"></span><span class="cell" id="widget_slot14"></span><span class="cell" id="widget_slot15"></span><span class="cell" id="widget_slot16"></span></div><div class="fifth row"><span class="cell" id="widget_slot17"></span><span class="cell" id="widget_slot18"></span><span class="cell" id="widget_slot19"></span> </div></section><section class="footer-box" id="widget_footer"></section>');
  };
}
(module.exports = require("marko").c(__filename)).c(create);