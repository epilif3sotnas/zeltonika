Zeltonika
=========

Zeltonika is a library whose main goal is handling the data of the Teltonika trackers,
which have 2 different types of data codification: JSON and binary (Teltonika Binary codecs and Teltonika JSON codec).
This library is lightweight and simple to use as a decoder and encoder for these data formats.


Installation
------------
Compatible Zig Version: `0.16.0`

Zeltonika is installed with the following steps.

`

zig fetch --save git+https://github.com/epilif3sotnas/zeltonika#<TAG>

`

You can then add the dependency in your `build.zig` file:

`

const zeltonika = b.dependency("zeltonika", .{
    .target = target,
    .optimize = optimize,
}).module("zeltonika");

exe.root_module.addImport(zeltonika);

`


Usage
-----
Zeltonika is used [USAGE_EXAMPLE].

See this `examples <../examples/>`_.


FAQ
---
Zeltonika FAQ.


Changelog
---------
See our `changelog <./CHANGELOG.rst>`_ to check the modifications for each version.


Contributing
------------
See our `contributing docs <./CONTRIBUTING.rst>`_ to be part of our contributors.


Code of Conduct
---------------
This repository does not tolerate any disrectuful behavior.
See our `code of conduct <./CODE_OF_CONDUCT.rst>`_.


License
-------
Licensed under Apache-2.0 license.