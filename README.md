[![Build Status](https://travis-ci.org/bdo/uboat.png)](https://travis-ci.org/bdo/uboat)
uboat
=======

When you want to kill a process listening on a port but you only know the port number.

```ruby
require 'uboat'
UBoat.kill 80 # kills the process running at port 80
```

