function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      __markoWidgets = require("marko-widgets"),
      _widgetAttrs = __markoWidgets.attrs,
      __getDynamicClientWidgetPath = require("marko-widgets/taglib/helpers/getDynamicClientWidgetPath"),
      __widget = "/pages/3-widgets/counter/basic-counter/widget",
      __renderer = __helpers.r,
      ____________node_modules_marko_widgets_taglib_widget_tag_js = __renderer(require("marko-widgets/taglib/widget-tag")),
      __tag = __helpers.t,
      attr = __helpers.a,
      attrs = __helpers.as;

  function __registerWidget() {
    if (typeof window != "undefined") {
      __markoWidgets.registerWidget(__widget, require("./widget"));
    }
  }

  return function render(data, out) {
    if (__registerWidget) {
      __registerWidget();
      __registerWidget = null;
    }
    
    __tag(out,
      ____________node_modules_marko_widgets_taglib_widget_tag_js,
      {
        "module": __widget,
        "_cfg": data.widgetConfig,
        "_state": data.widgetState,
        "_props": data.widgetProps,
        "_body": data.widgetBody
      },
      function(out, widget) {
        out.w('<div class="box"' +
          attr("id", widget.elId()) +
          attrs(_widgetAttrs(widget)) +
          '><div class="box header">Header</div><div class="box data"><div class="box data count">Count</div><div class="box data label">Sublabel</div></div><div class="box footer">Footer</div></div>');
      });
  };
}
(module.exports = require("marko").c(__filename)).c(create);