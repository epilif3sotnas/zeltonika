Zeltonika
=========
Zeltonika is a library whose main goal is handling the data of the Teltonika trackers,
which have 2 different types of data codification: JSON and binary (Teltonika Binary codecs and Teltonika JSON codec).
This library is lightweight and simple to use as a decoder and encoder for these data formats.


Installation
------------
Compatible Vlang Version: `0.4.12`

Zeltonika is installed with the following steps.

.. code-block:: bash
    :linenos:

    v install https://github.com/epilif3sotnas/zeltonika@<TAG>

You should also add the dependency in your `v.mod` file:

.. code-block:: zig
    :linenos:

    Module {
    	name: 'examples'
    	description: 'Library to parse Teltonika codecs.'
    	version: '0.0.0'
    	license: 'Apache-2.0 license'
    	dependencies: ['github.com/epilif3sotnas/zeltonika@<TAG>']
    }


Usage
-----
Zeltonika is used in the following example.

.. code-block:: v
    :linenos:

    zeltonika := Zeltonika.new()

    encoded_tcp := zeltonika.encode_tcp(data)!
    encoded_udp := zeltonika.encode_udp(data)!

    decoded_tcp := zeltonika.decode_tcp(data)!
    decoded_udp := zeltonika.decode_udp(data)!

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
