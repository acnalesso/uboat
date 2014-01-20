uboat
=======

When you want to kill a process listening on a port but you only know the port number, send the u-boat wolfpack!

```ruby
require 'uboat'
UBoat.kill 80 # kills the process running at port 80
```

