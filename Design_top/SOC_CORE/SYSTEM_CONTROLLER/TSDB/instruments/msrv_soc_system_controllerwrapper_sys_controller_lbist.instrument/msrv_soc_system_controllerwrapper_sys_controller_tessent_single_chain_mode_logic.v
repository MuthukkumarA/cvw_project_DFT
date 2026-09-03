//--------------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2026 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2026.1
//       Created on: Tue Aug 18 14:57:08 IST 2026
//
//       IP version: 8
//--------------------------------------------------------------------------------


module msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_sib (
   input  wire      ijtag_tck,
   input  wire      ijtag_reset,
   input  wire      ijtag_sel,
   input  wire      ijtag_ce,
   input  wire      ijtag_se,
   input  wire      ijtag_ue,
   input  wire      ijtag_si,
   input  wire      ijtag_from_so,
   input  wire      ccm_scan_en,
   input  wire      ccm_te_si,
   output wire      ccm_te_so,
   output wire      ijtag_so,
   output wire      ijtag_to_sel
);
   reg         sib;
   reg         sib_latch;
   reg         so_retime;
   reg         to_enable_int;

   assign ijtag_to_sel = to_enable_int & ijtag_sel;

   always @(negedge ijtag_tck or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         sib_latch <= 1'b0;
      end
      else begin
         if (ccm_scan_en == 1'b1) begin
            sib_latch <= ccm_te_si;
         end else if (ijtag_ue == 1'b1 && ijtag_sel == 1'b1) begin
            sib_latch <= sib;
         end
      end
   end

   always @(negedge ijtag_tck)
   begin 
      so_retime <= ccm_scan_en ? to_enable_int : sib;
      to_enable_int <= sib_latch;
   end

   assign ijtag_so = ccm_scan_en ? sib : so_retime;

   assign ccm_te_so = so_retime;

   always @(posedge ijtag_tck or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         sib <= 1'b0;
      end
      else begin
         if (ccm_scan_en == 1'b1) begin
            sib <= ijtag_from_so;
         end
         else if (ijtag_ce == 1'b1 && ijtag_sel == 1'b1) begin
            sib <= 1'b0;
         end
         else if (ijtag_se == 1'b1 && ijtag_sel == 1'b1) begin
            if (sib_latch == 1'b1) begin
               sib <= ijtag_from_so;
            end
            else begin
               sib <= ijtag_si;
            end
         end
      end
   end

endmodule


module msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic (
   input  wire      ijtag_tck,
   input  wire      lbist_en,
   input  wire      ijtag_reset,
   input  wire      ijtag_sel,
   input  wire      ijtag_ce,
   input  wire      ijtag_se,
   input  wire      ijtag_ue,
   input  wire      ccm_en,
   output wire      ccm_scan_out,
   input  wire      scan_en,
   input  wire      ccm_scan_in,
   input  wire      ijtag_si,
   input  wire      edt_single_bypass_chain_in,
   input  wire      edt_channels_in,
   input  wire      edt_channels_out,
   output wire      ijtag_so,
   output wire      edt_single_bypass_chain_out,
   output wire      to_edt_channels_in
);
   wire         tdr_sib_scan_out;
   wire         single_chain_sib_scan_out;
   wire         tdr_single_bypass_en;
   reg          tdr_single_bypass;
   wire         ccm_en_buf_out;
   wire         tdr_single_bypass_buf_out;
   wire         ijtag_si_int;
   wire         blk_sib_en;
   wire         blk1_sib_scan_out;
   wire         blk1_sib_from_scan_out;
   wire         ccm_scan_en;
   reg    [2:0] ijtag_ccm_tdr;
   wire         ijtag_sel_ccm;
   wire         ijtag_ce_ccm;
   wire         ijtag_se_ccm;
   wire         ijtag_ue_ccm;
   reg          ccm_te_si_lockup;
   wire         ccm_te_so_tdr_sib;
   wire         ccm_te_so_single_chain_sib;
   wire         ccm_te_so_blk1_sib;

   BUF_X1 tessent_persistent_cell_ccm_en_buf (.A(ccm_en),
                                              .Z(ccm_en_buf_out));

   assign ijtag_si_int = ccm_en_buf_out ? ccm_scan_in : ijtag_si;
   assign ccm_scan_en = scan_en & ccm_en_buf_out;
   assign ccm_scan_out = ccm_te_so_blk1_sib & ccm_en_buf_out;
   assign ijtag_so = single_chain_sib_scan_out;

   always @(posedge ijtag_tck)
   begin 
      ccm_te_si_lockup <= ijtag_ccm_tdr[0]; 
   end

   always @(posedge ijtag_tck or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         ijtag_ccm_tdr <= 3'b000;
      end
      else begin
         if (ccm_scan_en == 1'b1) begin
            ijtag_ccm_tdr <= {single_chain_sib_scan_out, ijtag_ccm_tdr[2:1]};
         end
      end
   end

   assign ijtag_sel_ccm = ccm_en_buf_out ? ijtag_ccm_tdr[0] : ijtag_sel;
   assign ijtag_ce_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b01) : ijtag_ce;
   assign ijtag_se_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b10) : ijtag_se;
   assign ijtag_ue_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b11) : ijtag_ue;

   msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_sib tdr_sib_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ijtag_si(ijtag_si_int),
      .ijtag_from_so(tdr_single_bypass),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_si_lockup),
      .ccm_te_so(ccm_te_so_tdr_sib),
      .ijtag_so(tdr_sib_scan_out),
      .ijtag_to_sel(tdr_single_bypass_en));

   always @(posedge ijtag_tck or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         tdr_single_bypass <= 1'b0;
      end
      else begin
         if ((ijtag_se_ccm == 1'b1 && tdr_single_bypass_en == 1'b1) || ccm_scan_en == 1'b1) begin
            tdr_single_bypass <= ijtag_si_int;
         end
      end
   end

   BUF_X1 tessent_persistent_cell_tdr_single_bypass_buf (.A(tdr_single_bypass),
                                                         .Z(tdr_single_bypass_buf_out));

   msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_sib single_chain_sib_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ijtag_si(tdr_sib_scan_out),
      .ijtag_from_so(blk1_sib_scan_out),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_tdr_sib),
      .ccm_te_so(ccm_te_so_single_chain_sib),
      .ijtag_so(single_chain_sib_scan_out),
      .ijtag_to_sel(blk_sib_en));

   assign blk1_sib_from_scan_out = ccm_scan_en ? tdr_sib_scan_out : edt_channels_out;

   msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_sib blk1_sib_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(blk_sib_en),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ijtag_si(tdr_sib_scan_out),
      .ijtag_from_so(blk1_sib_from_scan_out),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_single_chain_sib),
      .ccm_te_so(ccm_te_so_blk1_sib),
      .ijtag_so(blk1_sib_scan_out),
      .ijtag_to_sel());

   assign edt_single_bypass_chain_out = lbist_en ? tdr_single_bypass_buf_out : (edt_single_bypass_chain_in | tdr_single_bypass_buf_out);

   assign to_edt_channels_in = edt_single_bypass_chain_out ? tdr_sib_scan_out : edt_channels_in;
endmodule


