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

module msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl (
  input wire ijtag_reset,
  input wire ijtag_sel,
  input wire ijtag_si,
  input wire ijtag_ce,
  input wire ijtag_se,
  input wire ijtag_ue,
  input wire ijtag_tck,
  output wire async_set_reset_static_disable,
  output wire mcp_bounding_en,
  output wire control_test_point_en,
  output wire observe_test_point_en,
  output wire x_bounding_en,
  output wire ext_mode,
  output wire int_mode,
  output wire ext_ltest_en,
  output wire int_ltest_en,
  output wire controller_chain_mode,
  output wire ltest_en,
  output wire ijtag_so
);
wire                async_set_reset_static_disable_to_buf;
wire                mcp_bounding_en_to_buf;
wire                control_test_point_en_to_buf;
wire                observe_test_point_en_to_buf;
wire                x_bounding_en_to_buf;
wire                ext_mode_to_buf;
wire                int_mode_to_buf;
wire                ext_ltest_en_to_buf;
wire                int_ltest_en_to_buf;
wire                controller_chain_mode_to_buf;
wire                ltest_en_to_buf;
reg    [10:0]       tdr;
reg                 retiming_so ;
reg                 async_set_reset_static_disable_latch;
reg                 mcp_bounding_en_latch;
reg                 control_test_point_en_latch;
reg                 observe_test_point_en_latch;
reg                 x_bounding_en_latch;
reg                 ext_mode_latch;
reg                 int_mode_latch;
reg                 ext_ltest_en_latch;
reg                 int_ltest_en_latch;
reg                 controller_chain_mode_latch;
reg                 ltest_en_latch;
 
 
BUF_X1 tessent_persistent_cell_async_set_reset_static_disable ( .A (async_set_reset_static_disable_latch), .Z (async_set_reset_static_disable) );
BUF_X1 tessent_persistent_cell_mcp_bounding_en ( .A (mcp_bounding_en_latch), .Z (mcp_bounding_en) );
BUF_X1 tessent_persistent_cell_control_test_point_en ( .A (control_test_point_en_latch), .Z (control_test_point_en) );
BUF_X1 tessent_persistent_cell_observe_test_point_en ( .A (observe_test_point_en_latch), .Z (observe_test_point_en) );
BUF_X1 tessent_persistent_cell_x_bounding_en ( .A (x_bounding_en_latch), .Z (x_bounding_en) );
BUF_X1 tessent_persistent_cell_ext_mode ( .A (ext_mode_latch), .Z (ext_mode) );
BUF_X1 tessent_persistent_cell_int_mode ( .A (int_mode_latch), .Z (int_mode) );
BUF_X1 tessent_persistent_cell_ext_ltest_en ( .A (ext_ltest_en_latch), .Z (ext_ltest_en) );
BUF_X1 tessent_persistent_cell_int_ltest_en ( .A (int_ltest_en_latch), .Z (int_ltest_en) );
BUF_X1 tessent_persistent_cell_controller_chain_mode ( .A (controller_chain_mode_latch), .Z (controller_chain_mode) );
BUF_X1 tessent_persistent_cell_ltest_en ( .A (ltest_en_latch), .Z (ltest_en) );
 
// --------- ShiftRegister ---------
 
always @ (posedge ijtag_tck) begin
  if (ijtag_ce & ijtag_sel) begin
    tdr <= { 11'b00000000000};
  end else if (ijtag_se & ijtag_sel) begin
    tdr <= {ijtag_si,tdr[10:1]};
  end
end
 
assign ijtag_so = retiming_so;
always @ (ijtag_tck or tdr[0]) begin
  if (~ijtag_tck) begin
    retiming_so <= tdr[0];
  end
end
 
// --------- DataOutPort 10 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    async_set_reset_static_disable_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      async_set_reset_static_disable_latch <= tdr[10];
    end
  end
end
 
// --------- DataOutPort 9 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    mcp_bounding_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      mcp_bounding_en_latch <= tdr[9];
    end
  end
end
 
// --------- DataOutPort 8 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    control_test_point_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      control_test_point_en_latch <= tdr[8];
    end
  end
end
 
// --------- DataOutPort 7 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    observe_test_point_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      observe_test_point_en_latch <= tdr[7];
    end
  end
end
 
// --------- DataOutPort 6 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    x_bounding_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      x_bounding_en_latch <= tdr[6];
    end
  end
end
 
// --------- DataOutPort 5 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    ext_mode_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      ext_mode_latch <= tdr[5];
    end
  end
end
 
// --------- DataOutPort 4 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    int_mode_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      int_mode_latch <= tdr[4];
    end
  end
end
 
// --------- DataOutPort 3 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    ext_ltest_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      ext_ltest_en_latch <= tdr[3];
    end
  end
end
 
// --------- DataOutPort 2 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    int_ltest_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      int_ltest_en_latch <= tdr[2];
    end
  end
end
 
// --------- DataOutPort 1 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    controller_chain_mode_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      controller_chain_mode_latch <= tdr[1];
    end
  end
end
 
// --------- DataOutPort 0 ---------
always @ (negedge ijtag_tck or negedge ijtag_reset) begin
  if (~ijtag_reset) begin
    ltest_en_latch <= 1'b0;
  end else begin
    if (ijtag_ue & ijtag_sel) begin
      ltest_en_latch <= tdr[0];
    end
  end
end
 
endmodule
