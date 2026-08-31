# Zeltonika

Zeltonika is a library whose main goal is handling the data of Teltonika trackers,
which have two different types of data codification: JSON and binary (Teltonika
Binary codecs and Teltonika JSON codec). This library is lightweight and simple
to use as a decoder and encoder for these data formats.

## Installation

Compatible V language version: `0.4.12`

Install Zeltonika with:

```bash
v install https://github.com/epilif3sotnas/zeltonika@<TAG>
```

You should also add the dependency to your `v.mod` file:

```v
Module {
	name: 'examples'
	description: 'Library to parse Teltonika codecs.'
	version: '0.0.0'
	license: 'Apache-2.0 license'
	dependencies: ['github.com/epilif3sotnas/zeltonika@<TAG>']
}
```

## Usage

Use Zeltonika as follows:

```v
zeltonika := Zeltonika.new()

encoded_tcp := zeltonika.encode_tcp(data)!
encoded_udp := zeltonika.encode_udp(data)!

decoded_tcp := zeltonika.decode_tcp(data)!
decoded_udp := zeltonika.decode_udp(data)!
```

See the [examples](examples/).

## FAQ

Zeltonika FAQ.

## Contributing

See the [contributing guidelines](CONTRIBUTING.md) to learn how to contribute.

## Code of Conduct

This repository does not tolerate disrespectful behavior. See the [Code of Conduct](CODE_OF_CONDUCT.md).

## Security

See the [security policy](SECURITY.md) for how to report vulnerabilities.

## Authors

See [authors](AUTHORS.rst).

## License

Licensed under the Apache-2.0 license. See [LICENSE](LICENSE).
