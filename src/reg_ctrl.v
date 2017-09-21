module reg_ctrl (
        input clk,
        input rst,

        // Register interface
        input [5:0] reg_addr,
        input write,
        input new_req,
        input [7:0] write_value,
        output [7:0] read_value,

        // Device interface
        output [7:0] led,
		  output [7:0] floppy0
    );

reg [7:0] read_value_d, read_value_q;

reg [7:0] led_d, led_q;
//reg [7:0] floppy0_d, floppy0_q;

assign read_value = read_value_q;
assign led = led_q;
//assign floppy0 = floppy0_q;
assign floppy0 = led;

always @* begin
    read_value_d = read_value_q;

    led_d = led_q;

    if (new_req) begin
        if (write)
            case (reg_addr)
                6'h00: led_d = write_value;
					 //6'h00: floppy0_d = write_value;
            endcase
        else //read
            case (reg_addr)
                6'h00: read_value_d = led_q;
                //6'h00: read_value_d = floppy0_q;
            endcase
    end
end

always @(posedge clk) begin
    if (rst) begin
        led_q <= 8'b0;
        //floppy0_q <= 8'b0;
    end else begin
        led_q <= led_d;
        //floppy0_q <= floppy0_d;
    end
    
    read_value_q <= read_value_d;
end

endmodule