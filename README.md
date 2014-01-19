grampus
=======

When you want to kill a process listening on a port but you only know the port number

```ruby
require 'grampus'
Grampus.kill 80 # kills the process running at port 80
```

