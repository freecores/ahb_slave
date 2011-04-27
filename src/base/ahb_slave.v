
OUTFILE PREFIX.v

INCLUDE def_ahb_slave.txt
  
module PREFIX(PORTS);
   
   parameter                  SLAVE_NUM = 0;
   
   input 		      clk;
   input 		      reset;
   
   revport                    GROUP_STUB_AHB;


   
   wire                       GROUP_STUB_MEM;
   

   
   CREATE ahb_slave_ram.v
     PREFIX_ram PREFIX_ram(
			   .clk(clk),
			   .reset(reset),
                           .GROUP_STUB_AHB(GROUP_STUB_AHB),
                           .GROUP_STUB_MEM(GROUP_STUB_MEM),
                           STOMP ,
                           );
   
   
   CREATE ahb_slave_mem.v
   PREFIX_mem PREFIX_mem(
			 .clk(clk),
			 .reset(reset),
                         .GROUP_STUB_MEM(GROUP_STUB_MEM),
                         STOMP ,
			 );


   
   IFDEF TRACE
     CREATE ahb_slave_trace.v
       PREFIX_trace #(SLAVE_NUM)
         PREFIX_trace(
			         .clk(clk),
			         .reset(reset),
                                 .GROUP_STUB_MEM(GROUP_STUB_MEM),
                                 STOMP ,
			         );
     
   ENDIF TRACE
   
endmodule


