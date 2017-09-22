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
// Crappy Python 2.x code to generate table:
// clock = 50.0 * 10**6
// for i in range(21,109):
//     note = i
//     while (note > 69): # Things glitch out after B4; cut them off at A4
//         note -= 12
//     freq = 27.5 * 2**((note - 21.0)/12)
//
//     if (i < 0x10):
//         print "        7'h0" + hex(i)[2:] + ":",
//     else:
//         print "        7'h" + hex(i)[2:] + ":",
//     print "setpoint = 22'd" + str(int(round(clock / freq / 2))) + ";"
//////////////////////////////////////////////////////////////////////////////////
module floppy_lookup(
    input [6:0] note,
    output reg [21:0] setpoint
    );

always @*
    case (note)
        7'h15: setpoint = 22'd909091; // A0
        7'h16: setpoint = 22'd858068;
        7'h17: setpoint = 22'd809908;
        7'h18: setpoint = 22'd764451;
        7'h19: setpoint = 22'd721546;
        7'h1a: setpoint = 22'd681049;
        7'h1b: setpoint = 22'd642824;
        7'h1c: setpoint = 22'd606745;
        7'h1d: setpoint = 22'd572691;
        7'h1e: setpoint = 22'd540549;
        7'h1f: setpoint = 22'd510210;
        7'h20: setpoint = 22'd481574;
        7'h21: setpoint = 22'd454545; // A1
        7'h22: setpoint = 22'd429034;
        7'h23: setpoint = 22'd404954;
        7'h24: setpoint = 22'd382226;
        7'h25: setpoint = 22'd360773;
        7'h26: setpoint = 22'd340524;
        7'h27: setpoint = 22'd321412;
        7'h28: setpoint = 22'd303373;
        7'h29: setpoint = 22'd286346;
        7'h2a: setpoint = 22'd270274;
        7'h2b: setpoint = 22'd255105;
        7'h2c: setpoint = 22'd240787;
        7'h2d: setpoint = 22'd227273; // A2
        7'h2e: setpoint = 22'd214517;
        7'h2f: setpoint = 22'd202477;
        7'h30: setpoint = 22'd191113;
        7'h31: setpoint = 22'd180386;
        7'h32: setpoint = 22'd170262;
        7'h33: setpoint = 22'd160706;
        7'h34: setpoint = 22'd151686;
        7'h35: setpoint = 22'd143173;
        7'h36: setpoint = 22'd135137;
        7'h37: setpoint = 22'd127553;
        7'h38: setpoint = 22'd120394;
        7'h39: setpoint = 22'd113636; // A3
        7'h3a: setpoint = 22'd107258;
        7'h3b: setpoint = 22'd101238;
        7'h3c: setpoint = 22'd95556;
        7'h3d: setpoint = 22'd90193;
        7'h3e: setpoint = 22'd85131;
        7'h3f: setpoint = 22'd80353;
        7'h40: setpoint = 22'd75843;
        7'h41: setpoint = 22'd71586;
        7'h42: setpoint = 22'd67569;
        7'h43: setpoint = 22'd63776;
        7'h44: setpoint = 22'd60197;
        7'h45: setpoint = 22'd56818; // A4
        7'h46: setpoint = 22'd107258; // Should be B4 but is B3
        7'h47: setpoint = 22'd101238;
        7'h48: setpoint = 22'd95556;
        7'h49: setpoint = 22'd90193;
        7'h4a: setpoint = 22'd85131;
        7'h4b: setpoint = 22'd80353;
        7'h4c: setpoint = 22'd75843;
        7'h4d: setpoint = 22'd71586;
        7'h4e: setpoint = 22'd67569;
        7'h4f: setpoint = 22'd63776;
        7'h50: setpoint = 22'd60197;
        7'h51: setpoint = 22'd56818;
        7'h52: setpoint = 22'd107258;
        7'h53: setpoint = 22'd101238;
        7'h54: setpoint = 22'd95556;
        7'h55: setpoint = 22'd90193;
        7'h56: setpoint = 22'd85131;
        7'h57: setpoint = 22'd80353;
        7'h58: setpoint = 22'd75843;
        7'h59: setpoint = 22'd71586;
        7'h5a: setpoint = 22'd67569;
        7'h5b: setpoint = 22'd63776;
        7'h5c: setpoint = 22'd60197;
        7'h5d: setpoint = 22'd56818;
        7'h5e: setpoint = 22'd107258;
        7'h5f: setpoint = 22'd101238;
        7'h60: setpoint = 22'd95556;
        7'h61: setpoint = 22'd90193;
        7'h62: setpoint = 22'd85131;
        7'h63: setpoint = 22'd80353;
        7'h64: setpoint = 22'd75843;
        7'h65: setpoint = 22'd71586;
        7'h66: setpoint = 22'd67569;
        7'h67: setpoint = 22'd63776;
        7'h68: setpoint = 22'd60197;
        7'h69: setpoint = 22'd56818;
        7'h6a: setpoint = 22'd107258;
        7'h6b: setpoint = 22'd101238;
        7'h6c: setpoint = 22'd95556;

        default: setpoint = 22'h3fffff;
    endcase

endmodule
