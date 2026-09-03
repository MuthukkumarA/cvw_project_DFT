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
//--------------------------------------------------------------------------------

Module msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1 {
   DataInPort lbist_en;
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_misr_i.ijtag_so;
   }
   DataInPort edt_bypass {
      RefEnum OnOffTable;
      Attribute tessent_no_input_constraints = "on";
   }
   DataInPort edt_single_bypass_chain {
      RefEnum OnOffTable;
      Attribute tessent_no_input_constraints = "on";
   }
   DataInPort ccm_en {
      Attribute connection_rule_option = "allowed_tied_low";
      Attribute tessent_use_in_dft_specification = "false";
   }
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;

   ScanMux lbist_scan_in_mux SelectedBy ccm_en {
      1'b0: ijtag_si;
   }
   ScanMux lfsm_vec_scan_in_mux SelectedBy lbist_en {
      1'b1: lbist_scan_in_mux;
   }

   ScanRegister lfsm_vec[30:0] {
      ScanInSource lfsm_vec_scan_in_mux;
   }
   Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_decompressor_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib {
      InputPort ijtag_si = lbist_scan_in_mux;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lfsm_vec[0];
   }

   ScanRegister lbist_lp_hold_reg[3:0] {
      ScanInSource msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_decompressor_i.ijtag_so;
   }
   ScanRegister lbist_lp_toggle_reg[3:0] {
      ScanInSource lbist_lp_hold_reg[0];
   }
   ScanRegister lbist_lp_switching_reg[3:0] {
      ScanInSource lbist_lp_toggle_reg[0];
   }
   Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_lbist_lp_static_control_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib {
      InputPort ijtag_si = msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_decompressor_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lbist_lp_switching_reg[0];
   }

   ScanRegister lbist_lp_mask_shift_reg[30:0] {
      ScanInSource msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_lbist_lp_static_control_i.ijtag_so;
   }
   Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib {
      InputPort ijtag_si = msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_lbist_lp_static_control_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lbist_lp_mask_shift_reg[0];
   }

   ScanRegister bist_chain_mask[59:0] {
      ScanInSource msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i.ijtag_so;
   }

   ScanRegister bist_chain_mask_load_en {
      ScanInSource bist_chain_mask[0];
   }

   Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_chain_mask_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib {
      InputPort ijtag_si = msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = bist_chain_mask_load_en;
   }

   ScanRegister misr_1[31:0] {
      ScanInSource msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_chain_mask_i.ijtag_so;
   }

   ScanRegister misr_0[31:0] {
      ScanInSource misr_1[0];
   }

   Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_misr_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib {
      InputPort ijtag_si = msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib_chain_mask_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = misr_0[0];
   }

   Enum OnOffTable {
      off = 1'b0;
      on  = 1'b1;
   }

   Attribute keep_active_during_scan_test = "true";

   Attribute tessent_instrument_container = "msrv_soc_system_controllerwrapper_sys_controller_edt_lbist.instrument";
   Attribute tessent_instrument_type = "mentor::edt";
   Attribute tessent_signature = "ce3ff609bdc27d4ce8f0310fcf14776a";
}

Module msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_sib {
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source sib;
   }
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   SelectPort ijtag_sel;
   ToSelectPort ijtag_to_sel {
      Source to_sel_and;
   }
   ScanInPort ijtag_from_so;

   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0: ijtag_si;
      1'b1: ijtag_from_so;
   }
   LogicSignal to_sel_and {
      ijtag_sel,sib == 2'b11;
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   ScanInterface host {
      Port ijtag_from_so;
      Port ijtag_to_sel;
   }

   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "a29d8b7c28bd7a6d37350cefa81d8172";
}

