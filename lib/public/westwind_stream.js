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
    var compiledLine = _.template("<p class='line'> <%= line %> </p>");
    var compiledStanza = _.template("<div class='stanza'> <%= lines %> </div>");
    var wrappedLines = $.map(lines, function(line) {
      return compiledLine({line: line});
    });
    this.container.prepend(compiledStanza({lines: wrappedLines.join(' ')}));
  }
}
