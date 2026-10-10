`timescale 1ns/1ps

module ram_8x16_singleport_tb();

reg rst, clk;
reg we, enable;
reg [2:0] addr;

reg [15:0] data_tb;
wire [15:0] data;

integer i;

// Drive data bus only during write
assign data = (we) ? data_tb : 16'bz;

ram_8x16_singleport DUT(
    .rst(rst),
    .clk(clk),
    .we_in(we),
    .re_in(enable),
    .addr_in(addr),
    .data(data)
);

// Clock generation
always #5 clk = ~clk;

// Initialization
task initialize;
begin
    clk     = 0;
    rst     = 1;
    we      = 0;
    enable  = 0;
    addr    = 0;
    data_tb = 16'bz;
end
endtask

// Write task
task write_op(
    input [15:0] data_in,
    input [2:0] wr_addr
);
begin
    @(negedge clk);
    we      = 1;
    enable  = 0;
    addr    = wr_addr;
    data_tb = data_in;
end
endtask

// Read task
task read_op(
    input [2:0] rd_addr
);
begin
    @(negedge clk);
    we      = 0;
    enable  = 1;
    addr    = rd_addr;
    data_tb = 16'bz;
end
endtask

initial
begin
    initialize;

    // Reset
    #10;
    rst = 0;

    // Write random data
    for(i = 0; i < 8; i = i + 1)
        write_op($random, i);

    @(negedge clk);
    we = 0;
    data_tb = 16'bz;

    // Read data
    for(i = 0; i < 8; i = i + 1)
    begin
        read_op(i);
        @(posedge clk);
        #1;
        $display("Address = %0d Data = %h", i, data);
    end

    #20;
    $finish;
end

endmodule