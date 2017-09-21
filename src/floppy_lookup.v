`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:21:44 09/20/2017 
// Design Name: 
// Module Name:    floppy_lookup 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module floppy_lookup(
	input [6:0] note,
	output reg [22:0] setpoint
	);

always @*
	casex (note)
		7'h0x: setpoint = 22'd227273; //110
		7'h1x: setpoint = 22'd202477;
		7'h2x: setpoint = 22'd180386;
		7'h3x: setpoint = 22'd170262;
		7'h4x: setpoint = 22'd151686;
		7'h5x: setpoint = 22'd135137;
		7'h6x: setpoint = 22'd120394;
		7'h7x: setpoint = 22'd113636; //220
		//7'h8: setpoint = 22'd;
		//7'h9: setpoint = 22'd;
		//7'ha: setpoint = 22'd;
		//7'hb: setpoint = 22'd;
		//7'hc: setpoint = 22'd;
		//7'hd: setpoint = 22'd;
		//7'he: setpoint = 22'd;
		//7'hf: setpoint = 22'd;
		//default: setpoint = 22'hxxxxxx;
	endcase

endmodule
