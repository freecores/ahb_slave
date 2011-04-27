
OUTFILE PREFIX_mem.v

INCLUDE def_ahb_slave.txt
  
ITER BX EXPR(DATA_BITS/8)
module PREFIX_mem (PORTS);

   parameter                    MEM_WORDS = EXPR((2^ADDR_BITS)/(DATA_BITS/8));
   parameter                    ADDR_LSB  = LOG2(EXPR(DATA_BITS/8));
      
   input                        clk;
   input                        reset;
   revport                      GROUP_STUB_MEM;
   
   reg [DATA_BITS-1:0]          Mem [MEM_WORDS-1:0];
   reg [DATA_BITS-1:0]          DOUT;
   wire [DATA_BITS-1:0]         BitSEL;
   wire [ADDR_BITS-1:ADDR_LSB]  ADDR_WR_word = ADDR_WR[ADDR_BITS-1:ADDR_LSB];
   wire [ADDR_BITS-1:ADDR_LSB]  ADDR_RD_word = ADDR_RD[ADDR_BITS-1:ADDR_LSB];

   
   assign                       BitSEL = {CONCAT({8{BSEL[BX]}} ,)};
   
   always @(posedge clk)
     if (WR)
       Mem[ADDR_WR_word] <= #FFD (Mem[ADDR_WR_word] & ~BitSEL) | (DIN & BitSEL);
   
   always @(posedge clk or posedge reset)
     if (reset)
       DOUT <= #FFD {DATA_BITS{1'b0}};
     else if (RD) 
       DOUT <= #FFD Mem[ADDR_RD_word];

   
endmodule