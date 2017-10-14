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
    output drive2_dir,
    output drive2_stp,
    output drive2_sel,
    output drive3_dir,
    output drive3_stp,
    output drive3_sel,
    output drive4_dir,
    output drive4_stp,
    output drive4_sel,
    output drive5_dir,
    output drive5_stp,
    output drive5_sel,
    output drive6_dir,
    output drive6_stp,
    output drive6_sel,
    output drive7_dir,
    output drive7_stp,
    output drive7_sel,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] avr_flags,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // old AVR Rx => FPGA Tx now disconnected
    input avr_rx_busy, // AVR Rx buffer full
	 input midi_in // new AVR Rx => MIDI in
  );

  assign avr_rx = midi_in;

  wire rst = ~rst_n; // make reset active high

  wire avr_ready; // high when the AVR is ready

  assign avr_flags = avr_ready ? 4'b0000 : 4'bzzzz; // no flags are in use, keep high-z when avr_ready is low

  wire [5:0] reg_addr;
  wire reg_write, reg_new_req;
  wire [7:0] reg_write_value, reg_read_value;
  
  wire floppy0_en;
  wire [21:0] floppy0_setp;
  
  wire floppy1_en;
  wire [21:0] floppy1_setp;
    
  wire floppy2_en;
  wire [21:0] floppy2_setp;
    
  wire floppy3_en;
  wire [21:0] floppy3_setp;
  
  wire floppy4_en;
  wire [21:0] floppy4_setp;
  
  wire floppy5_en;
  wire [21:0] floppy5_setp;
  
  wire floppy6_en;
  wire [21:0] floppy6_setp;
  
  wire floppy7_en;
  wire [21:0] floppy7_setp;
  
  avr_interface #(.CLK_RATE(50000000)) avr_interface (
      .clk(clk),
      .rst(rst),
      .cclk(cclk),
      .ready(avr_ready),
      .spi_miso(spi_miso),
      .spi_mosi(spi_mosi),
      .spi_sck(spi_sck),
      .spi_ss(spi_ss),
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
		.f0_en(floppy0_en),
	   .f1_sp(floppy1_setp),
		.f1_en(floppy1_en),
	   .f2_sp(floppy2_setp),
		.f2_en(floppy2_en),
	   .f3_sp(floppy3_setp),
		.f3_en(floppy3_en),
	   .f4_sp(floppy4_setp),
		.f4_en(floppy4_en),
	   .f5_sp(floppy5_setp),
		.f5_en(floppy5_en),
	   .f6_sp(floppy6_setp),
		.f6_en(floppy6_en),
	   .f7_sp(floppy7_setp),
		.f7_en(floppy7_en)
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
	
	floppy floppy1 (
		.clk(clk),
		.enable(floppy1_en),
		.rst(rst),
		.setpoint(floppy1_setp),
		.step(drive1_stp),
		.dir(drive1_dir),
		.sel(drive1_sel)
	);
		
	floppy floppy2 (
		.clk(clk),
		.enable(floppy2_en),
		.rst(rst),
		.setpoint(floppy2_setp),
		.step(drive2_stp),
		.dir(drive2_dir),
		.sel(drive2_sel)
	);
	
	floppy floppy3 (
		.clk(clk),
		.enable(floppy3_en),
		.rst(rst),
		.setpoint(floppy3_setp),
		.step(drive3_stp),
		.dir(drive3_dir),
		.sel(drive3_sel)
	);
		
	floppy floppy4 (
		.clk(clk),
		.enable(floppy4_en),
		.rst(rst),
		.setpoint(floppy4_setp),
		.step(drive4_stp),
		.dir(drive4_dir),
		.sel(drive4_sel)
	);
		
	floppy floppy5 (
		.clk(clk),
		.enable(floppy5_en),
		.rst(rst),
		.setpoint(floppy5_setp),
		.step(drive5_stp),
		.dir(drive5_dir),
		.sel(drive5_sel)
	);
	
	floppy floppy6 (
		.clk(clk),
		.enable(floppy6_en),
		.rst(rst),
		.setpoint(floppy6_setp),
		.step(drive6_stp),
		.dir(drive6_dir),
		.sel(drive6_sel)
	);
	
	floppy floppy7 (
		.clk(clk),
		.enable(floppy7_en),
		.rst(rst),
		.setpoint(floppy7_setp),
		.step(drive7_stp),
		.dir(drive7_dir),
		.sel(drive7_sel)
	);
	
endmodule