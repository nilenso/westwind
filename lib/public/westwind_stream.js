var Westwind = Westwind || {};

Westwind.Stream = function(container) {
  this.container = container;
  eventSource = new EventSource('/stream');
  lazyRender = _.throttle(_.bind(this.render, this), 4000);
  eventSource.onmessage = function(event) {
    lazyRender(JSON.parse(event.data));
  }
}

Westwind.Stream.prototype = {
  render: function(lines) {
    wrappedLines = $.map(lines, function(line) {
      return "<p class='line'>" + line + "</p>";
    });
    var stanzaContainer = ["<div class='stanza'>", wrappedLines.join(' '), "<div>"].join(' ');
    this.container.prepend(stanzaContainer);
  }
}
