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
		  output [21:0] f0_sp,
		  output f0_en
    );

reg [7:0] read_value_d, read_value_q;

reg [7:0] floppy0_d, floppy0_q;

assign read_value = read_value_q;
assign led = floppy0_q;

always @* begin
    read_value_d = read_value_q;

    floppy0_d = floppy0_q;

    if (new_req) begin
        if (write)
            case (reg_addr)
					 6'h00: floppy0_d = write_value;
            endcase
        else //read
            case (reg_addr)
                6'h00: read_value_d = floppy0_q;
            endcase
    end
end

always @(posedge clk) begin
    if (rst) begin
        floppy0_q <= 8'b10000000;
    end else begin
        floppy0_q <= floppy0_d;
    end
    
    read_value_q <= read_value_d;
end

floppy_lookup floppy_lookup(
    .note(floppy0_q[6:0]),
    .setpoint(f0_sp)
);
assign f0_en = floppy0_q[7];

endmodule