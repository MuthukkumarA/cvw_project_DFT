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
//       Created on: Tue Aug 18 14:51:23 IST 2026
//
//       IP version: 8
//--------------------------------------------------------------------------------


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib (
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
   reg         ijtag_from_so_retime;

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

   always @(negedge ijtag_tck)
   begin 
      ijtag_from_so_retime <= ccm_scan_en ? so_retime : ijtag_from_so;
   end

   assign ccm_te_so = ijtag_from_so_retime;

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
               sib <= ijtag_from_so_retime;
            end
            else begin
               sib <= ijtag_si;
            end
         end
      end
   end

endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_decompressor (
   input  wire        edt_clock,
   input  wire        edt_update,
   input  wire [ 1:0] edt_channels_in,
   input  wire [59:0] edt_chain_mask,
   input  wire        edt_chain_mask_load_en,
   output wire [59:0] edt_scan_in,
   input  wire        lbist_reset,
   input  wire        lbist_en,
   input  wire        lbist_prpg_en,
   input  wire        lbist_low_power_shift_en,
   input  wire        ijtag_tck,
   input  wire        ijtag_reset,
   input  wire        ijtag_sel,
   input  wire        ijtag_ce,
   input  wire        ijtag_se,
   input  wire        ijtag_ue,
   input  wire        ccm_scan_en,
   input  wire        ccm_le_si,
   output wire        ccm_le_so,
   input  wire        ccm_te_si,
   output wire        ccm_te_so,
   input  wire        ijtag_si,
   output wire        ijtag_so,
   output wire [ 2:0] ccm_edt_override
);
   reg    [59:0] edt_scan_in_unmasked;
   reg    [30:0] lfsm_vec;
   reg    [30:0] lfsm_vec_lockup;
   wire   [ 1:0] lfsm_inject;
   wire          lbist_scan_en;
   wire          ijtag_to_sel;
   wire          ijtag_so_int;
   wire          decompressor_sib_so;
   wire          lbist_lp_static_control_sib_so;
   wire          lbist_scan_en_lp_static_control;
   wire          ijtag_to_sel_lp_static_control;
   wire          lbist_scan_en_lp_mask_shift_reg;
   wire          ijtag_to_sel_lp_mask_shift_reg;
   wire          ccm_te_so_decompressor_sib;
   wire          ccm_te_so_lbist_lp_static_control_sib;
   wire          ijtag_si_int;
   wire   [59:0] effective_chain_input_mask;
   reg    [ 3:0] lbist_lp_hold_reg;
   reg    [ 3:0] lbist_lp_toggle_reg;
   wire   [ 3:0] lbist_lp_ht_encoder_in;
   wire          lbist_lp_ht_encoder_prpg_c1;
   wire          lbist_lp_ht_encoder_prpg_c2;
   wire          lbist_lp_ht_encoder_prpg_c3;
   wire          lbist_lp_ht_encoder_prpg_c4;
   wire          lbist_lp_ht_encoder_out;
   reg           lbist_lp_T_reg;
   reg    [ 3:0] lbist_lp_switching_reg;
   wire          lbist_lp_switching_prpg_c1;
   wire          lbist_lp_switching_prpg_c2;
   wire          lbist_lp_switching_prpg_c3;
   wire          lbist_lp_switching_prpg_c4;
   wire          lbist_lp_switching_encoder_out;
   wire          lbist_lp_mask_shift_reg_in;
   reg    [30:0] lbist_lp_mask_shift_reg;
   reg    [30:0] lbist_lp_mask_hold_reg;
   wire          lbist_lp_mask_force_update;
   wire   [30:0] lbist_lp_mask;
   wire          lbist_reset_sync;
   wire          edt_update_sync;

   assign ijtag_si_int = ccm_scan_en ? ccm_le_si : ijtag_si;
   assign lfsm_inject = (lbist_en == 1'b1 || lbist_scan_en == 1'b1) ? 2'b00 : edt_channels_in;
   assign lbist_reset_sync = (lbist_reset & lbist_en) & ~ccm_scan_en;
   assign lbist_scan_en = ccm_scan_en | (ijtag_to_sel & ijtag_se);
   assign lbist_scan_en_lp_static_control = ccm_scan_en | (ijtag_to_sel_lp_static_control & ijtag_se);
   assign lbist_scan_en_lp_mask_shift_reg = ccm_scan_en | (ijtag_to_sel_lp_mask_shift_reg & ijtag_se);
   assign edt_update_sync = edt_update & ~ccm_scan_en;

   // synopsys sync_set_reset "edt_update_sync, lbist_reset_sync"
   always @(posedge edt_clock)
   begin : lfsm
      if (edt_update_sync == 1'b1) begin
         lfsm_vec <= 31'b0000000000000000000000000000000;
      end
      else if (lbist_reset_sync == 1'b1) begin
         lfsm_vec <= 31'b0100010000001011011001111000011;
      end
      else if (ccm_scan_en == 1'b1 || (lbist_en == 1'b0 || (lbist_en == 1'b1 && (lbist_prpg_en == 1'b1 || lbist_scan_en == 1'b1)))) begin
         lfsm_vec[ 0] <= lfsm_vec[ 1];
         lfsm_vec[ 1] <= lfsm_vec[ 2] ^ lfsm_inject[0];
         lfsm_vec[ 2] <= lfsm_vec[ 3];
         lfsm_vec[ 3] <= lfsm_vec[ 4];
         lfsm_vec[ 4] <= lfsm_vec[ 5] ^ lfsm_inject[0];
         lfsm_vec[ 5] <= lfsm_vec[ 6];
         lfsm_vec[ 6] <= lfsm_vec[ 7] ^ lfsm_inject[1];
         lfsm_vec[ 7] <= lfsm_vec[ 8];
         lfsm_vec[ 8] <= lfsm_vec[ 9] ^ lfsm_inject[1];
         lfsm_vec[ 9] <= lfsm_vec[10];
         lfsm_vec[10] <= lfsm_vec[11] ^ lfsm_inject[1];
         lfsm_vec[11] <= lfsm_vec[12];
         lfsm_vec[12] <= lfsm_vec[13] ^ lfsm_inject[1];
         lfsm_vec[13] <= lfsm_vec[14];
         lfsm_vec[14] <= lfsm_vec[15];
         lfsm_vec[15] <= lfsm_vec[16] ^ lfsm_inject[1];
         lfsm_vec[16] <= lfsm_vec[17];
         lfsm_vec[17] <= lfsm_vec[18] ^ lfsm_inject[1];
         lfsm_vec[18] <= lfsm_vec[19] ^ (lfsm_vec[12] & ~lbist_scan_en);
         lfsm_vec[19] <= lfsm_vec[20] ^ lfsm_inject[1];
         lfsm_vec[20] <= lfsm_vec[21] ^ (lfsm_vec[ 9] & ~lbist_scan_en);
         lfsm_vec[21] <= lfsm_vec[22] ^ lfsm_inject[0];
         lfsm_vec[22] <= lfsm_vec[23];
         lfsm_vec[23] <= lfsm_vec[24] ^ lfsm_inject[0];
         lfsm_vec[24] <= lfsm_vec[25];
         lfsm_vec[25] <= lfsm_vec[26] ^ (lfsm_vec[ 5] & ~lbist_scan_en);
         lfsm_vec[26] <= lfsm_vec[27] ^ lfsm_inject[0];
         lfsm_vec[27] <= lfsm_vec[28];
         lfsm_vec[28] <= lfsm_vec[29] ^ lfsm_inject[0];
         lfsm_vec[29] <= lfsm_vec[30];
         lfsm_vec[30] <= lbist_scan_en ? ijtag_si_int : (lfsm_vec[ 0] ^ lfsm_inject[0]);
      end
   end

   assign ijtag_so_int = ccm_scan_en ? lbist_lp_mask_hold_reg[0] : lbist_lp_mask_shift_reg[0];

   assign ccm_edt_override = lfsm_vec[2:0];

   always @(negedge edt_clock)
   begin : lockup_cells
      if (ccm_scan_en == 1'b1) begin
         lfsm_vec_lockup <= {ccm_te_si, lfsm_vec_lockup[30:1]};
      end
      else begin
         if (lbist_en == 1'b0 || lbist_lp_mask[ 0] == 1'b1) begin
            lfsm_vec_lockup[ 0] <= lfsm_vec[ 0];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 1] == 1'b1) begin
            lfsm_vec_lockup[ 1] <= lfsm_vec[ 1];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 2] == 1'b1) begin
            lfsm_vec_lockup[ 2] <= lfsm_vec[ 2];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 3] == 1'b1) begin
            lfsm_vec_lockup[ 3] <= lfsm_vec[ 3];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 4] == 1'b1) begin
            lfsm_vec_lockup[ 4] <= lfsm_vec[ 4];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 5] == 1'b1) begin
            lfsm_vec_lockup[ 5] <= lfsm_vec[ 5];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 6] == 1'b1) begin
            lfsm_vec_lockup[ 6] <= lfsm_vec[ 6];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 7] == 1'b1) begin
            lfsm_vec_lockup[ 7] <= lfsm_vec[ 7];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 8] == 1'b1) begin
            lfsm_vec_lockup[ 8] <= lfsm_vec[ 8];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[ 9] == 1'b1) begin
            lfsm_vec_lockup[ 9] <= lfsm_vec[ 9];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[10] == 1'b1) begin
            lfsm_vec_lockup[10] <= lfsm_vec[10];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[11] == 1'b1) begin
            lfsm_vec_lockup[11] <= lfsm_vec[11];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[12] == 1'b1) begin
            lfsm_vec_lockup[12] <= lfsm_vec[12];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[13] == 1'b1) begin
            lfsm_vec_lockup[13] <= lfsm_vec[13];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[14] == 1'b1) begin
            lfsm_vec_lockup[14] <= lfsm_vec[14];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[15] == 1'b1) begin
            lfsm_vec_lockup[15] <= lfsm_vec[15];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[16] == 1'b1) begin
            lfsm_vec_lockup[16] <= lfsm_vec[16];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[17] == 1'b1) begin
            lfsm_vec_lockup[17] <= lfsm_vec[17];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[18] == 1'b1) begin
            lfsm_vec_lockup[18] <= lfsm_vec[18];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[19] == 1'b1) begin
            lfsm_vec_lockup[19] <= lfsm_vec[19];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[20] == 1'b1) begin
            lfsm_vec_lockup[20] <= lfsm_vec[20];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[21] == 1'b1) begin
            lfsm_vec_lockup[21] <= lfsm_vec[21];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[22] == 1'b1) begin
            lfsm_vec_lockup[22] <= lfsm_vec[22];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[23] == 1'b1) begin
            lfsm_vec_lockup[23] <= lfsm_vec[23];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[24] == 1'b1) begin
            lfsm_vec_lockup[24] <= lfsm_vec[24];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[25] == 1'b1) begin
            lfsm_vec_lockup[25] <= lfsm_vec[25];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[26] == 1'b1) begin
            lfsm_vec_lockup[26] <= lfsm_vec[26];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[27] == 1'b1) begin
            lfsm_vec_lockup[27] <= lfsm_vec[27];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[28] == 1'b1) begin
            lfsm_vec_lockup[28] <= lfsm_vec[28];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[29] == 1'b1) begin
            lfsm_vec_lockup[29] <= lfsm_vec[29];
         end
         if (lbist_en == 1'b0 || lbist_lp_mask[30] == 1'b1) begin
            lfsm_vec_lockup[30] <= lfsm_vec[30];
         end
      end
   end

   always @(lfsm_vec_lockup)
   begin : phase_shifter
      edt_scan_in_unmasked[ 0] = lfsm_vec_lockup[12] ^ lfsm_vec_lockup[15] ^ lfsm_vec_lockup[17];
      edt_scan_in_unmasked[ 1] = lfsm_vec_lockup[13] ^ lfsm_vec_lockup[14] ^ lfsm_vec_lockup[26];
      edt_scan_in_unmasked[ 2] = lfsm_vec_lockup[ 1] ^ lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[30];
      edt_scan_in_unmasked[ 3] = lfsm_vec_lockup[ 7] ^ lfsm_vec_lockup[ 9] ^ lfsm_vec_lockup[29];
      edt_scan_in_unmasked[ 4] = lfsm_vec_lockup[ 3] ^ lfsm_vec_lockup[ 5] ^ lfsm_vec_lockup[23];
      edt_scan_in_unmasked[ 5] = lfsm_vec_lockup[ 6] ^ lfsm_vec_lockup[10] ^ lfsm_vec_lockup[25];
      edt_scan_in_unmasked[ 6] = lfsm_vec_lockup[ 0] ^ lfsm_vec_lockup[19] ^ lfsm_vec_lockup[28];
      edt_scan_in_unmasked[ 7] = lfsm_vec_lockup[11] ^ lfsm_vec_lockup[22] ^ lfsm_vec_lockup[24];
      edt_scan_in_unmasked[ 8] = lfsm_vec_lockup[ 8] ^ lfsm_vec_lockup[18] ^ lfsm_vec_lockup[20];
      edt_scan_in_unmasked[ 9] = lfsm_vec_lockup[ 4] ^ lfsm_vec_lockup[16] ^ lfsm_vec_lockup[21];
      edt_scan_in_unmasked[10] = lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[24] ^ lfsm_vec_lockup[26];
      edt_scan_in_unmasked[11] = lfsm_vec_lockup[ 7] ^ lfsm_vec_lockup[25] ^ lfsm_vec_lockup[30];
      edt_scan_in_unmasked[12] = lfsm_vec_lockup[ 4] ^ lfsm_vec_lockup[17] ^ lfsm_vec_lockup[27];
      edt_scan_in_unmasked[13] = lfsm_vec_lockup[ 9] ^ lfsm_vec_lockup[22] ^ lfsm_vec_lockup[23];
      edt_scan_in_unmasked[14] = lfsm_vec_lockup[20] ^ lfsm_vec_lockup[27] ^ lfsm_vec_lockup[29];
      edt_scan_in_unmasked[15] = lfsm_vec_lockup[ 3] ^ lfsm_vec_lockup[11] ^ lfsm_vec_lockup[15];
      edt_scan_in_unmasked[16] = lfsm_vec_lockup[10] ^ lfsm_vec_lockup[12] ^ lfsm_vec_lockup[19];
      edt_scan_in_unmasked[17] = lfsm_vec_lockup[ 1] ^ lfsm_vec_lockup[ 6] ^ lfsm_vec_lockup[13];
      edt_scan_in_unmasked[18] = lfsm_vec_lockup[ 0] ^ lfsm_vec_lockup[ 5] ^ lfsm_vec_lockup[18];
      edt_scan_in_unmasked[19] = lfsm_vec_lockup[ 8] ^ lfsm_vec_lockup[14] ^ lfsm_vec_lockup[16];
      edt_scan_in_unmasked[20] = lfsm_vec_lockup[ 1] ^ lfsm_vec_lockup[15] ^ lfsm_vec_lockup[30];
      edt_scan_in_unmasked[21] = lfsm_vec_lockup[ 9] ^ lfsm_vec_lockup[18] ^ lfsm_vec_lockup[25];
      edt_scan_in_unmasked[22] = lfsm_vec_lockup[ 4] ^ lfsm_vec_lockup[24] ^ lfsm_vec_lockup[26];
      edt_scan_in_unmasked[23] = lfsm_vec_lockup[ 3] ^ lfsm_vec_lockup[ 7] ^ lfsm_vec_lockup[19];
      edt_scan_in_unmasked[24] = lfsm_vec_lockup[ 5] ^ lfsm_vec_lockup[12] ^ lfsm_vec_lockup[28];
      edt_scan_in_unmasked[25] = lfsm_vec_lockup[ 6] ^ lfsm_vec_lockup[13] ^ lfsm_vec_lockup[23];
      edt_scan_in_unmasked[26] = lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[11] ^ lfsm_vec_lockup[29];
      edt_scan_in_unmasked[27] = lfsm_vec_lockup[10] ^ lfsm_vec_lockup[14] ^ lfsm_vec_lockup[16];
      edt_scan_in_unmasked[28] = lfsm_vec_lockup[ 0] ^ lfsm_vec_lockup[21] ^ lfsm_vec_lockup[28];
      edt_scan_in_unmasked[29] = lfsm_vec_lockup[ 8] ^ lfsm_vec_lockup[21] ^ lfsm_vec_lockup[27];
      edt_scan_in_unmasked[30] = lfsm_vec_lockup[10] ^ lfsm_vec_lockup[14] ^ lfsm_vec_lockup[21];
      edt_scan_in_unmasked[31] = lfsm_vec_lockup[ 5] ^ lfsm_vec_lockup[18] ^ lfsm_vec_lockup[27];
      edt_scan_in_unmasked[32] = lfsm_vec_lockup[23] ^ lfsm_vec_lockup[24] ^ lfsm_vec_lockup[25];
      edt_scan_in_unmasked[33] = lfsm_vec_lockup[ 1] ^ lfsm_vec_lockup[ 8] ^ lfsm_vec_lockup[13];
      edt_scan_in_unmasked[34] = lfsm_vec_lockup[ 4] ^ lfsm_vec_lockup[17] ^ lfsm_vec_lockup[28];
      edt_scan_in_unmasked[35] = lfsm_vec_lockup[ 9] ^ lfsm_vec_lockup[26] ^ lfsm_vec_lockup[30];
      edt_scan_in_unmasked[36] = lfsm_vec_lockup[ 0] ^ lfsm_vec_lockup[20] ^ lfsm_vec_lockup[22];
      edt_scan_in_unmasked[37] = lfsm_vec_lockup[15] ^ lfsm_vec_lockup[17] ^ lfsm_vec_lockup[19];
      edt_scan_in_unmasked[38] = lfsm_vec_lockup[ 6] ^ lfsm_vec_lockup[11] ^ lfsm_vec_lockup[29];
      edt_scan_in_unmasked[39] = lfsm_vec_lockup[ 7] ^ lfsm_vec_lockup[12] ^ lfsm_vec_lockup[22];
      edt_scan_in_unmasked[40] = lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[16] ^ lfsm_vec_lockup[20];
      edt_scan_in_unmasked[41] = lfsm_vec_lockup[ 0] ^ lfsm_vec_lockup[10] ^ lfsm_vec_lockup[16];
      edt_scan_in_unmasked[42] = lfsm_vec_lockup[ 4] ^ lfsm_vec_lockup[11] ^ lfsm_vec_lockup[20];
      edt_scan_in_unmasked[43] = lfsm_vec_lockup[14] ^ lfsm_vec_lockup[26] ^ lfsm_vec_lockup[29];
      edt_scan_in_unmasked[44] = lfsm_vec_lockup[ 3] ^ lfsm_vec_lockup[18] ^ lfsm_vec_lockup[24];
      edt_scan_in_unmasked[45] = lfsm_vec_lockup[ 5] ^ lfsm_vec_lockup[ 7] ^ lfsm_vec_lockup[23];
      edt_scan_in_unmasked[46] = lfsm_vec_lockup[ 8] ^ lfsm_vec_lockup[ 9] ^ lfsm_vec_lockup[19];
      edt_scan_in_unmasked[47] = lfsm_vec_lockup[ 6] ^ lfsm_vec_lockup[12] ^ lfsm_vec_lockup[25];
      edt_scan_in_unmasked[48] = lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[ 3] ^ lfsm_vec_lockup[13];
      edt_scan_in_unmasked[49] = lfsm_vec_lockup[27] ^ lfsm_vec_lockup[28] ^ lfsm_vec_lockup[30];
      edt_scan_in_unmasked[50] = lfsm_vec_lockup[ 1] ^ lfsm_vec_lockup[17] ^ lfsm_vec_lockup[21];
      edt_scan_in_unmasked[51] = lfsm_vec_lockup[ 8] ^ lfsm_vec_lockup[20] ^ lfsm_vec_lockup[26];
      edt_scan_in_unmasked[52] = lfsm_vec_lockup[13] ^ lfsm_vec_lockup[14] ^ lfsm_vec_lockup[27];
      edt_scan_in_unmasked[53] = lfsm_vec_lockup[10] ^ lfsm_vec_lockup[19] ^ lfsm_vec_lockup[25];
      edt_scan_in_unmasked[54] = lfsm_vec_lockup[ 0] ^ lfsm_vec_lockup[ 7] ^ lfsm_vec_lockup[18];
      edt_scan_in_unmasked[55] = lfsm_vec_lockup[12] ^ lfsm_vec_lockup[15] ^ lfsm_vec_lockup[16];
      edt_scan_in_unmasked[56] = lfsm_vec_lockup[ 1] ^ lfsm_vec_lockup[ 3] ^ lfsm_vec_lockup[30];
      edt_scan_in_unmasked[57] = lfsm_vec_lockup[ 2] ^ lfsm_vec_lockup[ 6] ^ lfsm_vec_lockup[17];
      edt_scan_in_unmasked[58] = lfsm_vec_lockup[ 4] ^ lfsm_vec_lockup[ 5] ^ lfsm_vec_lockup[24];
      edt_scan_in_unmasked[59] = lfsm_vec_lockup[15] ^ lfsm_vec_lockup[21] ^ lfsm_vec_lockup[28];
   end

   assign effective_chain_input_mask = edt_chain_mask_load_en ? edt_chain_mask : 60'b111111111111111111111111111111111111111111111111111111111111;

   assign edt_scan_in = edt_scan_in_unmasked & effective_chain_input_mask;

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_decompressor_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(ijtag_si),
      .ijtag_from_so(lfsm_vec[0]),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(lfsm_vec_lockup[0]),
      .ccm_te_so(ccm_te_so_decompressor_sib),
      .ijtag_so(decompressor_sib_so),
      .ijtag_to_sel(ijtag_to_sel));

   always @(posedge edt_clock)
   begin : lbist_low_power_hold_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_hold_reg <= 4'd15;
      end
      else if (lbist_scan_en_lp_static_control == 1'b1) begin
         lbist_lp_hold_reg <= {decompressor_sib_so, lbist_lp_hold_reg[3:1]};
      end
   end

   always @(posedge edt_clock)
   begin : lbist_low_power_toggle_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_toggle_reg <= 4'd3;
      end
      else if (lbist_scan_en_lp_static_control == 1'b1) begin
         lbist_lp_toggle_reg <= {lbist_lp_hold_reg[0], lbist_lp_toggle_reg[3:1]};
      end
   end

   assign lbist_lp_ht_encoder_in = lbist_lp_T_reg ? lbist_lp_toggle_reg : lbist_lp_hold_reg;

   assign lbist_lp_ht_encoder_prpg_c1 = lfsm_vec[0];
   assign lbist_lp_ht_encoder_prpg_c2 = lfsm_vec[3] & lfsm_vec[6];
   assign lbist_lp_ht_encoder_prpg_c3 = lfsm_vec[9] & lfsm_vec[12] & lfsm_vec[15];
   assign lbist_lp_ht_encoder_prpg_c4 = lfsm_vec[18] & lfsm_vec[21] & lfsm_vec[24] & lfsm_vec[27];

   assign lbist_lp_ht_encoder_out = (lbist_lp_ht_encoder_in[0] & lbist_lp_ht_encoder_prpg_c1) |
                                    (lbist_lp_ht_encoder_in[1] & lbist_lp_ht_encoder_prpg_c2) |
                                    (lbist_lp_ht_encoder_in[2] & lbist_lp_ht_encoder_prpg_c3) |
                                    (lbist_lp_ht_encoder_in[3] & lbist_lp_ht_encoder_prpg_c4);

   always @(posedge edt_clock)
   begin 
      if (ccm_scan_en == 1'b1) begin
         lbist_lp_T_reg <= lbist_lp_mask_shift_reg[0];
      end
      else if (lbist_reset == 1'b1 || lbist_prpg_en == 1'b0) begin
         lbist_lp_T_reg <= 1'b1;
      end
      else if (lbist_lp_ht_encoder_out == 1'b1) begin
         lbist_lp_T_reg <= ~lbist_lp_T_reg;
      end
   end

   always @(posedge edt_clock)
   begin : lbist_low_power_switching_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_switching_reg <= 4'd3;
      end
      else if (lbist_scan_en_lp_static_control == 1'b1) begin
         lbist_lp_switching_reg <= {lbist_lp_toggle_reg[0], lbist_lp_switching_reg[3:1]};
      end
   end

   assign lbist_lp_switching_prpg_c1 = lfsm_vec[1];
   assign lbist_lp_switching_prpg_c2 = lfsm_vec[4] & lfsm_vec[7];
   assign lbist_lp_switching_prpg_c3 = lfsm_vec[10] & lfsm_vec[13] & lfsm_vec[16];
   assign lbist_lp_switching_prpg_c4 = lfsm_vec[19] & lfsm_vec[22] & lfsm_vec[25] & lfsm_vec[28];

   assign lbist_lp_switching_encoder_out = (lbist_lp_switching_reg[0] & lbist_lp_switching_prpg_c1) |
                                           (lbist_lp_switching_reg[1] & lbist_lp_switching_prpg_c2) |
                                           (lbist_lp_switching_reg[2] & lbist_lp_switching_prpg_c3) |
                                           (lbist_lp_switching_reg[3] & lbist_lp_switching_prpg_c4);

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_static_control_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(decompressor_sib_so),
      .ijtag_from_so(lbist_lp_switching_reg[0]),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_decompressor_sib),
      .ccm_te_so(ccm_te_so_lbist_lp_static_control_sib),
      .ijtag_so(lbist_lp_static_control_sib_so),
      .ijtag_to_sel(ijtag_to_sel_lp_static_control));

   assign lbist_lp_mask_shift_reg_in = lbist_scan_en_lp_mask_shift_reg ? lbist_lp_static_control_sib_so : lbist_lp_switching_encoder_out;

   always @(posedge edt_clock)
   begin : lbist_low_power_mask_shift_register
      if (lbist_reset == 1'b1) begin
         lbist_lp_mask_shift_reg <= 31'b1010011001111000111110110101000;
      end
      else if (lbist_scan_en_lp_mask_shift_reg == 1'b1 || lbist_prpg_en == 1'b1) begin
         lbist_lp_mask_shift_reg <= {lbist_lp_mask_shift_reg_in, lbist_lp_mask_shift_reg[30:1]};
      end
   end

   always @(posedge edt_clock)
   begin 
      if (ccm_scan_en == 1'b1) begin
         lbist_lp_mask_hold_reg <= {lbist_lp_T_reg, lbist_lp_mask_hold_reg[30:1]};
      end
      else if (lbist_prpg_en == 1'b0) begin
         lbist_lp_mask_hold_reg <= lbist_lp_mask_shift_reg;
      end
   end

   assign lbist_lp_mask_force_update = (~|lbist_lp_switching_reg) | ~lbist_prpg_en | ~lbist_low_power_shift_en;

   assign lbist_lp_mask = ({31{lbist_lp_T_reg}} & lbist_lp_mask_hold_reg) | {31{lbist_lp_mask_force_update}};
   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(lbist_lp_static_control_sib_so),
      .ijtag_from_so(ijtag_so_int),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_lbist_lp_static_control_sib),
      .ccm_te_so(ccm_te_so),
      .ijtag_so(ijtag_so),
      .ijtag_to_sel(ijtag_to_sel_lp_mask_shift_reg));

   assign ccm_le_so = ijtag_so;
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_onehot_decoder_5_to_30 (
   input  wire [ 4:0] encoded_masks,
   output reg  [29:0] decoded_masks
);
   always @(encoded_masks)
   begin
      case (encoded_masks)
         5'b00000: decoded_masks = 30'b000000000000000000000000000000;
         5'b00001: decoded_masks = 30'b000000000000000000000000000001;
         5'b00010: decoded_masks = 30'b000000000000000000000000000010;
         5'b00011: decoded_masks = 30'b000000000000000000000000000100;
         5'b00100: decoded_masks = 30'b000000000000000000000000001000;
         5'b00101: decoded_masks = 30'b000000000000000000000000010000;
         5'b00110: decoded_masks = 30'b000000000000000000000000100000;
         5'b00111: decoded_masks = 30'b000000000000000000000001000000;
         5'b01000: decoded_masks = 30'b000000000000000000000010000000;
         5'b01001: decoded_masks = 30'b000000000000000000000100000000;
         5'b01010: decoded_masks = 30'b000000000000000000001000000000;
         5'b01011: decoded_masks = 30'b000000000000000000010000000000;
         5'b01100: decoded_masks = 30'b000000000000000000100000000000;
         5'b01101: decoded_masks = 30'b000000000000000001000000000000;
         5'b01110: decoded_masks = 30'b000000000000000010000000000000;
         5'b01111: decoded_masks = 30'b000000000000000100000000000000;
         5'b10000: decoded_masks = 30'b000000000000001000000000000000;
         5'b10001: decoded_masks = 30'b000000000000010000000000000000;
         5'b10010: decoded_masks = 30'b000000000000100000000000000000;
         5'b10011: decoded_masks = 30'b000000000001000000000000000000;
         5'b10100: decoded_masks = 30'b000000000010000000000000000000;
         5'b10101: decoded_masks = 30'b000000000100000000000000000000;
         5'b10110: decoded_masks = 30'b000000001000000000000000000000;
         5'b10111: decoded_masks = 30'b000000010000000000000000000000;
         5'b11000: decoded_masks = 30'b000000100000000000000000000000;
         5'b11001: decoded_masks = 30'b000001000000000000000000000000;
         5'b11010: decoded_masks = 30'b000010000000000000000000000000;
         5'b11011: decoded_masks = 30'b000100000000000000000000000000;
         5'b11100: decoded_masks = 30'b001000000000000000000000000000;
         5'b11101: decoded_masks = 30'b010000000000000000000000000000;
         5'b11110: decoded_masks = 30'b100000000000000000000000000000;
         default:  decoded_masks = 30'b111111111111111111111111111111;
      endcase
   end
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_xor_decoder (
   input  wire [17:0] encoded_masks,
   output wire [29:0] decoded_masks_0,
   output wire [29:0] decoded_masks_1
);
   assign decoded_masks_0[ 0] = encoded_masks[ 0] ^ encoded_masks[ 1] ^ encoded_masks[ 2];
   assign decoded_masks_0[ 1] = encoded_masks[ 0] ^ encoded_masks[ 1] ^ encoded_masks[ 3];
   assign decoded_masks_0[ 2] = encoded_masks[ 0] ^ encoded_masks[ 1] ^ encoded_masks[ 4];
   assign decoded_masks_0[ 3] = encoded_masks[ 0] ^ encoded_masks[ 1] ^ encoded_masks[ 5];
   assign decoded_masks_0[ 4] = encoded_masks[ 0] ^ encoded_masks[ 1] ^ encoded_masks[ 6];
   assign decoded_masks_0[ 5] = encoded_masks[ 0] ^ encoded_masks[ 1] ^ encoded_masks[ 7];
   assign decoded_masks_0[ 6] = encoded_masks[ 0] ^ encoded_masks[ 1] ^ encoded_masks[ 8];
   assign decoded_masks_0[ 7] = encoded_masks[ 0] ^ encoded_masks[ 2] ^ encoded_masks[ 3];
   assign decoded_masks_0[ 8] = encoded_masks[ 1] ^ encoded_masks[ 2] ^ encoded_masks[ 3];
   assign decoded_masks_0[ 9] = encoded_masks[ 3] ^ encoded_masks[ 4] ^ encoded_masks[ 7];
   assign decoded_masks_0[10] = encoded_masks[ 1] ^ encoded_masks[ 6] ^ encoded_masks[ 8];
   assign decoded_masks_0[11] = encoded_masks[ 2] ^ encoded_masks[ 4] ^ encoded_masks[ 5];
   assign decoded_masks_0[12] = encoded_masks[ 5] ^ encoded_masks[ 6] ^ encoded_masks[ 7];
   assign decoded_masks_0[13] = encoded_masks[ 0] ^ encoded_masks[ 4] ^ encoded_masks[ 8];
   assign decoded_masks_0[14] = encoded_masks[ 0] ^ encoded_masks[ 5] ^ encoded_masks[ 6];
   assign decoded_masks_0[15] = encoded_masks[ 6] ^ encoded_masks[ 7] ^ encoded_masks[ 8];
   assign decoded_masks_0[16] = encoded_masks[ 2] ^ encoded_masks[ 5] ^ encoded_masks[ 7];
   assign decoded_masks_0[17] = encoded_masks[ 3] ^ encoded_masks[ 6] ^ encoded_masks[ 8];
   assign decoded_masks_0[18] = encoded_masks[ 1] ^ encoded_masks[ 4] ^ encoded_masks[ 8];
   assign decoded_masks_0[19] = encoded_masks[ 3] ^ encoded_masks[ 4] ^ encoded_masks[ 5];
   assign decoded_masks_0[20] = encoded_masks[ 2] ^ encoded_masks[ 6] ^ encoded_masks[ 7];
   assign decoded_masks_0[21] = encoded_masks[ 0] ^ encoded_masks[ 2] ^ encoded_masks[ 6];
   assign decoded_masks_0[22] = encoded_masks[ 5] ^ encoded_masks[ 7] ^ encoded_masks[ 8];
   assign decoded_masks_0[23] = encoded_masks[ 1] ^ encoded_masks[ 3] ^ encoded_masks[ 4];
   assign decoded_masks_0[24] = encoded_masks[ 2] ^ encoded_masks[ 3] ^ encoded_masks[ 7];
   assign decoded_masks_0[25] = encoded_masks[ 4] ^ encoded_masks[ 6] ^ encoded_masks[ 8];
   assign decoded_masks_0[26] = encoded_masks[ 2] ^ encoded_masks[ 5] ^ encoded_masks[ 6];
   assign decoded_masks_0[27] = encoded_masks[ 0] ^ encoded_masks[ 2] ^ encoded_masks[ 4];
   assign decoded_masks_0[28] = encoded_masks[ 0] ^ encoded_masks[ 5] ^ encoded_masks[ 7];
   assign decoded_masks_0[29] = encoded_masks[ 3] ^ encoded_masks[ 5] ^ encoded_masks[ 8];

   assign decoded_masks_1[ 0] = encoded_masks[ 9] ^ encoded_masks[10] ^ encoded_masks[11];
   assign decoded_masks_1[ 1] = encoded_masks[ 9] ^ encoded_masks[10] ^ encoded_masks[12];
   assign decoded_masks_1[ 2] = encoded_masks[ 9] ^ encoded_masks[10] ^ encoded_masks[13];
   assign decoded_masks_1[ 3] = encoded_masks[ 9] ^ encoded_masks[10] ^ encoded_masks[14];
   assign decoded_masks_1[ 4] = encoded_masks[ 9] ^ encoded_masks[10] ^ encoded_masks[15];
   assign decoded_masks_1[ 5] = encoded_masks[ 9] ^ encoded_masks[10] ^ encoded_masks[16];
   assign decoded_masks_1[ 6] = encoded_masks[ 9] ^ encoded_masks[10] ^ encoded_masks[17];
   assign decoded_masks_1[ 7] = encoded_masks[ 9] ^ encoded_masks[11] ^ encoded_masks[12];
   assign decoded_masks_1[ 8] = encoded_masks[10] ^ encoded_masks[11] ^ encoded_masks[12];
   assign decoded_masks_1[ 9] = encoded_masks[12] ^ encoded_masks[13] ^ encoded_masks[16];
   assign decoded_masks_1[10] = encoded_masks[10] ^ encoded_masks[15] ^ encoded_masks[17];
   assign decoded_masks_1[11] = encoded_masks[11] ^ encoded_masks[13] ^ encoded_masks[14];
   assign decoded_masks_1[12] = encoded_masks[14] ^ encoded_masks[15] ^ encoded_masks[16];
   assign decoded_masks_1[13] = encoded_masks[ 9] ^ encoded_masks[13] ^ encoded_masks[17];
   assign decoded_masks_1[14] = encoded_masks[ 9] ^ encoded_masks[14] ^ encoded_masks[15];
   assign decoded_masks_1[15] = encoded_masks[15] ^ encoded_masks[16] ^ encoded_masks[17];
   assign decoded_masks_1[16] = encoded_masks[11] ^ encoded_masks[14] ^ encoded_masks[16];
   assign decoded_masks_1[17] = encoded_masks[12] ^ encoded_masks[15] ^ encoded_masks[17];
   assign decoded_masks_1[18] = encoded_masks[10] ^ encoded_masks[13] ^ encoded_masks[17];
   assign decoded_masks_1[19] = encoded_masks[12] ^ encoded_masks[13] ^ encoded_masks[14];
   assign decoded_masks_1[20] = encoded_masks[11] ^ encoded_masks[15] ^ encoded_masks[16];
   assign decoded_masks_1[21] = encoded_masks[ 9] ^ encoded_masks[11] ^ encoded_masks[15];
   assign decoded_masks_1[22] = encoded_masks[14] ^ encoded_masks[16] ^ encoded_masks[17];
   assign decoded_masks_1[23] = encoded_masks[10] ^ encoded_masks[12] ^ encoded_masks[13];
   assign decoded_masks_1[24] = encoded_masks[11] ^ encoded_masks[12] ^ encoded_masks[16];
   assign decoded_masks_1[25] = encoded_masks[13] ^ encoded_masks[15] ^ encoded_masks[17];
   assign decoded_masks_1[26] = encoded_masks[11] ^ encoded_masks[14] ^ encoded_masks[15];
   assign decoded_masks_1[27] = encoded_masks[ 9] ^ encoded_masks[11] ^ encoded_masks[13];
   assign decoded_masks_1[28] = encoded_masks[ 9] ^ encoded_masks[14] ^ encoded_masks[16];
   assign decoded_masks_1[29] = encoded_masks[12] ^ encoded_masks[14] ^ encoded_masks[17];

endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_controller (
   input  wire        edt_clock,
   input  wire        edt_update,
   input  wire [ 1:0] edt_channels_in,
   output wire [ 1:0] edt_channels_out_from_controller,
   output wire [29:0] masks_for_compactor_0,
   output wire [29:0] masks_for_compactor_1,
   output reg  [59:0] edt_chain_mask,
   output reg         edt_chain_mask_load_en,
   input  wire        lbist_reset,
   input  wire        lbist_en,
   input  wire        ijtag_tck,
   input  wire        ijtag_reset,
   input  wire        ijtag_sel,
   input  wire        ijtag_ce,
   input  wire        ijtag_se,
   input  wire        ijtag_ue,
   input  wire        ccm_en,
   input  wire        ccm_scan_en,
   input  wire        ccm_le_si,
   output wire        ccm_le_so,
   input  wire        ccm_te_si,
   output wire        ccm_te_so,
   input  wire        ijtag_si,
   output wire        ijtag_so
);
   reg    [ 9:0] masks_shift_reg_0;
   reg    [ 8:0] masks_shift_reg_1;
   reg    [ 9:0] masks_hold_reg_0;
   reg    [ 8:0] masks_hold_reg_1;
   wire          control_bit;
   wire   [ 4:0] onehot_encoded_masks_0;
   wire   [ 4:0] onehot_encoded_masks_1;
   wire   [17:0] xor_encoded_masks;
   wire   [29:0] onehot_decoded_masks_0;
   wire   [29:0] onehot_decoded_masks_1;
   wire   [29:0] xor_decoded_masks_0;
   wire   [29:0] xor_decoded_masks_1;
   wire          masks_shift_reg_sync_reset;
   wire          lbist_scan_en;
   wire          ijtag_to_sel;
   wire          ijtag_so_int;
   wire   [29:0] edt_pp_masks_for_compactor_0;
   wire   [29:0] edt_pp_masks_for_compactor_1;
   wire   [29:0] effective_pp_masks_for_compactor_0;
   wire   [29:0] effective_pp_masks_for_compactor_1;
   wire          lbist_reset_sync;
   wire          ijtag_so_masks_reg;
   wire          ccm_compactor_mask_override;
   wire          ijtag_si_int;

   assign masks_shift_reg_sync_reset = edt_update & ~ccm_scan_en;

   // synopsys sync_set_reset masks_shift_reg_sync_reset
   always @(posedge edt_clock)
   begin : shift_masks_regs
      if (masks_shift_reg_sync_reset == 1'b1) begin
         masks_shift_reg_0 <= 10'b0000000000;
         masks_shift_reg_1 <= 9'b000000000;
      end
      else if (ccm_scan_en == 1'b1) begin
         masks_shift_reg_0 <= {masks_hold_reg_1[0], masks_shift_reg_0[9:1]};
         masks_shift_reg_1 <= {masks_shift_reg_0[0], masks_shift_reg_1[8:1]};
      end
      else begin
         masks_shift_reg_0 <= {edt_channels_in[0], masks_shift_reg_0[9:1]};
         masks_shift_reg_1 <= {edt_channels_in[1], masks_shift_reg_1[8:1]};
      end
   end

   assign ijtag_so_masks_reg = masks_shift_reg_1[0];

   always @(posedge edt_clock)
   begin : update_masks_regs
      if (ccm_scan_en == 1'b1) begin
         masks_hold_reg_0 <= {edt_chain_mask_load_en, masks_hold_reg_0[9:1]};
         masks_hold_reg_1 <= {masks_hold_reg_0[0], masks_hold_reg_1[8:1]};
      end
      else begin
         if (edt_update == 1'b1) begin
            masks_hold_reg_0 <= masks_shift_reg_0;
            masks_hold_reg_1 <= masks_shift_reg_1;
         end
      end
   end

   assign edt_channels_out_from_controller[0] = masks_shift_reg_0[0];
   assign edt_channels_out_from_controller[1] = masks_shift_reg_1[0];

   assign control_bit = masks_hold_reg_0[9];

   assign lbist_scan_en = ccm_scan_en | (ijtag_to_sel & ijtag_se);
   assign xor_encoded_masks = {masks_hold_reg_1[0], masks_hold_reg_1[1], masks_hold_reg_1[2], 
                               masks_hold_reg_1[3], masks_hold_reg_1[4], masks_hold_reg_1[5], 
                               masks_hold_reg_1[6], masks_hold_reg_1[7], masks_hold_reg_1[8], 
                               masks_hold_reg_0[0], masks_hold_reg_0[1], masks_hold_reg_0[2], 
                               masks_hold_reg_0[3], masks_hold_reg_0[4], masks_hold_reg_0[5], 
                               masks_hold_reg_0[6], masks_hold_reg_0[7], masks_hold_reg_0[8]};

   assign onehot_encoded_masks_0 = {masks_hold_reg_0[8], masks_hold_reg_0[7], masks_hold_reg_0[6], 
                                    masks_hold_reg_0[5], masks_hold_reg_0[4]};
   assign onehot_encoded_masks_1 = {masks_hold_reg_1[8], masks_hold_reg_1[7], masks_hold_reg_1[6], 
                                    masks_hold_reg_1[5], masks_hold_reg_1[4]};

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_xor_decoder xor_decoder (
      .encoded_masks(xor_encoded_masks),
      .decoded_masks_0(xor_decoded_masks_0),
      .decoded_masks_1(xor_decoded_masks_1));

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_onehot_decoder_5_to_30 decoder1 (.encoded_masks(onehot_encoded_masks_0),
                                                                                    .decoded_masks(onehot_decoded_masks_0));
   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_onehot_decoder_5_to_30 decoder2 (.encoded_masks(onehot_encoded_masks_1),
                                                                                    .decoded_masks(onehot_decoded_masks_1));

   assign edt_pp_masks_for_compactor_0 = control_bit ? onehot_decoded_masks_0 : xor_decoded_masks_0;
   assign edt_pp_masks_for_compactor_1 = control_bit ? onehot_decoded_masks_1 : xor_decoded_masks_1;

   assign ijtag_si_int = ccm_scan_en ? ccm_le_si : ijtag_si;

   assign lbist_reset_sync = (lbist_reset & lbist_en) & ~ccm_scan_en;

   // synopsys sync_set_reset lbist_reset_sync
   always @(posedge edt_clock)
   begin : chain_mask_shift_register
      if (lbist_reset_sync == 1'b1) begin
         edt_chain_mask <= 60'b111111111111111111111111111111111111111111111111111111111111;
      end
      else if (lbist_scan_en == 1'b1) begin
         edt_chain_mask <= {ijtag_si_int, edt_chain_mask[59:1]};
      end
   end

   always @(posedge edt_clock)
   begin : chain_mask_load_en_register
      if (lbist_reset_sync == 1'b1) begin
         edt_chain_mask_load_en <= 1'b1;
      end
      else if (lbist_scan_en == 1'b1) begin
         edt_chain_mask_load_en <= edt_chain_mask[0];
      end
   end

   assign ijtag_so_int = ccm_scan_en ? ijtag_so_masks_reg : edt_chain_mask_load_en;

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(ijtag_si),
      .ijtag_from_so(ijtag_so_int),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_si),
      .ccm_te_so(ccm_te_so),
      .ijtag_so(ijtag_so),
      .ijtag_to_sel(ijtag_to_sel));

   assign ccm_le_so = ijtag_so;

   assign effective_pp_masks_for_compactor_0 = lbist_en ? 30'b111111111111111111111111111111 : edt_pp_masks_for_compactor_0;
   assign effective_pp_masks_for_compactor_1 = lbist_en ? 30'b111111111111111111111111111111 : edt_pp_masks_for_compactor_1;

   assign ccm_compactor_mask_override = masks_hold_reg_0[0] & ccm_en;
   assign masks_for_compactor_0 = (edt_chain_mask[29: 0] & effective_pp_masks_for_compactor_0) | {30{ccm_compactor_mask_override}};
   assign masks_for_compactor_1 = (edt_chain_mask[59:30] & effective_pp_masks_for_compactor_1) | {30{ccm_compactor_mask_override}};
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_spatial_compactor_30_w_output_lockup (
   input  wire        edt_clock,
   input  wire [29:0] multi_bit_input,
   output reg         single_bit_output,
   output wire [29:0] lbist_misr_in,
   input  wire        ccm_scan_en,
   input  wire        ccm_te_si,
   output wire        ccm_te_so,
   input  wire        ccm_le_si,
   output wire        ccm_le_so
);
   reg    [14:0] level1;
   reg    [ 7:0] level2;
   reg    [ 3:0] level3;
   reg    [ 1:0] level4;
   reg           level5_pipelined;

   always @(multi_bit_input)
   begin : compact30_level1
      level1[ 0] = multi_bit_input[ 0] ^ multi_bit_input[ 1];
      level1[ 1] = multi_bit_input[ 2] ^ multi_bit_input[ 3];
      level1[ 2] = multi_bit_input[ 4] ^ multi_bit_input[ 5];
      level1[ 3] = multi_bit_input[ 6] ^ multi_bit_input[ 7];
      level1[ 4] = multi_bit_input[ 8] ^ multi_bit_input[ 9];
      level1[ 5] = multi_bit_input[10] ^ multi_bit_input[11];
      level1[ 6] = multi_bit_input[12] ^ multi_bit_input[13];
      level1[ 7] = multi_bit_input[14] ^ multi_bit_input[15];
      level1[ 8] = multi_bit_input[16] ^ multi_bit_input[17];
      level1[ 9] = multi_bit_input[18] ^ multi_bit_input[19];
      level1[10] = multi_bit_input[20] ^ multi_bit_input[21];
      level1[11] = multi_bit_input[22] ^ multi_bit_input[23];
      level1[12] = multi_bit_input[24] ^ multi_bit_input[25];
      level1[13] = multi_bit_input[26] ^ multi_bit_input[27];
      level1[14] = multi_bit_input[28] ^ multi_bit_input[29];
   end

   always @(level1)
   begin : compact30_level2
      level2[0] = level1[ 0] ^ level1[ 1];
      level2[1] = level1[ 2] ^ level1[ 3];
      level2[2] = level1[ 4] ^ level1[ 5];
      level2[3] = level1[ 6] ^ level1[ 7];
      level2[4] = level1[ 8] ^ level1[ 9];
      level2[5] = level1[10] ^ level1[11];
      level2[6] = level1[12] ^ level1[13];
      level2[7] = level1[14];
   end

   always @(level2)
   begin : compact30_level3
      level3[0] = level2[0] ^ level2[1];
      level3[1] = level2[2] ^ level2[3];
      level3[2] = level2[4] ^ level2[5];
      level3[3] = level2[6] ^ level2[7];
   end

   always @(level3)
   begin : compact30_level4
      level4[0] = level3[0] ^ level3[1];
      level4[1] = level3[2] ^ level3[3];
   end

   always @(posedge edt_clock)
   begin : compact30_level5_pipelined
      if (ccm_scan_en == 1'b1) begin
         level5_pipelined <= ccm_le_si;
      end
      else begin
         level5_pipelined <= level4[0] ^ level4[1];
      end
   end

   always @(negedge edt_clock)
   begin : compact30_level5_lockup
      if (ccm_scan_en == 1'b1) begin
         single_bit_output <= ccm_te_si;
      end
      else begin
         single_bit_output <= level5_pipelined;
      end
   end

   assign lbist_misr_in = multi_bit_input;
   assign ccm_le_so = level5_pipelined;
   assign ccm_te_so = single_bit_output;
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_compactor (
   input  wire        edt_clock,
   input  wire [59:0] edt_scan_out,
   input  wire [29:0] masks_for_compactor_0,
   input  wire [29:0] masks_for_compactor_1,
   output wire [ 1:0] edt_channels_out,
   output wire [59:0] lbist_misr_in,
   input  wire        ccm_scan_en,
   input  wire        ccm_te_si,
   output wire        ccm_te_so,
   input  wire        ccm_le_si,
   output wire        ccm_le_so
);
   wire   [29:0] masked_scan_outputs_0;
   wire   [29:0] masked_scan_outputs_1;
   wire         ccm_te_so_compactor1;
   wire         ccm_le_so_compactor1;
   wire         ccm_te_so_compactor2;
   wire         ccm_le_so_compactor2;

   assign masked_scan_outputs_0 = edt_scan_out[29: 0] & masks_for_compactor_0;
   assign masked_scan_outputs_1 = edt_scan_out[59:30] & masks_for_compactor_1;

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_spatial_compactor_30_w_output_lockup compactor1 (
      .edt_clock(edt_clock),
      .multi_bit_input(masked_scan_outputs_0),
      .single_bit_output(edt_channels_out[0]),
      .lbist_misr_in(lbist_misr_in[29:0]),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_si),
      .ccm_te_so(ccm_te_so_compactor1),
      .ccm_le_si(ccm_le_si),
      .ccm_le_so(ccm_le_so_compactor1));
   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_spatial_compactor_30_w_output_lockup compactor2 (
      .edt_clock(edt_clock),
      .multi_bit_input(masked_scan_outputs_1),
      .single_bit_output(edt_channels_out[1]),
      .lbist_misr_in(lbist_misr_in[59:30]),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_compactor1),
      .ccm_te_so(ccm_te_so_compactor2),
      .ccm_le_si(ccm_le_so_compactor1),
      .ccm_le_so(ccm_le_so_compactor2));

   assign ccm_le_so = ccm_le_so_compactor2;
   assign ccm_te_so = ccm_te_so_compactor2;
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_bypass_logic (
   input  wire        edt_bypass,
   input  wire        edt_single_bypass_chain,
   input  wire        lbist_en,
   input  wire        ccm_en,
   input  wire [ 1:0] edt_channels_in,
   output wire [ 1:0] edt_channels_out,
   output wire [59:0] edt_scan_in,
   input  wire [59:0] edt_scan_out,
   output wire [59:0] edt_scan_out_lockup,
   input  wire [59:0] edt_bypass_in,
   input  wire [ 1:0] edt_bypass_out
);
   reg    [59:0] edt_scan_out_lockup_int;
   wire        bypass_on;
   wire        single_bypass_chain_mux_0;
   wire        single_bypass_chain_mux_1;

   always @(edt_scan_out)
   begin 
      edt_scan_out_lockup_int[ 0] = edt_scan_out[ 0];
      edt_scan_out_lockup_int[ 1] = edt_scan_out[ 1];
      edt_scan_out_lockup_int[ 2] = edt_scan_out[ 2];
      edt_scan_out_lockup_int[ 3] = edt_scan_out[ 3];
      edt_scan_out_lockup_int[ 4] = edt_scan_out[ 4];
      edt_scan_out_lockup_int[ 5] = edt_scan_out[ 5];
      edt_scan_out_lockup_int[ 6] = edt_scan_out[ 6];
      edt_scan_out_lockup_int[ 7] = edt_scan_out[ 7];
      edt_scan_out_lockup_int[ 8] = edt_scan_out[ 8];
      edt_scan_out_lockup_int[ 9] = edt_scan_out[ 9];
      edt_scan_out_lockup_int[10] = edt_scan_out[10];
      edt_scan_out_lockup_int[11] = edt_scan_out[11];
      edt_scan_out_lockup_int[12] = edt_scan_out[12];
      edt_scan_out_lockup_int[13] = edt_scan_out[13];
      edt_scan_out_lockup_int[14] = edt_scan_out[14];
      edt_scan_out_lockup_int[15] = edt_scan_out[15];
      edt_scan_out_lockup_int[16] = edt_scan_out[16];
      edt_scan_out_lockup_int[17] = edt_scan_out[17];
      edt_scan_out_lockup_int[18] = edt_scan_out[18];
      edt_scan_out_lockup_int[19] = edt_scan_out[19];
      edt_scan_out_lockup_int[20] = edt_scan_out[20];
      edt_scan_out_lockup_int[21] = edt_scan_out[21];
      edt_scan_out_lockup_int[22] = edt_scan_out[22];
      edt_scan_out_lockup_int[23] = edt_scan_out[23];
      edt_scan_out_lockup_int[24] = edt_scan_out[24];
      edt_scan_out_lockup_int[25] = edt_scan_out[25];
      edt_scan_out_lockup_int[26] = edt_scan_out[26];
      edt_scan_out_lockup_int[27] = edt_scan_out[27];
      edt_scan_out_lockup_int[28] = edt_scan_out[28];
      edt_scan_out_lockup_int[29] = edt_scan_out[29];
      edt_scan_out_lockup_int[30] = edt_scan_out[30];
      edt_scan_out_lockup_int[31] = edt_scan_out[31];
      edt_scan_out_lockup_int[32] = edt_scan_out[32];
      edt_scan_out_lockup_int[33] = edt_scan_out[33];
      edt_scan_out_lockup_int[34] = edt_scan_out[34];
      edt_scan_out_lockup_int[35] = edt_scan_out[35];
      edt_scan_out_lockup_int[36] = edt_scan_out[36];
      edt_scan_out_lockup_int[37] = edt_scan_out[37];
      edt_scan_out_lockup_int[38] = edt_scan_out[38];
      edt_scan_out_lockup_int[39] = edt_scan_out[39];
      edt_scan_out_lockup_int[40] = edt_scan_out[40];
      edt_scan_out_lockup_int[41] = edt_scan_out[41];
      edt_scan_out_lockup_int[42] = edt_scan_out[42];
      edt_scan_out_lockup_int[43] = edt_scan_out[43];
      edt_scan_out_lockup_int[44] = edt_scan_out[44];
      edt_scan_out_lockup_int[45] = edt_scan_out[45];
      edt_scan_out_lockup_int[46] = edt_scan_out[46];
      edt_scan_out_lockup_int[47] = edt_scan_out[47];
      edt_scan_out_lockup_int[48] = edt_scan_out[48];
      edt_scan_out_lockup_int[49] = edt_scan_out[49];
      edt_scan_out_lockup_int[50] = edt_scan_out[50];
      edt_scan_out_lockup_int[51] = edt_scan_out[51];
      edt_scan_out_lockup_int[52] = edt_scan_out[52];
      edt_scan_out_lockup_int[53] = edt_scan_out[53];
      edt_scan_out_lockup_int[54] = edt_scan_out[54];
      edt_scan_out_lockup_int[55] = edt_scan_out[55];
      edt_scan_out_lockup_int[56] = edt_scan_out[56];
      edt_scan_out_lockup_int[57] = edt_scan_out[57];
      edt_scan_out_lockup_int[58] = edt_scan_out[58];
      edt_scan_out_lockup_int[59] = edt_scan_out[59];
   end

   assign bypass_on = lbist_en ? edt_single_bypass_chain : (edt_bypass | edt_single_bypass_chain);

   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_0 (
      .A(edt_bypass_in[0]),
      .B(edt_channels_in[0]),
      .S(bypass_on),
      .Z(edt_scan_in[0]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_1 (
      .A(edt_bypass_in[1]),
      .B(edt_scan_out_lockup_int[0]),
      .S(bypass_on),
      .Z(edt_scan_in[1]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_2 (
      .A(edt_bypass_in[2]),
      .B(edt_scan_out_lockup_int[1]),
      .S(bypass_on),
      .Z(edt_scan_in[2]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_3 (
      .A(edt_bypass_in[3]),
      .B(edt_scan_out_lockup_int[2]),
      .S(bypass_on),
      .Z(edt_scan_in[3]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_4 (
      .A(edt_bypass_in[4]),
      .B(edt_scan_out_lockup_int[3]),
      .S(bypass_on),
      .Z(edt_scan_in[4]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_5 (
      .A(edt_bypass_in[5]),
      .B(edt_scan_out_lockup_int[4]),
      .S(bypass_on),
      .Z(edt_scan_in[5]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_6 (
      .A(edt_bypass_in[6]),
      .B(edt_scan_out_lockup_int[5]),
      .S(bypass_on),
      .Z(edt_scan_in[6]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_7 (
      .A(edt_bypass_in[7]),
      .B(edt_scan_out_lockup_int[6]),
      .S(bypass_on),
      .Z(edt_scan_in[7]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_8 (
      .A(edt_bypass_in[8]),
      .B(edt_scan_out_lockup_int[7]),
      .S(bypass_on),
      .Z(edt_scan_in[8]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_9 (
      .A(edt_bypass_in[9]),
      .B(edt_scan_out_lockup_int[8]),
      .S(bypass_on),
      .Z(edt_scan_in[9]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_10 (
      .A(edt_bypass_in[10]),
      .B(edt_scan_out_lockup_int[9]),
      .S(bypass_on),
      .Z(edt_scan_in[10]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_11 (
      .A(edt_bypass_in[11]),
      .B(edt_scan_out_lockup_int[10]),
      .S(bypass_on),
      .Z(edt_scan_in[11]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_12 (
      .A(edt_bypass_in[12]),
      .B(edt_scan_out_lockup_int[11]),
      .S(bypass_on),
      .Z(edt_scan_in[12]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_13 (
      .A(edt_bypass_in[13]),
      .B(edt_scan_out_lockup_int[12]),
      .S(bypass_on),
      .Z(edt_scan_in[13]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_14 (
      .A(edt_bypass_in[14]),
      .B(edt_scan_out_lockup_int[13]),
      .S(bypass_on),
      .Z(edt_scan_in[14]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_15 (
      .A(edt_bypass_in[15]),
      .B(edt_scan_out_lockup_int[14]),
      .S(bypass_on),
      .Z(edt_scan_in[15]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_16 (
      .A(edt_bypass_in[16]),
      .B(edt_scan_out_lockup_int[15]),
      .S(bypass_on),
      .Z(edt_scan_in[16]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_17 (
      .A(edt_bypass_in[17]),
      .B(edt_scan_out_lockup_int[16]),
      .S(bypass_on),
      .Z(edt_scan_in[17]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_18 (
      .A(edt_bypass_in[18]),
      .B(edt_scan_out_lockup_int[17]),
      .S(bypass_on),
      .Z(edt_scan_in[18]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_19 (
      .A(edt_bypass_in[19]),
      .B(edt_scan_out_lockup_int[18]),
      .S(bypass_on),
      .Z(edt_scan_in[19]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_20 (
      .A(edt_bypass_in[20]),
      .B(edt_scan_out_lockup_int[19]),
      .S(bypass_on),
      .Z(edt_scan_in[20]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_21 (
      .A(edt_bypass_in[21]),
      .B(edt_scan_out_lockup_int[20]),
      .S(bypass_on),
      .Z(edt_scan_in[21]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_22 (
      .A(edt_bypass_in[22]),
      .B(edt_scan_out_lockup_int[21]),
      .S(bypass_on),
      .Z(edt_scan_in[22]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_23 (
      .A(edt_bypass_in[23]),
      .B(edt_scan_out_lockup_int[22]),
      .S(bypass_on),
      .Z(edt_scan_in[23]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_24 (
      .A(edt_bypass_in[24]),
      .B(edt_scan_out_lockup_int[23]),
      .S(bypass_on),
      .Z(edt_scan_in[24]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_25 (
      .A(edt_bypass_in[25]),
      .B(edt_scan_out_lockup_int[24]),
      .S(bypass_on),
      .Z(edt_scan_in[25]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_26 (
      .A(edt_bypass_in[26]),
      .B(edt_scan_out_lockup_int[25]),
      .S(bypass_on),
      .Z(edt_scan_in[26]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_27 (
      .A(edt_bypass_in[27]),
      .B(edt_scan_out_lockup_int[26]),
      .S(bypass_on),
      .Z(edt_scan_in[27]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_28 (
      .A(edt_bypass_in[28]),
      .B(edt_scan_out_lockup_int[27]),
      .S(bypass_on),
      .Z(edt_scan_in[28]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_29 (
      .A(edt_bypass_in[29]),
      .B(edt_scan_out_lockup_int[28]),
      .S(bypass_on),
      .Z(edt_scan_in[29]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_30 (
      .A(edt_bypass_in[30]),
      .B(single_bypass_chain_mux_0),
      .S(bypass_on),
      .Z(edt_scan_in[30]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_31 (
      .A(edt_bypass_in[31]),
      .B(edt_scan_out_lockup_int[30]),
      .S(bypass_on),
      .Z(edt_scan_in[31]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_32 (
      .A(edt_bypass_in[32]),
      .B(edt_scan_out_lockup_int[31]),
      .S(bypass_on),
      .Z(edt_scan_in[32]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_33 (
      .A(edt_bypass_in[33]),
      .B(edt_scan_out_lockup_int[32]),
      .S(bypass_on),
      .Z(edt_scan_in[33]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_34 (
      .A(edt_bypass_in[34]),
      .B(edt_scan_out_lockup_int[33]),
      .S(bypass_on),
      .Z(edt_scan_in[34]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_35 (
      .A(edt_bypass_in[35]),
      .B(edt_scan_out_lockup_int[34]),
      .S(bypass_on),
      .Z(edt_scan_in[35]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_36 (
      .A(edt_bypass_in[36]),
      .B(edt_scan_out_lockup_int[35]),
      .S(bypass_on),
      .Z(edt_scan_in[36]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_37 (
      .A(edt_bypass_in[37]),
      .B(edt_scan_out_lockup_int[36]),
      .S(bypass_on),
      .Z(edt_scan_in[37]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_38 (
      .A(edt_bypass_in[38]),
      .B(edt_scan_out_lockup_int[37]),
      .S(bypass_on),
      .Z(edt_scan_in[38]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_39 (
      .A(edt_bypass_in[39]),
      .B(edt_scan_out_lockup_int[38]),
      .S(bypass_on),
      .Z(edt_scan_in[39]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_40 (
      .A(edt_bypass_in[40]),
      .B(edt_scan_out_lockup_int[39]),
      .S(bypass_on),
      .Z(edt_scan_in[40]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_41 (
      .A(edt_bypass_in[41]),
      .B(edt_scan_out_lockup_int[40]),
      .S(bypass_on),
      .Z(edt_scan_in[41]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_42 (
      .A(edt_bypass_in[42]),
      .B(edt_scan_out_lockup_int[41]),
      .S(bypass_on),
      .Z(edt_scan_in[42]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_43 (
      .A(edt_bypass_in[43]),
      .B(edt_scan_out_lockup_int[42]),
      .S(bypass_on),
      .Z(edt_scan_in[43]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_44 (
      .A(edt_bypass_in[44]),
      .B(edt_scan_out_lockup_int[43]),
      .S(bypass_on),
      .Z(edt_scan_in[44]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_45 (
      .A(edt_bypass_in[45]),
      .B(edt_scan_out_lockup_int[44]),
      .S(bypass_on),
      .Z(edt_scan_in[45]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_46 (
      .A(edt_bypass_in[46]),
      .B(edt_scan_out_lockup_int[45]),
      .S(bypass_on),
      .Z(edt_scan_in[46]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_47 (
      .A(edt_bypass_in[47]),
      .B(edt_scan_out_lockup_int[46]),
      .S(bypass_on),
      .Z(edt_scan_in[47]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_48 (
      .A(edt_bypass_in[48]),
      .B(edt_scan_out_lockup_int[47]),
      .S(bypass_on),
      .Z(edt_scan_in[48]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_49 (
      .A(edt_bypass_in[49]),
      .B(edt_scan_out_lockup_int[48]),
      .S(bypass_on),
      .Z(edt_scan_in[49]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_50 (
      .A(edt_bypass_in[50]),
      .B(edt_scan_out_lockup_int[49]),
      .S(bypass_on),
      .Z(edt_scan_in[50]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_51 (
      .A(edt_bypass_in[51]),
      .B(edt_scan_out_lockup_int[50]),
      .S(bypass_on),
      .Z(edt_scan_in[51]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_52 (
      .A(edt_bypass_in[52]),
      .B(edt_scan_out_lockup_int[51]),
      .S(bypass_on),
      .Z(edt_scan_in[52]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_53 (
      .A(edt_bypass_in[53]),
      .B(edt_scan_out_lockup_int[52]),
      .S(bypass_on),
      .Z(edt_scan_in[53]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_54 (
      .A(edt_bypass_in[54]),
      .B(edt_scan_out_lockup_int[53]),
      .S(bypass_on),
      .Z(edt_scan_in[54]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_55 (
      .A(edt_bypass_in[55]),
      .B(edt_scan_out_lockup_int[54]),
      .S(bypass_on),
      .Z(edt_scan_in[55]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_56 (
      .A(edt_bypass_in[56]),
      .B(edt_scan_out_lockup_int[55]),
      .S(bypass_on),
      .Z(edt_scan_in[56]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_57 (
      .A(edt_bypass_in[57]),
      .B(edt_scan_out_lockup_int[56]),
      .S(bypass_on),
      .Z(edt_scan_in[57]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_58 (
      .A(edt_bypass_in[58]),
      .B(edt_scan_out_lockup_int[57]),
      .S(bypass_on),
      .Z(edt_scan_in[58]));
   MUX2_X2 tessent_persistent_cell_edt_scan_in_mux_59 (
      .A(edt_bypass_in[59]),
      .B(edt_scan_out_lockup_int[58]),
      .S(bypass_on),
      .Z(edt_scan_in[59]));
   MUX2_X2 tessent_persistent_cell_single_bypass_chain_mux_0 (
      .A(edt_channels_in[1]),
      .B(edt_scan_out_lockup_int[29]),
      .S(edt_single_bypass_chain),
      .Z(single_bypass_chain_mux_0));
   MUX2_X2 tessent_persistent_cell_single_bypass_chain_mux_1 (
      .A(edt_scan_out_lockup_int[29]),
      .B(edt_scan_out_lockup_int[59]),
      .S(edt_single_bypass_chain),
      .Z(single_bypass_chain_mux_1));

   MUX2_X2 tessent_persistent_cell_edt_channels_out_mux_0 (
      .A(edt_bypass_out[0]),
      .B(single_bypass_chain_mux_1),
      .S(bypass_on),
      .Z(edt_channels_out[0]));
   MUX2_X2 tessent_persistent_cell_edt_channels_out_mux_1 (
      .A(edt_bypass_out[1]),
      .B(edt_scan_out_lockup_int[59]),
      .S(bypass_on),
      .Z(edt_channels_out[1]));

   assign edt_scan_out_lockup = ccm_en ? edt_scan_in : edt_scan_out_lockup_int;
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_misr_reg (
   input  wire        edt_clock,
   input  wire        clear,
   input  wire        scan_en,
   input  wire        scan_in,
   input  wire        ccm_scan_en,
   input  wire        ccm_le_si,
   output wire        ccm_le_so,
   input  wire [31:0] new_misr_0,
   input  wire [31:0] new_misr_1,
   output reg  [31:0] misr_0,
   output reg  [31:0] misr_1
);
   wire        scan_in_int;

   assign scan_in_int = ccm_scan_en ? ccm_le_si : scan_in;

   // synopsys sync_set_reset clear
   always @(posedge edt_clock)
   begin 
      if (clear == 1'b1) begin
         misr_1 <= 32'b00000000000000000000000000000000;
         misr_0 <= 32'b00000000000000000000000000000000;
      end
      else begin
         if (scan_en == 1'b1) begin
            misr_1 <= {scan_in_int, misr_1[31:1]};
            misr_0 <= {misr_1[0], misr_0[31:1]};
         end
         else begin
            misr_1 <= new_misr_1;
            misr_0 <= new_misr_0;
         end
      end
   end

   assign ccm_le_so = misr_0[0];
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_misr (
   input  wire        edt_clock,
   input  wire        lbist_reset,
   input  wire        ccm_scan_en,
   input  wire        ccm_le_si,
   output wire        ccm_le_so,
   input  wire        ccm_te_si,
   output wire        ccm_te_so,
   input  wire        accumulate,
   input  wire [59:0] misr_in,
   input  wire        ijtag_tck,
   input  wire        ijtag_reset,
   input  wire        ijtag_sel,
   input  wire        ijtag_ce,
   input  wire        ijtag_se,
   input  wire        ijtag_ue,
   input  wire        ijtag_si,
   output wire        ijtag_so
);
   wire          lbist_scan_en_int;
   wire          ijtag_to_sel;
   reg    [31:0] new_misr_0;
   reg    [31:0] new_misr_1;
   wire   [31:0] misr_0;
   wire   [31:0] misr_1;
   wire   [63:0] misr_d;
   wire   [63:0] misr;
   wire          clear;
   wire          ccm_le_so_misr_reg_int;
   wire          ijtag_from_so_int;

   assign lbist_scan_en_int = ccm_scan_en | (ijtag_to_sel & ijtag_se);
   assign misr_d = {4'd0, misr_in};
   assign clear = lbist_reset & ~lbist_scan_en_int;

   always @(accumulate or misr_d or misr_0)
   begin 
      if (accumulate == 1'b1) begin
         new_misr_0[0] = misr_d[0] ^ misr_0[1];
         new_misr_0[1] = misr_d[1] ^ misr_0[2];
         new_misr_0[2] = misr_d[2] ^ misr_0[3];
         new_misr_0[3] = misr_d[3] ^ misr_0[4] ^ misr_0[0];
         new_misr_0[4] = misr_d[4] ^ misr_0[5] ^ misr_0[0];
         new_misr_0[5] = misr_d[5] ^ misr_0[6];
         new_misr_0[6] = misr_d[6] ^ misr_0[7];
         new_misr_0[7] = misr_d[7] ^ misr_0[8];
         new_misr_0[8] = misr_d[8] ^ misr_0[9];
         new_misr_0[9] = misr_d[9] ^ misr_0[10];
         new_misr_0[10] = misr_d[10] ^ misr_0[11];
         new_misr_0[11] = misr_d[11] ^ misr_0[12];
         new_misr_0[12] = misr_d[12] ^ misr_0[13];
         new_misr_0[13] = misr_d[13] ^ misr_0[14];
         new_misr_0[14] = misr_d[14] ^ misr_0[15];
         new_misr_0[15] = misr_d[15] ^ misr_0[16];
         new_misr_0[16] = misr_d[16] ^ misr_0[17];
         new_misr_0[17] = misr_d[17] ^ misr_0[18];
         new_misr_0[18] = misr_d[18] ^ misr_0[19];
         new_misr_0[19] = misr_d[19] ^ misr_0[20];
         new_misr_0[20] = misr_d[20] ^ misr_0[21];
         new_misr_0[21] = misr_d[21] ^ misr_0[22];
         new_misr_0[22] = misr_d[22] ^ misr_0[23];
         new_misr_0[23] = misr_d[23] ^ misr_0[24];
         new_misr_0[24] = misr_d[24] ^ misr_0[25];
         new_misr_0[25] = misr_d[25] ^ misr_0[26];
         new_misr_0[26] = misr_d[26] ^ misr_0[27];
         new_misr_0[27] = misr_d[27] ^ misr_0[28];
         new_misr_0[28] = misr_d[28] ^ misr_0[29];
         new_misr_0[29] = misr_d[29] ^ misr_0[30];
         new_misr_0[30] = misr_d[30] ^ misr_0[31] ^ misr_0[0];
         new_misr_0[31] = misr_d[31] ^ misr_0[0];
      end
      else begin
         new_misr_0 = misr_0;
      end
   end

   always @(accumulate or misr_d or misr_1)
   begin 
      if (accumulate == 1'b1) begin
         new_misr_1[0] = misr_d[32] ^ misr_1[1];
         new_misr_1[1] = misr_d[33] ^ misr_1[2];
         new_misr_1[2] = misr_d[34] ^ misr_1[3];
         new_misr_1[3] = misr_d[35] ^ misr_1[4] ^ misr_1[0];
         new_misr_1[4] = misr_d[36] ^ misr_1[5] ^ misr_1[0];
         new_misr_1[5] = misr_d[37] ^ misr_1[6];
         new_misr_1[6] = misr_d[38] ^ misr_1[7];
         new_misr_1[7] = misr_d[39] ^ misr_1[8];
         new_misr_1[8] = misr_d[40] ^ misr_1[9];
         new_misr_1[9] = misr_d[41] ^ misr_1[10];
         new_misr_1[10] = misr_d[42] ^ misr_1[11];
         new_misr_1[11] = misr_d[43] ^ misr_1[12];
         new_misr_1[12] = misr_d[44] ^ misr_1[13];
         new_misr_1[13] = misr_d[45] ^ misr_1[14];
         new_misr_1[14] = misr_d[46] ^ misr_1[15];
         new_misr_1[15] = misr_d[47] ^ misr_1[16];
         new_misr_1[16] = misr_d[48] ^ misr_1[17];
         new_misr_1[17] = misr_d[49] ^ misr_1[18];
         new_misr_1[18] = misr_d[50] ^ misr_1[19];
         new_misr_1[19] = misr_d[51] ^ misr_1[20];
         new_misr_1[20] = misr_d[52] ^ misr_1[21];
         new_misr_1[21] = misr_d[53] ^ misr_1[22];
         new_misr_1[22] = misr_d[54] ^ misr_1[23];
         new_misr_1[23] = misr_d[55] ^ misr_1[24];
         new_misr_1[24] = misr_d[56] ^ misr_1[25];
         new_misr_1[25] = misr_d[57] ^ misr_1[26];
         new_misr_1[26] = misr_d[58] ^ misr_1[27];
         new_misr_1[27] = misr_d[59] ^ misr_1[28];
         new_misr_1[28] = misr_d[60] ^ misr_1[29];
         new_misr_1[29] = misr_d[61] ^ misr_1[30];
         new_misr_1[30] = misr_d[62] ^ misr_1[31] ^ misr_1[0];
         new_misr_1[31] = misr_d[63] ^ misr_1[0];
      end
      else begin
         new_misr_1 = misr_1;
      end
   end

   assign misr = {misr_1, misr_0};

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_misr_reg msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_misr_reg_i (
      .edt_clock(edt_clock),
      .clear(clear),
      .scan_en(lbist_scan_en_int),
      .scan_in(ijtag_si),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ccm_le_si),
      .ccm_le_so(ccm_le_so_misr_reg_int),
      .new_misr_0(new_misr_0),
      .new_misr_1(new_misr_1),
      .misr_0(misr_0),
      .misr_1(misr_1));

   assign ijtag_from_so_int = ccm_scan_en ? ccm_le_so_misr_reg_int : misr[0];

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_i (
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel),
      .ijtag_ce(ijtag_ce),
      .ijtag_se(ijtag_se),
      .ijtag_ue(ijtag_ue),
      .ijtag_si(ijtag_si),
      .ijtag_from_so(ijtag_from_so_int),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_si),
      .ccm_te_so(ccm_te_so),
      .ijtag_so(ijtag_so),
      .ijtag_to_sel(ijtag_to_sel));

   assign ccm_le_so = ijtag_so;
endmodule


module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1 (
   input  wire        edt_clock,
   input  wire        edt_update,
   input  wire        edt_bypass,
   input  wire        edt_single_bypass_chain,
   input  wire [ 1:0] edt_channels_in,
   output wire [ 1:0] edt_channels_out,
   output wire [59:0] edt_scan_in,
   input  wire [59:0] edt_scan_out,
   input  wire        lbist_reset,
   input  wire        lbist_en,
   input  wire        lbist_prpg_en,
   input  wire        misr_accumulate_en,
   input  wire        lbist_low_power_shift_en,
   input  wire        ijtag_tck,
   input  wire        ijtag_reset,
   input  wire        ijtag_sel,
   input  wire        ijtag_ce,
   input  wire        ijtag_se,
   input  wire        ijtag_ue,
   input  wire        ccm_en,
   input  wire        ccm_scan_in,
   output wire        ccm_scan_out,
   input  wire        scan_en,
   input  wire        ijtag_si,
   output wire        ijtag_so
);
   wire   [59:0] edt_bypass_in;
   wire   [ 1:0] edt_bypass_out;
   wire   [59:0] edt_scan_out_lockup;
   wire   [29:0] masks_for_compactor_0;
   wire   [29:0] masks_for_compactor_1;
   wire   [ 1:0] edt_channels_out_from_controller;
   wire          ijtag_so_decompressor;
   wire          ijtag_so_controller;
   wire          ijtag_so_misr;
   wire   [59:0] lbist_misr_in;
   wire          ccm_scan_en;
   wire   [59:0] edt_chain_mask;
   wire          edt_chain_mask_load_en;
   wire          edt_update_lbist_disabled;
   reg    [ 2:0] ijtag_ccm_tdr;
   wire          ijtag_sel_ccm;
   wire          ijtag_ce_ccm;
   wire          ijtag_se_ccm;
   wire          ijtag_ue_ccm;
   wire          ccm_te_so_decompressor;
   wire          ccm_le_so_decompressor;
   wire          ccm_te_so_compactor;
   wire          ccm_le_so_compactor;
   wire          ccm_te_so_controller;
   wire          ccm_le_so_controller;
   wire          ccm_te_so_misr;
   wire          ccm_le_so_misr;
   reg           ccm_te_si_lockup;
   wire          edt_update_ccm;
   wire          edt_bypass_ccm;
   wire          edt_single_bypass_chain_ccm;
   wire   [ 2:0] ccm_edt_override;
   wire          edt_clock_buf_out;
   wire          edt_update_buf_out;
   wire          edt_bypass_buf_out;
   wire          edt_single_bypass_chain_buf_out;
   wire   [ 1:0] edt_channels_in_buf_out;
   wire   [ 1:0] edt_channels_out_buf_in;
   wire   [59:0] edt_bypass_in_buf_out;
   wire   [59:0] edt_scan_out_lockup_buf_out;
   wire          ccm_en_buf_out;

   CLKBUF_X3 tessent_persistent_cell_edt_clock_buf (.A(edt_clock),
                                                    .Z(edt_clock_buf_out));
   BUF_X1 tessent_persistent_cell_edt_update_buf (.A(edt_update),
                                                  .Z(edt_update_buf_out));
   BUF_X1 tessent_persistent_cell_edt_bypass_buf (.A(edt_bypass),
                                                  .Z(edt_bypass_buf_out));
   BUF_X1 tessent_persistent_cell_edt_single_bypass_chain_buf (.A(edt_single_bypass_chain),
                                                               .Z(edt_single_bypass_chain_buf_out));

   BUF_X1 tessent_persistent_cell_edt_channels_in_0_buf (.A(edt_channels_in[0]),
                                                         .Z(edt_channels_in_buf_out[0]));
   BUF_X1 tessent_persistent_cell_edt_channels_in_1_buf (.A(edt_channels_in[1]),
                                                         .Z(edt_channels_in_buf_out[1]));

   BUF_X1 tessent_persistent_cell_edt_channels_out_0_buf (.A(edt_channels_out_buf_in[0]),
                                                          .Z(edt_channels_out[0]));
   BUF_X1 tessent_persistent_cell_edt_channels_out_1_buf (.A(edt_channels_out_buf_in[1]),
                                                          .Z(edt_channels_out[1]));

   BUF_X1 tessent_persistent_cell_edt_scan_in_0_buf (.A(edt_bypass_in[0]),
                                                     .Z(edt_bypass_in_buf_out[0]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_1_buf (.A(edt_bypass_in[1]),
                                                     .Z(edt_bypass_in_buf_out[1]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_2_buf (.A(edt_bypass_in[2]),
                                                     .Z(edt_bypass_in_buf_out[2]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_3_buf (.A(edt_bypass_in[3]),
                                                     .Z(edt_bypass_in_buf_out[3]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_4_buf (.A(edt_bypass_in[4]),
                                                     .Z(edt_bypass_in_buf_out[4]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_5_buf (.A(edt_bypass_in[5]),
                                                     .Z(edt_bypass_in_buf_out[5]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_6_buf (.A(edt_bypass_in[6]),
                                                     .Z(edt_bypass_in_buf_out[6]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_7_buf (.A(edt_bypass_in[7]),
                                                     .Z(edt_bypass_in_buf_out[7]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_8_buf (.A(edt_bypass_in[8]),
                                                     .Z(edt_bypass_in_buf_out[8]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_9_buf (.A(edt_bypass_in[9]),
                                                     .Z(edt_bypass_in_buf_out[9]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_10_buf (.A(edt_bypass_in[10]),
                                                      .Z(edt_bypass_in_buf_out[10]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_11_buf (.A(edt_bypass_in[11]),
                                                      .Z(edt_bypass_in_buf_out[11]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_12_buf (.A(edt_bypass_in[12]),
                                                      .Z(edt_bypass_in_buf_out[12]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_13_buf (.A(edt_bypass_in[13]),
                                                      .Z(edt_bypass_in_buf_out[13]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_14_buf (.A(edt_bypass_in[14]),
                                                      .Z(edt_bypass_in_buf_out[14]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_15_buf (.A(edt_bypass_in[15]),
                                                      .Z(edt_bypass_in_buf_out[15]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_16_buf (.A(edt_bypass_in[16]),
                                                      .Z(edt_bypass_in_buf_out[16]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_17_buf (.A(edt_bypass_in[17]),
                                                      .Z(edt_bypass_in_buf_out[17]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_18_buf (.A(edt_bypass_in[18]),
                                                      .Z(edt_bypass_in_buf_out[18]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_19_buf (.A(edt_bypass_in[19]),
                                                      .Z(edt_bypass_in_buf_out[19]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_20_buf (.A(edt_bypass_in[20]),
                                                      .Z(edt_bypass_in_buf_out[20]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_21_buf (.A(edt_bypass_in[21]),
                                                      .Z(edt_bypass_in_buf_out[21]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_22_buf (.A(edt_bypass_in[22]),
                                                      .Z(edt_bypass_in_buf_out[22]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_23_buf (.A(edt_bypass_in[23]),
                                                      .Z(edt_bypass_in_buf_out[23]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_24_buf (.A(edt_bypass_in[24]),
                                                      .Z(edt_bypass_in_buf_out[24]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_25_buf (.A(edt_bypass_in[25]),
                                                      .Z(edt_bypass_in_buf_out[25]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_26_buf (.A(edt_bypass_in[26]),
                                                      .Z(edt_bypass_in_buf_out[26]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_27_buf (.A(edt_bypass_in[27]),
                                                      .Z(edt_bypass_in_buf_out[27]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_28_buf (.A(edt_bypass_in[28]),
                                                      .Z(edt_bypass_in_buf_out[28]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_29_buf (.A(edt_bypass_in[29]),
                                                      .Z(edt_bypass_in_buf_out[29]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_30_buf (.A(edt_bypass_in[30]),
                                                      .Z(edt_bypass_in_buf_out[30]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_31_buf (.A(edt_bypass_in[31]),
                                                      .Z(edt_bypass_in_buf_out[31]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_32_buf (.A(edt_bypass_in[32]),
                                                      .Z(edt_bypass_in_buf_out[32]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_33_buf (.A(edt_bypass_in[33]),
                                                      .Z(edt_bypass_in_buf_out[33]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_34_buf (.A(edt_bypass_in[34]),
                                                      .Z(edt_bypass_in_buf_out[34]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_35_buf (.A(edt_bypass_in[35]),
                                                      .Z(edt_bypass_in_buf_out[35]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_36_buf (.A(edt_bypass_in[36]),
                                                      .Z(edt_bypass_in_buf_out[36]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_37_buf (.A(edt_bypass_in[37]),
                                                      .Z(edt_bypass_in_buf_out[37]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_38_buf (.A(edt_bypass_in[38]),
                                                      .Z(edt_bypass_in_buf_out[38]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_39_buf (.A(edt_bypass_in[39]),
                                                      .Z(edt_bypass_in_buf_out[39]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_40_buf (.A(edt_bypass_in[40]),
                                                      .Z(edt_bypass_in_buf_out[40]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_41_buf (.A(edt_bypass_in[41]),
                                                      .Z(edt_bypass_in_buf_out[41]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_42_buf (.A(edt_bypass_in[42]),
                                                      .Z(edt_bypass_in_buf_out[42]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_43_buf (.A(edt_bypass_in[43]),
                                                      .Z(edt_bypass_in_buf_out[43]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_44_buf (.A(edt_bypass_in[44]),
                                                      .Z(edt_bypass_in_buf_out[44]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_45_buf (.A(edt_bypass_in[45]),
                                                      .Z(edt_bypass_in_buf_out[45]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_46_buf (.A(edt_bypass_in[46]),
                                                      .Z(edt_bypass_in_buf_out[46]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_47_buf (.A(edt_bypass_in[47]),
                                                      .Z(edt_bypass_in_buf_out[47]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_48_buf (.A(edt_bypass_in[48]),
                                                      .Z(edt_bypass_in_buf_out[48]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_49_buf (.A(edt_bypass_in[49]),
                                                      .Z(edt_bypass_in_buf_out[49]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_50_buf (.A(edt_bypass_in[50]),
                                                      .Z(edt_bypass_in_buf_out[50]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_51_buf (.A(edt_bypass_in[51]),
                                                      .Z(edt_bypass_in_buf_out[51]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_52_buf (.A(edt_bypass_in[52]),
                                                      .Z(edt_bypass_in_buf_out[52]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_53_buf (.A(edt_bypass_in[53]),
                                                      .Z(edt_bypass_in_buf_out[53]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_54_buf (.A(edt_bypass_in[54]),
                                                      .Z(edt_bypass_in_buf_out[54]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_55_buf (.A(edt_bypass_in[55]),
                                                      .Z(edt_bypass_in_buf_out[55]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_56_buf (.A(edt_bypass_in[56]),
                                                      .Z(edt_bypass_in_buf_out[56]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_57_buf (.A(edt_bypass_in[57]),
                                                      .Z(edt_bypass_in_buf_out[57]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_58_buf (.A(edt_bypass_in[58]),
                                                      .Z(edt_bypass_in_buf_out[58]));
   BUF_X1 tessent_persistent_cell_edt_scan_in_59_buf (.A(edt_bypass_in[59]),
                                                      .Z(edt_bypass_in_buf_out[59]));

   BUF_X1 tessent_persistent_cell_edt_scan_out_0_buf (.A(edt_scan_out_lockup[0]),
                                                      .Z(edt_scan_out_lockup_buf_out[0]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_1_buf (.A(edt_scan_out_lockup[1]),
                                                      .Z(edt_scan_out_lockup_buf_out[1]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_2_buf (.A(edt_scan_out_lockup[2]),
                                                      .Z(edt_scan_out_lockup_buf_out[2]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_3_buf (.A(edt_scan_out_lockup[3]),
                                                      .Z(edt_scan_out_lockup_buf_out[3]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_4_buf (.A(edt_scan_out_lockup[4]),
                                                      .Z(edt_scan_out_lockup_buf_out[4]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_5_buf (.A(edt_scan_out_lockup[5]),
                                                      .Z(edt_scan_out_lockup_buf_out[5]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_6_buf (.A(edt_scan_out_lockup[6]),
                                                      .Z(edt_scan_out_lockup_buf_out[6]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_7_buf (.A(edt_scan_out_lockup[7]),
                                                      .Z(edt_scan_out_lockup_buf_out[7]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_8_buf (.A(edt_scan_out_lockup[8]),
                                                      .Z(edt_scan_out_lockup_buf_out[8]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_9_buf (.A(edt_scan_out_lockup[9]),
                                                      .Z(edt_scan_out_lockup_buf_out[9]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_10_buf (.A(edt_scan_out_lockup[10]),
                                                       .Z(edt_scan_out_lockup_buf_out[10]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_11_buf (.A(edt_scan_out_lockup[11]),
                                                       .Z(edt_scan_out_lockup_buf_out[11]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_12_buf (.A(edt_scan_out_lockup[12]),
                                                       .Z(edt_scan_out_lockup_buf_out[12]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_13_buf (.A(edt_scan_out_lockup[13]),
                                                       .Z(edt_scan_out_lockup_buf_out[13]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_14_buf (.A(edt_scan_out_lockup[14]),
                                                       .Z(edt_scan_out_lockup_buf_out[14]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_15_buf (.A(edt_scan_out_lockup[15]),
                                                       .Z(edt_scan_out_lockup_buf_out[15]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_16_buf (.A(edt_scan_out_lockup[16]),
                                                       .Z(edt_scan_out_lockup_buf_out[16]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_17_buf (.A(edt_scan_out_lockup[17]),
                                                       .Z(edt_scan_out_lockup_buf_out[17]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_18_buf (.A(edt_scan_out_lockup[18]),
                                                       .Z(edt_scan_out_lockup_buf_out[18]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_19_buf (.A(edt_scan_out_lockup[19]),
                                                       .Z(edt_scan_out_lockup_buf_out[19]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_20_buf (.A(edt_scan_out_lockup[20]),
                                                       .Z(edt_scan_out_lockup_buf_out[20]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_21_buf (.A(edt_scan_out_lockup[21]),
                                                       .Z(edt_scan_out_lockup_buf_out[21]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_22_buf (.A(edt_scan_out_lockup[22]),
                                                       .Z(edt_scan_out_lockup_buf_out[22]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_23_buf (.A(edt_scan_out_lockup[23]),
                                                       .Z(edt_scan_out_lockup_buf_out[23]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_24_buf (.A(edt_scan_out_lockup[24]),
                                                       .Z(edt_scan_out_lockup_buf_out[24]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_25_buf (.A(edt_scan_out_lockup[25]),
                                                       .Z(edt_scan_out_lockup_buf_out[25]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_26_buf (.A(edt_scan_out_lockup[26]),
                                                       .Z(edt_scan_out_lockup_buf_out[26]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_27_buf (.A(edt_scan_out_lockup[27]),
                                                       .Z(edt_scan_out_lockup_buf_out[27]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_28_buf (.A(edt_scan_out_lockup[28]),
                                                       .Z(edt_scan_out_lockup_buf_out[28]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_29_buf (.A(edt_scan_out_lockup[29]),
                                                       .Z(edt_scan_out_lockup_buf_out[29]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_30_buf (.A(edt_scan_out_lockup[30]),
                                                       .Z(edt_scan_out_lockup_buf_out[30]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_31_buf (.A(edt_scan_out_lockup[31]),
                                                       .Z(edt_scan_out_lockup_buf_out[31]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_32_buf (.A(edt_scan_out_lockup[32]),
                                                       .Z(edt_scan_out_lockup_buf_out[32]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_33_buf (.A(edt_scan_out_lockup[33]),
                                                       .Z(edt_scan_out_lockup_buf_out[33]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_34_buf (.A(edt_scan_out_lockup[34]),
                                                       .Z(edt_scan_out_lockup_buf_out[34]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_35_buf (.A(edt_scan_out_lockup[35]),
                                                       .Z(edt_scan_out_lockup_buf_out[35]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_36_buf (.A(edt_scan_out_lockup[36]),
                                                       .Z(edt_scan_out_lockup_buf_out[36]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_37_buf (.A(edt_scan_out_lockup[37]),
                                                       .Z(edt_scan_out_lockup_buf_out[37]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_38_buf (.A(edt_scan_out_lockup[38]),
                                                       .Z(edt_scan_out_lockup_buf_out[38]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_39_buf (.A(edt_scan_out_lockup[39]),
                                                       .Z(edt_scan_out_lockup_buf_out[39]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_40_buf (.A(edt_scan_out_lockup[40]),
                                                       .Z(edt_scan_out_lockup_buf_out[40]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_41_buf (.A(edt_scan_out_lockup[41]),
                                                       .Z(edt_scan_out_lockup_buf_out[41]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_42_buf (.A(edt_scan_out_lockup[42]),
                                                       .Z(edt_scan_out_lockup_buf_out[42]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_43_buf (.A(edt_scan_out_lockup[43]),
                                                       .Z(edt_scan_out_lockup_buf_out[43]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_44_buf (.A(edt_scan_out_lockup[44]),
                                                       .Z(edt_scan_out_lockup_buf_out[44]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_45_buf (.A(edt_scan_out_lockup[45]),
                                                       .Z(edt_scan_out_lockup_buf_out[45]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_46_buf (.A(edt_scan_out_lockup[46]),
                                                       .Z(edt_scan_out_lockup_buf_out[46]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_47_buf (.A(edt_scan_out_lockup[47]),
                                                       .Z(edt_scan_out_lockup_buf_out[47]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_48_buf (.A(edt_scan_out_lockup[48]),
                                                       .Z(edt_scan_out_lockup_buf_out[48]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_49_buf (.A(edt_scan_out_lockup[49]),
                                                       .Z(edt_scan_out_lockup_buf_out[49]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_50_buf (.A(edt_scan_out_lockup[50]),
                                                       .Z(edt_scan_out_lockup_buf_out[50]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_51_buf (.A(edt_scan_out_lockup[51]),
                                                       .Z(edt_scan_out_lockup_buf_out[51]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_52_buf (.A(edt_scan_out_lockup[52]),
                                                       .Z(edt_scan_out_lockup_buf_out[52]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_53_buf (.A(edt_scan_out_lockup[53]),
                                                       .Z(edt_scan_out_lockup_buf_out[53]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_54_buf (.A(edt_scan_out_lockup[54]),
                                                       .Z(edt_scan_out_lockup_buf_out[54]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_55_buf (.A(edt_scan_out_lockup[55]),
                                                       .Z(edt_scan_out_lockup_buf_out[55]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_56_buf (.A(edt_scan_out_lockup[56]),
                                                       .Z(edt_scan_out_lockup_buf_out[56]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_57_buf (.A(edt_scan_out_lockup[57]),
                                                       .Z(edt_scan_out_lockup_buf_out[57]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_58_buf (.A(edt_scan_out_lockup[58]),
                                                       .Z(edt_scan_out_lockup_buf_out[58]));
   BUF_X1 tessent_persistent_cell_edt_scan_out_59_buf (.A(edt_scan_out_lockup[59]),
                                                       .Z(edt_scan_out_lockup_buf_out[59]));

   BUF_X1 tessent_persistent_cell_ccm_en_buf (.A(ccm_en),
                                              .Z(ccm_en_buf_out));

   assign edt_update_lbist_disabled = edt_update_buf_out & ~lbist_en;

   assign ccm_scan_en = scan_en & ccm_en_buf_out;
   assign ccm_scan_out = ccm_en_buf_out & ccm_te_so_misr;
   assign ijtag_so = ccm_scan_en ? ccm_te_so_misr : ijtag_so_misr;

   assign edt_update_ccm = ccm_en_buf_out ? ccm_edt_override[0] : edt_update_lbist_disabled;
   assign edt_bypass_ccm = ccm_en_buf_out ? (ccm_edt_override[1] & ~scan_en) : edt_bypass_buf_out;
   assign edt_single_bypass_chain_ccm = ccm_en_buf_out ? (ccm_edt_override[2] & ~scan_en) : edt_single_bypass_chain_buf_out;

   always @(posedge edt_clock_buf_out or negedge ijtag_reset)
   begin 
      if (ijtag_reset == 1'b0) begin
         ijtag_ccm_tdr <= 3'b000;
      end
      else begin
         if (ccm_scan_en == 1'b1) begin
            ijtag_ccm_tdr <= {ccm_le_so_misr, ijtag_ccm_tdr[2:1]};
         end
      end
   end

   assign ijtag_sel_ccm = ccm_en_buf_out ? ijtag_ccm_tdr[0] : ijtag_sel;
   assign ijtag_ce_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b01) : ijtag_ce;
   assign ijtag_se_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b10) : ijtag_se;
   assign ijtag_ue_ccm = ccm_en_buf_out ? (ijtag_ccm_tdr[2:1] == 2'b11) : ijtag_ue;

   always @(posedge edt_clock_buf_out)
   begin 
      ccm_te_si_lockup <= ijtag_ccm_tdr[0]; 
   end

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_decompressor msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_decompressor_i (
      .edt_clock(edt_clock_buf_out),
      .edt_update(edt_update_ccm),
      .edt_channels_in(edt_channels_out_from_controller),
      .edt_chain_mask(edt_chain_mask),
      .edt_chain_mask_load_en(edt_chain_mask_load_en),
      .edt_scan_in(edt_bypass_in),
      .lbist_reset(lbist_reset),
      .lbist_en(lbist_en),
      .lbist_prpg_en(lbist_prpg_en),
      .lbist_low_power_shift_en(lbist_low_power_shift_en),
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ccm_scan_in),
      .ccm_le_so(ccm_le_so_decompressor),
      .ccm_te_si(ccm_te_si_lockup),
      .ccm_te_so(ccm_te_so_decompressor),
      .ijtag_si(ijtag_si),
      .ijtag_so(ijtag_so_decompressor),
      .ccm_edt_override(ccm_edt_override));

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_compactor msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_compactor_i (
      .edt_clock(edt_clock_buf_out),
      .edt_scan_out(edt_scan_out_lockup_buf_out),
      .masks_for_compactor_0(masks_for_compactor_0),
      .masks_for_compactor_1(masks_for_compactor_1),
      .edt_channels_out(edt_bypass_out),
      .lbist_misr_in(lbist_misr_in),
      .ccm_scan_en(ccm_scan_en),
      .ccm_te_si(ccm_te_so_decompressor),
      .ccm_te_so(ccm_te_so_compactor),
      .ccm_le_si(ccm_le_so_decompressor),
      .ccm_le_so(ccm_le_so_compactor));

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_controller msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_controller_i (
      .edt_clock(edt_clock_buf_out),
      .edt_update(edt_update_ccm),
      .edt_channels_in(edt_channels_in_buf_out),
      .edt_channels_out_from_controller(edt_channels_out_from_controller),
      .masks_for_compactor_0(masks_for_compactor_0),
      .masks_for_compactor_1(masks_for_compactor_1),
      .edt_chain_mask(edt_chain_mask),
      .edt_chain_mask_load_en(edt_chain_mask_load_en),
      .lbist_reset(lbist_reset),
      .lbist_en(lbist_en),
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ccm_en(ccm_en_buf_out),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ccm_le_so_compactor),
      .ccm_le_so(ccm_le_so_controller),
      .ccm_te_si(ccm_te_so_compactor),
      .ccm_te_so(ccm_te_so_controller),
      .ijtag_si(ijtag_so_decompressor),
      .ijtag_so(ijtag_so_controller));

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_bypass_logic msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_bypass_logic_i (
      .edt_bypass(edt_bypass_ccm),
      .edt_single_bypass_chain(edt_single_bypass_chain_ccm),
      .lbist_en(lbist_en),
      .ccm_en(ccm_en_buf_out),
      .edt_channels_in(edt_channels_in_buf_out),
      .edt_channels_out(edt_channels_out_buf_in),
      .edt_scan_in(edt_scan_in),
      .edt_scan_out(edt_scan_out),
      .edt_scan_out_lockup(edt_scan_out_lockup),
      .edt_bypass_in(edt_bypass_in_buf_out),
      .edt_bypass_out(edt_bypass_out));

   msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_misr msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_misr_i (
      .edt_clock(edt_clock_buf_out),
      .lbist_reset(lbist_reset),
      .ccm_scan_en(ccm_scan_en),
      .ccm_le_si(ccm_le_so_controller),
      .ccm_le_so(ccm_le_so_misr),
      .ccm_te_si(ccm_te_so_controller),
      .ccm_te_so(ccm_te_so_misr),
      .accumulate(misr_accumulate_en),
      .misr_in(lbist_misr_in),
      .ijtag_tck(ijtag_tck),
      .ijtag_reset(ijtag_reset),
      .ijtag_sel(ijtag_sel_ccm),
      .ijtag_ce(ijtag_ce_ccm),
      .ijtag_se(ijtag_se_ccm),
      .ijtag_ue(ijtag_ue_ccm),
      .ijtag_si(ijtag_so_controller),
      .ijtag_so(ijtag_so_misr));
endmodule


