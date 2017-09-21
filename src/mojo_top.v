module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output[7:0]led,
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
    output [3:0] spi_channel,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy // AVR Rx buffer full
	);

	wire rst = ~rst_n; // make reset active high
	
	// hook up debug stuff
	assign led[1] = drive0_dir;
	assign led[0] = drive0_stp;

	// these signals should be high-z when not used
	assign spi_miso = 1'bz;
	assign avr_rx = 1'bz;
	assign spi_channel = 4'bzzzz;

	//assign led = 8'b0;
	assign led[7] = rst;
	assign led[6:2] = 5'b0;
	
	floppy my_floppy0 (
		.clk(clk),
		.enable(rst),
		.rst(1'b0),
		.setpoint(22'd227272),
		.step(drive0_stp),
		.dir(drive0_dir),
		.sel(drive0_sel)
	);
	floppy my_floppy1 (
		.clk(clk),
		.enable(rst),
		.rst(1'b0),
		.setpoint(22'd191112),
		.step(drive1_stp),
		.dir(drive1_dir),
		.sel(drive1_sel)
	);
	
	// const = 50 MHz / [desired freq] / 2
	// middle c 261.6 Hz 22'd95556
	// a440 22'd56818

endmodule