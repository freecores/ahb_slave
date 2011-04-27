
OUTFILE PREFIX_trace.v

INCLUDE def_ahb_slave.txt
  
module PREFIX_trace(PORTS);
      
   parameter                  SLAVE_NUM = 0;
   
   parameter 		      FILE_NAME     = "PREFIX.trc";
   
   input 		      clk;
   input 		      reset;

   input                      GROUP_STUB_MEM;
   

   reg                        RD_d;
   reg [ADDR_BITS-1:0] 	      ADDR_RD_d;

   wire [31:0] 		      ADDR_WR_disp =  ADDR_WR;	
   wire [31:0] 		      ADDR_RD_disp =  ADDR_RD_d;
   
   integer                    file_ptr;
   
   initial
     file_ptr = $fopen(FILE_NAME, "w");

   
   always @(posedge clk or posedge reset)
     if (reset)
       begin
          ADDR_RD_d <= #FFD 'd0;
          RD_d <= #FFD 'd0;
       end
     else
       begin
          ADDR_RD_d <= #FFD ADDR_RD;
          RD_d <= #FFD RD;
       end
   
   always @(posedge clk)
     if (WR)
       $fwrite(file_ptr, "%16d: %0s WR: Addr: 0x%8h, Data: 0x%8h, Bsel: 0x%2h\n", $time, FILE_NAME, ADDR_WR_disp, DIN, BSEL);
	
   always @(posedge clk)
     if (RD_d)
       $fwrite(file_ptr, "%16d: %0s RD: Addr: 0x%8h, Data: 0x%8h\n", $time, FILE_NAME, ADDR_RD_disp, DOUT);

      
endmodule

   
