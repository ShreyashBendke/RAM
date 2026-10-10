module ram_16x8_tb();

    // Testbench Signals
    reg clk;
    reg wr_en;
    reg rd_en;
    reg [3:0] wr_addr;
    reg [3:0] rd_addr;
    reg [7:0] data_in;

    wire [7:0] data_out;

    integer i;

    // DUT Instantiation
    ram_16x8 DUT(
        .rst(rst),
        .clk(clk),
        .we(wr_en),
        .re(rd_en),
        .waddr(wr_addr),
        .raddr(rd_addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock Generation
    always #5 clk = ~clk;

    // Initialization
    task initialize;
    begin
        clk     = 1'b0;
        wr_en   = 1'b0;
        rd_en   = 1'b0;
        wr_addr = 4'b0000;
        rd_addr = 4'b0000;
        data_in = 8'b00000000;
    end
    endtask

    // Write Operation
    task write_op(
        input [7:0] data,
        input       wr_enb,
        input [3:0] wr_add
    );
    begin
        @(negedge clk);
        data_in = data;
        wr_en   = wr_enb;
        wr_addr = wr_add;
    end
    endtask

    // Read Operation
    task read_op(
        input [3:0] radd,
        input       ren
    );
    begin
        @(negedge clk);
        rd_en   = ren;
        rd_addr = radd;
    end
    endtask

    // Test Sequence
    initial
    begin
        initialize;

        // Write random data into all 16 locations
        for(i = 0; i < 16; i = i + 1)
        begin
            write_op($random, 1'b1, i);
        end

        // Disable write
        @(negedge clk);
        wr_en = 1'b0;

        // Read all locations
        for(i = 0; i < 16; i = i + 1)
        begin
            read_op(i, 1'b1);
            @(posedge clk);
            #1;
            $display("Address = %0d, Data = %h", i, data_out);
        end

        #10;
        $finish;
    end

endmodule
