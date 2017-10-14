`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:24 09/14/2017 
// Design Name: 
// Module Name:    floppy 
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
module floppy(
		input clk,
		input enable,
		input rst,
		input [21:0] setpoint,
		output reg step,
		output reg dir,
		output sel
	);

	reg [21:0] counter_d, counter_q;

	reg [6:0] dir_ctr_d, dir_ctr_q;

	always @(counter_q) begin
		counter_d = counter_q + 1'b1;
	end
	
	assign sel = ~enable;
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			counter_q <= 22'd0;
			step <= 1;
		end else begin
			if (enable) begin
				if (counter_d >= setpoint) begin
					counter_q <= 22'd0;
					step <= ~step;
				end else begin
					counter_q <= counter_d;
				end
			end
		end
	end

	always @(dir_ctr_q) begin
		dir_ctr_d = dir_ctr_q + 1'b1;
	end

	always @(negedge step, posedge rst) begin
		if (rst) begin
			dir_ctr_q <= 7'd0;
			dir <= 1;
		end else begin
		   if (enable) begin
				if (dir_ctr_d == 7'd80) begin
					dir_ctr_q <= 7'd0;
					dir <= ~dir;
				end else begin
					dir_ctr_q <= dir_ctr_d;
				end
			end
		end
	end

endmodule
