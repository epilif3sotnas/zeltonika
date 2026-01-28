module ut_crc


// internal
import internal.utils.crc as crc_mod


fn test__new__should_return_an_crc() {
  alg_test := crc_mod.Algorithm.new[u64](u64(0x00000000), u64(0xffffffff), true, true, u64(0xffffffff))
  crc := crc_mod.Crc.new[u64](alg_test)
}

// 8-bit CRC tests
fn test__hash__should_return_a_valid_crc8_autosar() {
  mut crc := crc_mod.crc8_autosar()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0xdf

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xdf
}

fn test__hash__should_return_a_valid_crc8_bluetooth() {
  mut crc := crc_mod.crc8_bluetooth()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0x26

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x26
}

fn test__hash__should_return_a_valid_crc8_cdma2000() {
  mut crc := crc_mod.crc8_cdma2000()

  assert crc.hash("".bytes()) == 0xff
  assert crc.hash("123456789".bytes()) == 0xda

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xda
}

fn test__hash__should_return_a_valid_crc8_darc() {
  mut crc := crc_mod.crc8_darc()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0x15

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x15
}

fn test__hash__should_return_a_valid_crc8_dvb_s2() {
  mut crc := crc_mod.crc8_dvb_s2()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0xbc

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xbc
}

fn test__hash__should_return_a_valid_crc8_gsm_a() {
  mut crc := crc_mod.crc8_gsm_a()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0x37

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x37
}

fn test__hash__should_return_a_valid_crc8_gsm_b() {
  mut crc := crc_mod.crc8_gsm_b()

  assert crc.hash("".bytes()) == 0xff
  assert crc.hash("123456789".bytes()) == 0x94

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x94
}

fn test__hash__should_return_a_valid_crc8_hitag() {
  mut crc := crc_mod.crc8_hitag()

  assert crc.hash("".bytes()) == 0xff
  assert crc.hash("123456789".bytes()) == 0xb4

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xb4
}

fn test__hash__should_return_a_valid_crc8_i4321() {
  mut crc := crc_mod.crc8_i4321()

  assert crc.hash("".bytes()) == 0x55
  assert crc.hash("123456789".bytes()) == 0xa1

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xa1
}

fn test__hash__should_return_a_valid_crc8_icode() {
  mut crc := crc_mod.crc8_icode()

  assert crc.hash("".bytes()) == 0xfd
  assert crc.hash("123456789".bytes()) == 0x7e

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x7e
}

fn test__hash__should_return_a_valid_crc8_lte() {
  mut crc := crc_mod.crc8_lte()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0xea

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xea
}

fn test__hash__should_return_a_valid_crc8_maxim_dow() {
  mut crc := crc_mod.crc8_maxim_dow()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0xa1

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xa1
}

fn test__hash__should_return_a_valid_crc8_mifare_mad() {
  mut crc := crc_mod.crc8_mifare_mad()

  assert crc.hash("".bytes()) == 0xc7
  assert crc.hash("123456789".bytes()) == 0x99

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x99
}

fn test__hash__should_return_a_valid_crc8_nrsc5() {
  mut crc := crc_mod.crc8_nrsc5()

  assert crc.hash("".bytes()) == 0xff
  assert crc.hash("123456789".bytes()) == 0xf7

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xf7
}

fn test__hash__should_return_a_valid_crc8_opensafety() {
  mut crc := crc_mod.crc8_opensafety()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0x3e

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x3e
}

fn test__hash__should_return_a_valid_crc8_rohc() {
  mut crc := crc_mod.crc8_rohc()

  assert crc.hash("".bytes()) == 0xff
  assert crc.hash("123456789".bytes()) == 0xd0

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xd0
}

fn test__hash__should_return_a_valid_crc8_sae_j1850() {
  mut crc := crc_mod.crc8_sae_j1850()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0x4b

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x4b
}

fn test__hash__should_return_a_valid_crc8_smbus() {
  mut crc := crc_mod.crc8_smbus()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0xf4

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xf4
}

fn test__hash__should_return_a_valid_crc8_tech3250() {
  mut crc := crc_mod.crc8_tech3250()

  assert crc.hash("".bytes()) == 0xff
  assert crc.hash("123456789".bytes()) == 0x97

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x97
}

fn test__hash__should_return_a_valid_crc8_wcdma() {
  mut crc := crc_mod.crc8_wcdma()

  assert crc.hash("".bytes()) == 0x00
  assert crc.hash("123456789".bytes()) == 0x25

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x25
}

// 16-bit CRC tests
fn test__hash__should_return_a_valid_crc16_arc() {
  mut crc := crc_mod.crc16_arc()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0xbb3d

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xbb3d
}

fn test__hash__should_return_a_valid_crc16_cdma2000() {
  mut crc := crc_mod.crc16_cdma2000()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0x4c06

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x4c06
}

fn test__hash__should_return_a_valid_crc16_cms() {
  mut crc := crc_mod.crc16_cms()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0xaee7

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xaee7
}

fn test__hash__should_return_a_valid_crc16_dds110() {
  mut crc := crc_mod.crc16_dds110()

  assert crc.hash("".bytes()) == 0x800d
  assert crc.hash("123456789".bytes()) == 0x9ecf

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x9ecf
}

fn test__hash__should_return_a_valid_crc16_dect_r() {
  mut crc := crc_mod.crc16_dect_r()

  assert crc.hash("".bytes()) == 0x0001
  assert crc.hash("123456789".bytes()) == 0x007e

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x007e
}

fn test__hash__should_return_a_valid_crc16_dect_x() {
  mut crc := crc_mod.crc16_dect_x()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0x007f

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x007f
}

fn test__hash__should_return_a_valid_crc16_dnp() {
  mut crc := crc_mod.crc16_dnp()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0xea82

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xea82
}

fn test__hash__should_return_a_valid_crc16_en13757() {
  mut crc := crc_mod.crc16_en13757()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0xc2b7

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xc2b7
}

fn test__hash__should_return_a_valid_crc16_genibus() {
  mut crc := crc_mod.crc16_genibus()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0xd64e

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xd64e
}

fn test__hash__should_return_a_valid_crc16_gsm() {
  mut crc := crc_mod.crc16_gsm()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0xce3c

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xce3c
}

fn test__hash__should_return_a_valid_crc16_ibm3740() {
  mut crc := crc_mod.crc16_ibm3740()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0x29b1

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x29b1
}

fn test__hash__should_return_a_valid_crc16_ibm_sdlc() {
  mut crc := crc_mod.crc16_ibm_sdlc()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0x906e

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x906e
}

fn test__hash__should_return_a_valid_crc16_iso_iec_144433a() {
  mut crc := crc_mod.crc16_iso_iec_144433a()

  assert crc.hash("".bytes()) == 0x6363
  assert crc.hash("123456789".bytes()) == 0xbf05

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xbf05
}

fn test__hash__should_return_a_valid_crc16_kermit() {
  mut crc := crc_mod.crc16_kermit()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0x2189

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x2189
}

fn test__hash__should_return_a_valid_crc16_lj1200() {
  mut crc := crc_mod.crc16_lj1200()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0xbdf4

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xbdf4
}

fn test__hash__should_return_a_valid_crc16_m17() {
  mut crc := crc_mod.crc16_m17()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0x772b

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x772b
}

fn test__hash__should_return_a_valid_crc16_maxim_dow() {
  mut crc := crc_mod.crc16_maxim_dow()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0x44c2

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x44c2
}

fn test__hash__should_return_a_valid_crc16_mcrf4xx() {
  mut crc := crc_mod.crc16_mcrf4xx()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0x6f91

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x6f91
}

fn test__hash__should_return_a_valid_crc16_modbus() {
  mut crc := crc_mod.crc16_modbus()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0x4b37

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x4b37
}

fn test__hash__should_return_a_valid_crc16_nrsc5() {
  mut crc := crc_mod.crc16_nrsc5()

  assert crc.hash("".bytes()) == 0xffff
  assert crc.hash("123456789".bytes()) == 0xa066

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xa066
}

fn test__hash__should_return_a_valid_crc16_opensafety_a() {
  mut crc := crc_mod.crc16_opensafety_a()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0x5d38

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x5d38
}

fn test__hash__should_return_a_valid_crc16_opensafety_b() {
  mut crc := crc_mod.crc16_opensafety_b()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0x20fe

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x20fe
}

fn test__hash__should_return_a_valid_crc16_profibus() {
  mut crc := crc_mod.crc16_profibus()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0xa819

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xa819
}

fn test__hash__should_return_a_valid_crc16_riello() {
  mut crc := crc_mod.crc16_riello()

  assert crc.hash("".bytes()) == 0x554d
  assert crc.hash("123456789".bytes()) == 0x63d0

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x63d0
}

fn test__hash__should_return_a_valid_crc16_spi_fujitsu() {
  mut crc := crc_mod.crc16_spi_fujitsu()

  assert crc.hash("".bytes()) == 0x1d0f
  assert crc.hash("123456789".bytes()) == 0xe5cc

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xe5cc
}

fn test__hash__should_return_a_valid_crc16_t10_dif() {
  mut crc := crc_mod.crc16_t10_dif()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0xd0db

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xd0db
}

fn test__hash__should_return_a_valid_crc16_teledisk() {
  mut crc := crc_mod.crc16_teledisk()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0x0fb3

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x0fb3
}

fn test__hash__should_return_a_valid_crc16_tms37157() {
  mut crc := crc_mod.crc16_tms37157()

  assert crc.hash("".bytes()) == 0x3791
  assert crc.hash("123456789".bytes()) == 0x26b1

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x26b1
}

fn test__hash__should_return_a_valid_crc16_umts() {
  mut crc := crc_mod.crc16_umts()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0xfee8

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xfee8
}

fn test__hash__should_return_a_valid_crc16_usb() {
  mut crc := crc_mod.crc16_usb()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0xb4c8

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xb4c8
}

fn test__hash__should_return_a_valid_crc16_xmodem() {
  mut crc := crc_mod.crc16_xmodem()

  assert crc.hash("".bytes()) == 0x0000
  assert crc.hash("123456789".bytes()) == 0x31c3

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x31c3
}

// 32-bit CRC tests
fn test__hash__should_return_a_valid_crc32_aixm() {
  mut crc := crc_mod.crc32_aixm()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0x3010bf7f

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x3010bf7f
}

fn test__hash__should_return_a_valid_crc32_autosar() {
  mut crc := crc_mod.crc32_autosar()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0x1697d06a

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x1697d06a
}

fn test__hash__should_return_a_valid_crc32_base91_d() {
  mut crc := crc_mod.crc32_base91_d()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0x87315576

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x87315576
}

fn test__hash__should_return_a_valid_crc32_bzip2() {
  mut crc := crc_mod.crc32_bzip2()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0xfc891918

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xfc891918
}

fn test__hash__should_return_a_valid_crc32_cdrom_edc() {
  mut crc := crc_mod.crc32_cdrom_edc()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0x6ec2edc4

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x6ec2edc4
}

fn test__hash__should_return_a_valid_crc32_cksum() {
  mut crc := crc_mod.crc32_cksum()

  assert crc.hash("".bytes()) == 0xffffffff
  assert crc.hash("123456789".bytes()) == 0x765e7680

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x765e7680
}

fn test__hash__should_return_a_valid_crc32_iso_hdlc() {
  mut crc := crc_mod.crc32_iso_hdlc()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0xcbf43926

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xcbf43926
}

fn test__hash__should_return_a_valid_crc32_iscsi() {
  mut crc := crc_mod.crc32_iscsi()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0xe3069283

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xe3069283
}

fn test__hash__should_return_a_valid_crc32_jamcrc() {
  mut crc := crc_mod.crc32_jamcrc()

  assert crc.hash("".bytes()) == 0xffffffff
  assert crc.hash("123456789".bytes()) == 0x340bc6d9

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x340bc6d9
}

fn test__hash__should_return_a_valid_crc32_koopman() {
  mut crc := crc_mod.crc32_koopman()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0x2d3dd0ae

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x2d3dd0ae
}

fn test__hash__should_return_a_valid_crc32_mef() {
  mut crc := crc_mod.crc32_mef()

  assert crc.hash("".bytes()) == 0xffffffff
  assert crc.hash("123456789".bytes()) == 0xd2c22f51

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xd2c22f51
}

fn test__hash__should_return_a_valid_crc32_mpeg2() {
  mut crc := crc_mod.crc32_mpeg2()

  assert crc.hash("".bytes()) == 0xffffffff
  assert crc.hash("123456789".bytes()) == 0x0376e6e7

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x0376e6e7
}

fn test__hash__should_return_a_valid_crc32_xfer() {
  mut crc := crc_mod.crc32_xfer()

  assert crc.hash("".bytes()) == 0x00000000
  assert crc.hash("123456789".bytes()) == 0xbd0be338

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xbd0be338
}

// 64-bit CRC tests
fn test__hash__should_return_a_valid_crc64_ecma182() {
  mut crc := crc_mod.crc64_ecma182()

  assert crc.hash("".bytes()) == 0x0000000000000000
  assert crc.hash("123456789".bytes()) == 0x6c40df5f0b497347

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x6c40df5f0b497347
}

fn test__hash__should_return_a_valid_crc64_go_iso() {
  mut crc := crc_mod.crc64_go_iso()

  assert crc.hash("".bytes()) == 0x0000000000000000
  assert crc.hash("123456789".bytes()) == 0xb90956c775a41001

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xb90956c775a41001
}

fn test__hash__should_return_a_valid_crc64_ms() {
  mut crc := crc_mod.crc64_ms()

  assert crc.hash("".bytes()) == 0xffffffffffffffff
  assert crc.hash("123456789".bytes()) == 0x75d4b74f024eceea

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x75d4b74f024eceea
}

fn test__hash__should_return_a_valid_crc64_redis() {
  mut crc := crc_mod.crc64_redis()

  assert crc.hash("".bytes()) == 0x0000000000000000
  assert crc.hash("123456789".bytes()) == 0xe9c6d914c4b8d9ca

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0xe9c6d914c4b8d9ca
}

fn test__hash__should_return_a_valid_crc64_we() {
  mut crc := crc_mod.crc64_we()

  assert crc.hash("".bytes()) == 0x0000000000000000
  assert crc.hash("123456789".bytes()) == 0x62ec59e3f1a4f00a

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x62ec59e3f1a4f00a
}

fn test__hash__should_return_a_valid_crc64_xz() {
  mut crc := crc_mod.crc64_xz()

  assert crc.hash("".bytes()) == 0x0000000000000000
  assert crc.hash("123456789".bytes()) == 0x995dc9bbdf1939fa

  crc.init()
  crc.update("1234".bytes())
  crc.update("56789".bytes())
  assert crc.final() == 0x995dc9bbdf1939fa
}
