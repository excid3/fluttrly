Fluttr
======

Fluttr is a simple to-do list that allows you and others to add to a todo
list for all to see!

Usage
-----
At the home screen, just add your name to the text box and you're ready
to start adding to a list.

License
-------
Fluttr is protected under the AGPL license.

Please see [LICENSE](http://github.com/excid3/fluttr/blob/master/LICENSE) for more details.

Author
------
Lovingly created by [Chris Oliver](http://github.com/excid3).

API
===

The Fluttr API is ridiculously simple. Just append ".json" or ".xml" to the end of the list URL that you would like to retrieve.

JSON
----

Example: 
GET Request http://fluttr.heroku.com/test.json

Result:
    [{"task":{"name":"Example","created_at":"2010-12-19T02:58:06Z","completed":false,"updated_at":"2010-12-19T02:58:06Z","id":446,"content":"And you can easily share from the web"}},
    {"task":{"name":"Example","created_at":"2010-12-19T02:57:58Z","completed":true,"updated_at":"2010-12-19T02:58:00Z","id":445,"content":"This is a completed task"}},
    {"task":{"name":"Example","created_at":"2010-12-19T02:57:37Z","completed":false,"updated_at":"2010-12-19T02:57:51Z","id":443,"content":"Items can be checked as completed"}},
    {"task":{"name":"Example","created_at":"2010-12-19T02:57:22Z","completed":false,"updated_at":"2010-12-19T02:57:22Z","id":440,"content":"Type a new task"}}]

XML
---

Example: 
GET Request http://fluttr.heroku.com/test.xml

Result:
    <?xml version="1.0" encoding="UTF-8"?> 
    <tasks type="array"> 
      <task> 
        <name>Example</name> 
        <created-at type="datetime">2010-12-19T02:58:06Z</created-at> 
        <completed type="boolean">false</completed> 
        <updated-at type="datetime">2010-12-19T02:58:06Z</updated-at> 
        <id type="integer">446</id> 
        <content>And you can easily share from the web</content> 
      </task> 
      <task> 
        <name>Example</name> 
        <created-at type="datetime">2010-12-19T02:57:58Z</created-at> 
        <completed type="boolean">true</completed> 
        <updated-at type="datetime">2010-12-19T02:58:00Z</updated-at> 
        <id type="integer">445</id> 
        <content>This is a completed task</content> 
      </task> 
      <task> 
        <name>Example</name> 
        <created-at type="datetime">2010-12-19T02:57:37Z</created-at> 
        <completed type="boolean">false</completed> 
        <updated-at type="datetime">2010-12-19T02:57:51Z</updated-at> 
        <id type="integer">443</id> 
        <content>Items can be checked as completed</content> 
      </task> 
      <task> 
        <name>Example</name> 
        <created-at type="datetime">2010-12-19T02:57:22Z</created-at> 
        <completed type="boolean">false</completed> 
        <updated-at type="datetime">2010-12-19T02:57:22Z</updated-at> 
        <id type="integer">440</id> 
        <content>Type a new task</content> 
      </task> 
    </tasks> 

POST
----

Posting a new task is easy too! Request a normal page to retrieve the authenticity_token, then you can submit the name of the list the task is for as well as the content of the task.

Example (Python):

    #!/usr/bin/env python
    # This example assumes you have a copy of Fluttr running on localhost:3000

    import cookielib
    import re
    import urllib, urllib2

    # Build the URL opener that saves cookies
    cj = cookielib.CookieJar()
    opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cj))

    # Request the test page so that we can get the auth token
    f = opener.open("http://localhost:3000/test")
    data = f.read()

    # Parse out the auth token
    auth_token = re.search(r'name="authenticity_token".*value="(.+)"', data).group(1)

    # Setup the POST request and encode it
    data = {"authenticity_token": auth_token,
            "task[name]": "test",
            "task[content]": "This is a test",
            }
    data = urllib.urlencode(data)

    # POST!
    f = opener.open("http://localhost:3000/tasks.js", data)

    # You're done! Now visiting /test will have your new task!
