module ram_16x8( 
      input clk,
      input rst,
      input [7:0]data_in,
      input we,
      input re,
      input [3:0]raddr,
      input [3:0]waddr,
      output reg[7:0]data_out);

integer i;

parameter DEPTH = 16;
parameter WIDTH = 8;

reg [WIDTH-1:0]mem[DEPTH-1:0];

always@(posedge clk)
   begin
      if(rst)
          for(i=0;i<DEPTH;i=i+1)
          begin
              mem[i]=1'b0;
          end
      else if(we)
          begin
              mem[waddr]<=data_in;
          end
   end   

always@(posedge clk)
   begin 
      if(rst)
          data_out<=2'b0;
      else if(re)
          data_out<=mem[raddr];
   end

endmodule
