module crc


// 8-bit CRC algorithms
const alg_crc8_autosar = Algorithm.new[u8](0x2f, 0xff, false, false, 0xff)
const alg_crc8_bluetooth = Algorithm.new[u8](0xa7, 0x00, true, true, 0x00)
const alg_crc8_cdma2000 = Algorithm.new[u8](0x9b, 0xff, false, false, 0x00)
const alg_crc8_darc = Algorithm.new[u8](0x39, 0x00, true, true, 0x00)
const alg_crc8_dvb_s2 = Algorithm.new[u8](0xd5, 0x00, false, false, 0x00)
const alg_crc8_gsm_a = Algorithm.new[u8](0x1d, 0x00, false, false, 0x00)
const alg_crc8_gsm_b = Algorithm.new[u8](0x49, 0x00, false, false, 0xff)
const alg_crc8_hitag = Algorithm.new[u8](0x1d, 0xff, false, false, 0x00)
const alg_crc8_i4321 = Algorithm.new[u8](0x07, 0x00, false, false, 0x55)
const alg_crc8_icode = Algorithm.new[u8](0x1d, 0xfd, false, false, 0x00)
const alg_crc8_lte = Algorithm.new[u8](0x9b, 0x00, false, false, 0x00)
const alg_crc8_maxim_dow = Algorithm.new[u8](0x31, 0x00, true, true, 0x00)
const alg_crc8_mifare_mad = Algorithm.new[u8](0x1d, 0xc7, false, false, 0x00)
const alg_crc8_nrsc5 = Algorithm.new[u8](0x31, 0xff, false, false, 0x00)
const alg_crc8_opensafety = Algorithm.new[u8](0x2f, 0x00, false, false, 0x00)
const alg_crc8_rohc = Algorithm.new[u8](0x07, 0xff, true, true, 0x00)
const alg_crc8_sae_j1850 = Algorithm.new[u8](0x1d, 0xff, false, false, 0xff)
const alg_crc8_smbus = Algorithm.new[u8](0x07, 0x00, false, false, 0x00)
const alg_crc8_tech3250 = Algorithm.new[u8](0x1d, 0xff, true, true, 0x00)
const alg_crc8_wcdma = Algorithm.new[u8](0x9b, 0x00, true, true, 0x00)

// 16-bit CRC algorithms
const alg_crc16_arc = Algorithm.new[u16](0x8005, 0x0000, true, true, 0x0000)
const alg_crc16_cdma2000 = Algorithm.new[u16](0xc867, 0xffff, false, false, 0x0000)
const alg_crc16_cms = Algorithm.new[u16](0x8005, 0xffff, false, false, 0x0000)
const alg_crc16_dds110 = Algorithm.new[u16](0x8005, 0x800d, false, false, 0x0000)
const alg_crc16_dect_r = Algorithm.new[u16](0x0589, 0x0000, false, false, 0x0001)
const alg_crc16_dect_x = Algorithm.new[u16](0x0589, 0x0000, false, false, 0x0000)
const alg_crc16_dnp = Algorithm.new[u16](0x3d65, 0x0000, true, true, 0xffff)
const alg_crc16_en13757 = Algorithm.new[u16](0x3d65, 0x0000, false, false, 0xffff)
const alg_crc16_genibus = Algorithm.new[u16](0x1021, 0xffff, false, false, 0xffff)
const alg_crc16_gsm = Algorithm.new[u16](0x1021, 0x0000, false, false, 0xffff)
const alg_crc16_ibm3740 = Algorithm.new[u16](0x1021, 0xffff, false, false, 0x0000)
const alg_crc16_ibm_sdlc = Algorithm.new[u16](0x1021, 0xffff, true, true, 0xffff)
const alg_crc16_iso_iec_144433a = Algorithm.new[u16](0x1021, 0xc6c6, true, true, 0x0000)
const alg_crc16_kermit = Algorithm.new[u16](0x1021, 0x0000, true, true, 0x0000)
const alg_crc16_lj1200 = Algorithm.new[u16](0x6f63, 0x0000, false, false, 0x0000)
const alg_crc16_m17 = Algorithm.new[u16](0x5935, 0xffff, false, false, 0x0000)
const alg_crc16_maxim_dow = Algorithm.new[u16](0x8005, 0x0000, true, true, 0xffff)
const alg_crc16_mcrf4xx = Algorithm.new[u16](0x1021, 0xffff, true, true, 0x0000)
const alg_crc16_modbus = Algorithm.new[u16](0x8005, 0xffff, true, true, 0x0000)
const alg_crc16_nrsc5 = Algorithm.new[u16](0x080b, 0xffff, true, true, 0x0000)
const alg_crc16_opensafety_a = Algorithm.new[u16](0x5935, 0x0000, false, false, 0x0000)
const alg_crc16_opensafety_b = Algorithm.new[u16](0x755b, 0x0000, false, false, 0x0000)
const alg_crc16_profibus = Algorithm.new[u16](0x1dcf, 0xffff, false, false, 0xffff)
const alg_crc16_riello = Algorithm.new[u16](0x1021, 0xb2aa, true, true, 0x0000)
const alg_crc16_spi_fujitsu = Algorithm.new[u16](0x1021, 0x1d0f, false, false, 0x0000)
const alg_crc16_t10_dif = Algorithm.new[u16](0x8bb7, 0x0000, false, false, 0x0000)
const alg_crc16_teledisk = Algorithm.new[u16](0xa097, 0x0000, false, false, 0x0000)
const alg_crc16_tms37157 = Algorithm.new[u16](0x1021, 0x89ec, true, true, 0x0000)
const alg_crc16_umts = Algorithm.new[u16](0x8005, 0x0000, false, false, 0x0000)
const alg_crc16_usb = Algorithm.new[u16](0x8005, 0xffff, true, true, 0xffff)
const alg_crc16_xmodem = Algorithm.new[u16](0x1021, 0x0000, false, false, 0x0000)

// 32-bit CRC algorithms
const alg_crc32_aixm = Algorithm.new[u32](0x814141ab, 0x00000000, false, false, 0x00000000)
const alg_crc32_autosar = Algorithm.new[u32](0xf4acfb13, 0xffffffff, true, true, 0xffffffff)
const alg_crc32_base91_d = Algorithm.new[u32](0xa833982b, 0xffffffff, true, true, 0xffffffff)
const alg_crc32_bzip2 = Algorithm.new[u32](0x04c11db7, 0xffffffff, false, false, 0xffffffff)
const alg_crc32_cdrom_edc = Algorithm.new[u32](0x8001801b, 0x00000000, true, true, 0x00000000)
const alg_crc32_cksum = Algorithm.new[u32](0x04c11db7, 0x00000000, false, false, 0xffffffff)
const alg_crc32_iso_hdlc = Algorithm.new[u32](0x04c11db7, 0xffffffff, true, true, 0xffffffff)
const alg_crc32_iscsi = Algorithm.new[u32](0x1edc6f41, 0xffffffff, true, true, 0xffffffff)
const alg_crc32_jamcrc = Algorithm.new[u32](0x04c11db7, 0xffffffff, true, true, 0x00000000)
const alg_crc32_koopman = Algorithm.new[u32](0x741b8cd7, 0xffffffff, true, true, 0xffffffff)
const alg_crc32_mef = Algorithm.new[u32](0x741b8cd7, 0xffffffff, true, true, 0x00000000)
const alg_crc32_mpeg2 = Algorithm.new[u32](0x04c11db7, 0xffffffff, false, false, 0x00000000)
const alg_crc32_xfer = Algorithm.new[u32](0x000000af, 0x00000000, false, false, 0x00000000)

// 64-bit CRC algorithms
const alg_crc64_ecma182 = Algorithm.new[u64](0x42f0e1eba9ea3693, 0x0000000000000000, false, false, 0x0000000000000000)
const alg_crc64_go_iso = Algorithm.new[u64](0x000000000000001b, 0xffffffffffffffff, true, true, 0xffffffffffffffff)
const alg_crc64_ms = Algorithm.new[u64](0x259c84cba6426349, 0xffffffffffffffff, true, true, 0x0000000000000000)
const alg_crc64_redis = Algorithm.new[u64](0xad93d23594c935a9, 0x0000000000000000, true, true, 0x0000000000000000)
const alg_crc64_we = Algorithm.new[u64](0x42f0e1eba9ea3693, 0xffffffffffffffff, false, false, 0xffffffffffffffff)
const alg_crc64_xz = Algorithm.new[u64](0x42f0e1eba9ea3693, 0xffffffffffffffff, true, true, 0xffffffffffffffff)


// 8-bit factory functions
pub fn crc8_autosar() Crc[u8] { return Crc.new(alg_crc8_autosar) }
pub fn crc8_bluetooth() Crc[u8] { return Crc.new(alg_crc8_bluetooth) }
pub fn crc8_cdma2000() Crc[u8] { return Crc.new(alg_crc8_cdma2000) }
pub fn crc8_darc() Crc[u8] { return Crc.new(alg_crc8_darc) }
pub fn crc8_dvb_s2() Crc[u8] { return Crc.new(alg_crc8_dvb_s2) }
pub fn crc8_gsm_a() Crc[u8] { return Crc.new(alg_crc8_gsm_a) }
pub fn crc8_gsm_b() Crc[u8] { return Crc.new(alg_crc8_gsm_b) }
pub fn crc8_hitag() Crc[u8] { return Crc.new(alg_crc8_hitag) }
pub fn crc8_i4321() Crc[u8] { return Crc.new(alg_crc8_i4321) }
pub fn crc8_icode() Crc[u8] { return Crc.new(alg_crc8_icode) }
pub fn crc8_lte() Crc[u8] { return Crc.new(alg_crc8_lte) }
pub fn crc8_maxim_dow() Crc[u8] { return Crc.new(alg_crc8_maxim_dow) }
pub fn crc8_mifare_mad() Crc[u8] { return Crc.new(alg_crc8_mifare_mad) }
pub fn crc8_nrsc5() Crc[u8] { return Crc.new(alg_crc8_nrsc5) }
pub fn crc8_opensafety() Crc[u8] { return Crc.new(alg_crc8_opensafety) }
pub fn crc8_rohc() Crc[u8] { return Crc.new(alg_crc8_rohc) }
pub fn crc8_sae_j1850() Crc[u8] { return Crc.new(alg_crc8_sae_j1850) }
pub fn crc8_smbus() Crc[u8] { return Crc.new(alg_crc8_smbus) }
pub fn crc8_tech3250() Crc[u8] { return Crc.new(alg_crc8_tech3250) }
pub fn crc8_wcdma() Crc[u8] { return Crc.new(alg_crc8_wcdma) }

// 16-bit factory functions
pub fn crc16_arc() Crc[u16] { return Crc.new(alg_crc16_arc) }
pub fn crc16_cdma2000() Crc[u16] { return Crc.new(alg_crc16_cdma2000) }
pub fn crc16_cms() Crc[u16] { return Crc.new(alg_crc16_cms) }
pub fn crc16_dds110() Crc[u16] { return Crc.new(alg_crc16_dds110) }
pub fn crc16_dect_r() Crc[u16] { return Crc.new(alg_crc16_dect_r) }
pub fn crc16_dect_x() Crc[u16] { return Crc.new(alg_crc16_dect_x) }
pub fn crc16_dnp() Crc[u16] { return Crc.new(alg_crc16_dnp) }
pub fn crc16_en13757() Crc[u16] { return Crc.new(alg_crc16_en13757) }
pub fn crc16_genibus() Crc[u16] { return Crc.new(alg_crc16_genibus) }
pub fn crc16_gsm() Crc[u16] { return Crc.new(alg_crc16_gsm) }
pub fn crc16_ibm3740() Crc[u16] { return Crc.new(alg_crc16_ibm3740) }
pub fn crc16_ibm_sdlc() Crc[u16] { return Crc.new(alg_crc16_ibm_sdlc) }
pub fn crc16_iso_iec_144433a() Crc[u16] { return Crc.new(alg_crc16_iso_iec_144433a) }
pub fn crc16_kermit() Crc[u16] { return Crc.new(alg_crc16_kermit) }
pub fn crc16_lj1200() Crc[u16] { return Crc.new(alg_crc16_lj1200) }
pub fn crc16_m17() Crc[u16] { return Crc.new(alg_crc16_m17) }
pub fn crc16_maxim_dow() Crc[u16] { return Crc.new(alg_crc16_maxim_dow) }
pub fn crc16_mcrf4xx() Crc[u16] { return Crc.new(alg_crc16_mcrf4xx) }
pub fn crc16_modbus() Crc[u16] { return Crc.new(alg_crc16_modbus) }
pub fn crc16_nrsc5() Crc[u16] { return Crc.new(alg_crc16_nrsc5) }
pub fn crc16_opensafety_a() Crc[u16] { return Crc.new(alg_crc16_opensafety_a) }
pub fn crc16_opensafety_b() Crc[u16] { return Crc.new(alg_crc16_opensafety_b) }
pub fn crc16_profibus() Crc[u16] { return Crc.new(alg_crc16_profibus) }
pub fn crc16_riello() Crc[u16] { return Crc.new(alg_crc16_riello) }
pub fn crc16_spi_fujitsu() Crc[u16] { return Crc.new(alg_crc16_spi_fujitsu) }
pub fn crc16_t10_dif() Crc[u16] { return Crc.new(alg_crc16_t10_dif) }
pub fn crc16_teledisk() Crc[u16] { return Crc.new(alg_crc16_teledisk) }
pub fn crc16_tms37157() Crc[u16] { return Crc.new(alg_crc16_tms37157) }
pub fn crc16_umts() Crc[u16] { return Crc.new(alg_crc16_umts) }
pub fn crc16_usb() Crc[u16] { return Crc.new(alg_crc16_usb) }
pub fn crc16_xmodem() Crc[u16] { return Crc.new(alg_crc16_xmodem) }

// 32-bit factory functions
pub fn crc32_aixm() Crc[u32] { return Crc.new(alg_crc32_aixm) }
pub fn crc32_autosar() Crc[u32] { return Crc.new(alg_crc32_autosar) }
pub fn crc32_base91_d() Crc[u32] { return Crc.new(alg_crc32_base91_d) }
pub fn crc32_bzip2() Crc[u32] { return Crc.new(alg_crc32_bzip2) }
pub fn crc32_cdrom_edc() Crc[u32] { return Crc.new(alg_crc32_cdrom_edc) }
pub fn crc32_cksum() Crc[u32] { return Crc.new(alg_crc32_cksum) }
pub fn crc32_iso_hdlc() Crc[u32] { return Crc.new(alg_crc32_iso_hdlc) }
pub fn crc32_iscsi() Crc[u32] { return Crc.new(alg_crc32_iscsi) }
pub fn crc32_jamcrc() Crc[u32] { return Crc.new(alg_crc32_jamcrc) }
pub fn crc32_koopman() Crc[u32] { return Crc.new(alg_crc32_koopman) }
pub fn crc32_mef() Crc[u32] { return Crc.new(alg_crc32_mef) }
pub fn crc32_mpeg2() Crc[u32] { return Crc.new(alg_crc32_mpeg2) }
pub fn crc32_xfer() Crc[u32] { return Crc.new(alg_crc32_xfer) }

// 64-bit factory functions
pub fn crc64_ecma182() Crc[u64] { return Crc.new(alg_crc64_ecma182) }
pub fn crc64_go_iso() Crc[u64] { return Crc.new(alg_crc64_go_iso) }
pub fn crc64_ms() Crc[u64] { return Crc.new(alg_crc64_ms) }
pub fn crc64_redis() Crc[u64] { return Crc.new(alg_crc64_redis) }
pub fn crc64_we() Crc[u64] { return Crc.new(alg_crc64_we) }
pub fn crc64_xz() Crc[u64] { return Crc.new(alg_crc64_xz) }
