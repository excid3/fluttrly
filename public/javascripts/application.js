// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
document.observe("dom:loaded", function () {
  $("tasks").observe("click", function(e) {
      var c = Event.element(e);
      if (c.nodeName == "INPUT") {
	
	if (c.checked) {
	  c.next().addClassName("completed");
	} else {
	  c.next().removeClassName("completed");
	}

	var id = c.up().identify();
	new Ajax.Request("/tasks/" + id, {
	  method: 'put',
	  parameters: { completed: c.checked }
	});
      }
  });
});
