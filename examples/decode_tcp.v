module main


// std
import encoding.hex

// external
import zeltonika.public.api { Zeltonika }


fn main() {
	zeltonika := Zeltonika.new()

	encoded_tcp := hex.decode('000000000000003608010000016B40D8EA30010000000000000000000000000000000105021503010101425E0F01F10000601A014E0000000000000000010000C7CF')!

	decoded_tcp := zeltonika.decode_tcp(encoded_tcp) or {
		eprintln('Failed to decode TCP data: ${err}')
		return
	}

	println('Decoded TCP data: ${decoded_tcp}')
}
