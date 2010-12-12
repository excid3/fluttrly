// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
document.observe("dom:loaded", function () {
  $("tasks").observe("click", function(e) {
      var c = Event.element(e);
      if (c.nodeName == "INPUT") {
	
	if (c.checked) {
	  c.next().addClassName("completed");
	  decrementCount();
	} else {
	  c.next().removeClassName("completed");
	  incrementCount();
	}

	var id = c.up().identify();
	new Ajax.Request("/tasks/" + id, {
	  method: 'put',
	  parameters: { completed: c.checked }
	});
      }
  });
});

function incrementCount() {
    updateTitle(getCount() + 1);
}

function decrementCount() {
    updateTitle(getCount() - 1);
}

function getCount() {
    return parseInt(document.title.split("(")[1].split(")")[0]);
}
function updateTitle(count) {
    var title = document.title.split("(")[0];
    document.title = title + " (" + count + ") on Fluttr";
}
