module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output[7:0] led,
    // Drive Outputs
    output drive0_dir,
    output drive0_stp,
    output drive0_sel,
    output drive1_dir,
    output drive1_stp,
    output drive1_sel,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] avr_flags,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy // AVR Rx buffer full
  );

  wire rst = ~rst_n; // make reset active high

  wire avr_ready; // high when the AVR is ready

  assign avr_flags = avr_ready ? 4'b0000 : 4'bzzzz; // no flags are in use, keep high-z when avr_ready is low

  wire [5:0] reg_addr;
  wire reg_write, reg_new_req;
  wire [7:0] reg_write_value, reg_read_value;
  
  wire floppy0_en;
  wire [21:0] floppy0_setp;
  
  // for now, just one drive
  assign drive1_dir = 1'bz;
  assign drive1_stp = 1'bz;
  assign drive1_sel = 1'bz;

  avr_interface #(.CLK_RATE(50000000), .SERIAL_BAUD_RATE(500000)) avr_interface (
      .clk(clk),
      .rst(rst),
      .cclk(cclk),
      .ready(avr_ready),
      .spi_miso(spi_miso),
      .spi_mosi(spi_mosi),
      .spi_sck(spi_sck),
      .spi_ss(spi_ss),
      .tx(avr_rx),
      .rx(avr_tx),
      .rx_data(),
      .new_rx_data(),
      .tx_data(8'h00),
      .new_tx_data(1'b0),
      .tx_busy(),
      .tx_block(avr_rx_busy),
      .reg_addr(reg_addr),
      .write(reg_write),
      .new_req(reg_new_req),
      .write_value(reg_write_value),
      .read_value(reg_read_value)
    );

  reg_ctrl reg_ctrl (
      .clk(clk),
      .rst(rst),
      .reg_addr(reg_addr),
      .write(reg_write),
      .new_req(reg_new_req),
      .write_value(reg_write_value),
      .read_value(reg_read_value),
		.led(led),
	   .f0_sp(floppy0_setp),
		.f0_en(floppy0_en)
    );

	floppy floppy0 (
		.clk(clk),
		.enable(floppy0_en),
		.rst(rst),
		.setpoint(floppy0_setp),
		.step(drive0_stp),
		.dir(drive0_dir),
		.sel(drive0_sel)
	);
endmodule