/////////////////////////////////////////////////////////////////////
// Design unit: dmem
//            :
// File name  : dmem.sv
//            :
// Description: Data memory for basic processor
//            :
// Limitations: None
//            :
// System     : SystemVerilog IEEE 1800-2005
//            :
// Author     : Mark Zwolinski
//            : School of Electronics and Computer Science
//            : University of Southampton
//            : Southampton SO17 1BJ, UK
//            : mz@ecs.soton.ac.uk
//
// Revision   : Version 1.0 05/08/08
//            : Version 1.1 17/12/13
//            : Version 1.2 12/12/14 Only map top half of address range
//            : Version 1.3 14/01/21 Simplified some of the syntax
//            : Version 2.0 14/03/24 Rewritten to remove tristate bus
/////////////////////////////////////////////////////////////////////

module dmem #(parameter WORD_W = 8, OP_W = 3)
               (output logic [WORD_W-1:0] Mdata,
                input logic [WORD_W-1:0] Wdata,
                input logic [WORD_W-OP_W-1:0] Daddress,
                input logic WE, clock);


logic [WORD_W-1:0] mem [0:(2**(WORD_W-OP_W))-1]; 
//logic [WORD_W-1:0] mem [0:31]; //address range expressed as integer

always_ff @(posedge clock)
  if (WE)
    mem[Daddress] <= Wdata;
  
always_comb
  Mdata = mem[Daddress];  

endmodule
