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
//       Created on: Tue Aug 18 14:57:03 IST 2026
//--------------------------------------------------------------------------

module msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_tdr (
  input wire ijtag_reset,
  input wire ijtag_sel,
  input wire ijtag_si,
  input wire ijtag_ce,
  input wire ijtag_se,
  input wire ijtag_ue,
  input wire ijtag_tck,
  output wire edt_bypass,
  output wire ijtag_so
);
wire                edt_bypass_to_buf;
reg    [0:0]        tdr;
reg                 retiming_so ;
reg                 edt_bypass_latch;
 
 
BUF_X1 tessent_persistent_cell_edt_bypass ( .A (edt_bypass_latch), .Z (edt_bypass) );
 
// --------- ShiftRegister ---------
 
always @ (posedge ijtag_tck) begin
  if (ijtag_ce & ijtag_sel) begin
    tdr <= { edt_bypass_latch};
  end else if (ijtag_se & ijtag_sel) begin
    tdr <= ijtag_si;
  end
end
 
assign ijtag_so = retiming_so;
always @ (negedge ijtag_tck) begin
  retiming_so <= tdr[0];
end
 
// --------- DataOutPort 0 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    edt_bypass_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      edt_bypass_latch <= tdr[0];
    end
  end
end
 
endmodule
