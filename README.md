# puppet-hiera-extend

A simple puppet module that defines a function `hiera_extend()` that works similar to the normal `hiera()` lookup function with 1 difference.

If the second argument is a Hash, instead of using the value as a default, the value returned by the lookup will be merged with the second argument similar to [jQuery's extend function](http://api.jquery.com/jquery.extend/).
