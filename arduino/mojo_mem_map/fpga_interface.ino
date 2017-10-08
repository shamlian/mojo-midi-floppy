void writeReg(uint8_t addr, uint8_t value){
  SET(SS, LOW);
  SPI.transfer(0x80|(addr&0x3F));
  SPI.transfer(value);
  SET(SS, HIGH);
}

uint8_t readReg(uint8_t addr){
  SET(SS, LOW);
  SPI.transfer(0x00|(addr&0x3F));
  uint8_t v = SPI.transfer(0xff);
  SET(SS, HIGH);
  return v;
}
