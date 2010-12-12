// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
document.observe("dom:loaded", function () {
  $("tasks").observe("click", function(e) {
	if (Event.element(e).nodeName == "INPUT") {
      var id = Event.element(e).up().identify();
	  new Ajax.Request("/tasks/" + id, {
        method: 'put',
		parameters: { completed: Event.element(e).checked }
      });
	}
  });
});
