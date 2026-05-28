module main


// std
import encoding.hex

// external
import zeltonika.public.api { Zeltonika }


fn main() {
	zeltonika := Zeltonika.new()

	encoded_udp := hex.decode('003DCAFE0105000F33353230393330383634303336353508010000016B4F815B30010000000000000000000000000000000103021503010101425DBC000001')!

	decoded_udp := zeltonika.decode_udp(encoded_udp) or {
		eprintln('Failed to decode UDP data: ${err}')
		return
	}

	println('Decoded UDP data: ${decoded_udp}')
}
