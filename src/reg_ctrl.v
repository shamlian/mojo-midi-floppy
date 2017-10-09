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
        output f0_en,
        output [21:0] f1_sp,
        output f1_en,
        output [21:0] f2_sp,
        output f2_en,
        output [21:0] f3_sp,
        output f3_en,
        output [21:0] f4_sp,
        output f4_en,
        output [21:0] f5_sp,
        output f5_en
    );

reg [7:0] read_value_d, read_value_q;

reg [7:0] floppy0_d, floppy0_q;
reg [7:0] floppy1_d, floppy1_q;
reg [7:0] floppy2_d, floppy2_q;
reg [7:0] floppy3_d, floppy3_q;
reg [7:0] floppy4_d, floppy4_q;
reg [7:0] floppy5_d, floppy5_q;

assign read_value = read_value_q;
assign led = {2'h0,floppy5_q[7],floppy4_q[7],floppy3_q[7],floppy2_q[7],floppy1_q[7],floppy0_q[7]};

always @* begin
    read_value_d = read_value_q;

    floppy0_d = floppy0_q;
    floppy1_d = floppy1_q;
    floppy2_d = floppy2_q;
    floppy3_d = floppy3_q;
    floppy4_d = floppy4_q;
    floppy5_d = floppy5_q;

    if (new_req) begin
        if (write)
            case (reg_addr)
                6'h00: floppy0_d = write_value;
                6'h01: floppy1_d = write_value;
                6'h02: floppy2_d = write_value;
                6'h03: floppy3_d = write_value;
                6'h04: floppy4_d = write_value;
                6'h05: floppy5_d = write_value;
            endcase
        else //read
            case (reg_addr)
                6'h00: read_value_d = floppy0_q;
                6'h01: read_value_d = floppy1_q;
                6'h02: read_value_d = floppy2_q;
                6'h03: read_value_d = floppy3_q;
                6'h04: read_value_d = floppy4_q;
                6'h05: read_value_d = floppy5_q;
            endcase
    end
end

always @(posedge clk) begin
    if (rst) begin
        floppy0_q <= 8'b00000000;
        floppy1_q <= 8'b00000000;
        floppy2_q <= 8'b00000000;
        floppy3_q <= 8'b00000000;
        floppy4_q <= 8'b00000000;
        floppy5_q <= 8'b00000000;
    end else begin
        floppy0_q <= floppy0_d;
        floppy1_q <= floppy1_d;
        floppy2_q <= floppy2_d;
        floppy3_q <= floppy3_d;
        floppy4_q <= floppy4_d;
        floppy5_q <= floppy5_d;
    end
    
    read_value_q <= read_value_d;
end

floppy_lookup floppy_lookup0(
    .note(floppy0_q[6:0]),
    .setpoint(f0_sp)
);
assign f0_en = floppy0_q[7];

floppy_lookup floppy_lookup1(
    .note(floppy1_q[6:0]),
    .setpoint(f1_sp)
);
assign f1_en = floppy1_q[7];

floppy_lookup floppy_lookup2(
    .note(floppy2_q[6:0]),
    .setpoint(f2_sp)
);
assign f2_en = floppy2_q[7];

floppy_lookup floppy_lookup3(
    .note(floppy3_q[6:0]),
    .setpoint(f3_sp)
);
assign f3_en = floppy3_q[7];

floppy_lookup floppy_lookup4(
    .note(floppy4_q[6:0]),
    .setpoint(f4_sp)
);
assign f4_en = floppy4_q[7];

floppy_lookup floppy_lookup5(
    .note(floppy5_q[6:0]),
    .setpoint(f5_sp)
);
assign f5_en = floppy5_q[7];

endmodule