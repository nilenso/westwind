var Westwind = Westwind || {};

Westwind.Stream = function(container) {
  this.container = container;
  eventSource = new EventSource('/stream');
  var self = this;
  eventSource.onmessage = function(event) {
    self.render(JSON.parse(event.data));
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
