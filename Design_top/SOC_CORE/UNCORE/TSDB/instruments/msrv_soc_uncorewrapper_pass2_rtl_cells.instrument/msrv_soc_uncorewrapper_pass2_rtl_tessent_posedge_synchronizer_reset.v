//--------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2026 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2026.1
//       Created on: Tue Aug 18 14:51:18 IST 2026
//--------------------------------------------------------------------------

  
module msrv_soc_uncorewrapper_pass2_rtl_tessent_posedge_synchronizer_reset (
  input wire rn,
  input wire d,
  input wire clk,
  output reg q
);
reg ntc_retiming_q_reg;
always @ (posedge clk or negedge rn) begin
  if (~rn) begin
    ntc_retiming_q_reg <= 1'b0;
    q <= 1'b0;
  end else begin
    ntc_retiming_q_reg <= d;
    q <= ntc_retiming_q_reg;
  end
end
endmodule
