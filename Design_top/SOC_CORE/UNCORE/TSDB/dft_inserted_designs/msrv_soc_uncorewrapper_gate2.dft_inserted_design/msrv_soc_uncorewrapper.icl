//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2026.1
//       Created on: Tue Aug 18 14:52:40 IST 2026
//-------------------------------------------------


Module msrv_soc_uncorewrapper {
   // ICL module read from source on or near line 8 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ClockPort HCLK {
      Attribute tessent_clock_domain_labels = "HCLK HCLK";
      Attribute tessent_clock_periods = "all 2.00ns";
   }
   ClockPort PCLK {
      Attribute tessent_clock_domain_labels = "PCLK PCLK";
      Attribute tessent_clock_periods = "all 2.00ns";
   }
   CaptureEnPort ijtag_ce;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   ShiftEnPort ijtag_se;
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst.ijtag_so;
   }
   TCKPort ijtag_tck;
   UpdateEnPort ijtag_ue;
   ClockPort lbist_shift_clk;
   ClockPort test_clock_w {
      Attribute function_modifier = "sync_tester_clock";
      Attribute forced_high_dft_signal_list = "ltest_en";
      Attribute connection_rule_option = "allowed_no_source";
   }
   ScanInterface ijtag {
      Port ijtag_ce;
      Port ijtag_reset;
      Port ijtag_se;
      Port ijtag_sel;
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_tck;
      Port ijtag_ue;
   }
   Attribute tessent_design_format = "verilog_2001";
   Attribute test_setup_procfile = "";
   Attribute forced_low_internal_input_port_list = 
       "{msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst/scan_en_out}";
   Attribute icl_extraction_date = "Tue Aug 18 14:51:32 IST 2026";
   Attribute created_by_tessent_icl_extract = "true";
   Attribute tessent_design_id = "gate2";
   Attribute tessent_design_level = "physical_block";
   Attribute tessent_is_physical_module = "true";
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1 {
      InputPort lbist_en = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.lbist_en;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.to_edt_scan_in;
      InputPort edt_bypass = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr_inst.edt_bypass;

      InputPort edt_single_bypass_chain = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_inst.edt_single_bypass_chain_out;

      InputPort ccm_en = 'b0;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.edt_sib_en;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_edt_inst.ijtag_to_sel;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist {
      InputPort ijtag_tck = ijtag_tck;
      InputPort test_clock = test_clock_w;
      InputPort shift_clock_src = lbist_shift_clk;
      InputPort from_edt_scan_out = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst.ijtag_so;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_inst.ijtag_so;

      InputPort ccm_en = 'b0;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst.ijtag_to_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_occ {
      InputPort fast_clock = HCLK;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.ijtag_so;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst.ijtag_to_sel;
      InputPort static_clock_control_mode = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.lbist_en;
      InputPort clock_sequence[2] = 'b0;
      InputPort clock_sequence[1] = 'b0;
      InputPort clock_sequence[0] = 'b0;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_occ {
      InputPort fast_clock = PCLK;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst.ijtag_so;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst.ijtag_to_sel;
      InputPort static_clock_control_mode = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.lbist_en;
      InputPort clock_sequence[2] = 'b0;
      InputPort clock_sequence[1] = 'b0;
      InputPort clock_sequence[0] = 'b0;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_edt_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_2 {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr_inst.ijtag_so;

      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_edt_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_2 {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_2 {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_ctrl_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_2 {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst.ijtag_to_sel;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_edt_inst.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_ctrl_inst";
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_1 {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_ctrl_inst.ijtag_so;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst";
   }
   Instance 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic {
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst.ijtag_to_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort edt_single_bypass_chain_in = 'b0;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_inst"
          ;
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_ctrl_inst.ijtag_to_sel;

      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_edt_inst.ijtag_so;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      Attribute tessent_design_instance = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst";
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1 {
   // ICL module read from source on or near line 264 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   DataInPort lbist_en;
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_misr_i.ijtag_so;

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
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_edt_lbist.instrument";
   Attribute tessent_instrument_type = "mentor::edt";
   Attribute tessent_signature = "08e91a4c9dc81f759951af1e2a9407e0";
   Enum OnOffTable {
      off = 1'b0;
      on = 1'b1;
   }
   ScanRegister lfsm_vec[30:0] {
      ScanInSource lfsm_vec_scan_in_mux;
   }
   ScanRegister lbist_lp_hold_reg[3:0] {
      ScanInSource 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_decompressor_i.ijtag_so;

   }
   ScanRegister lbist_lp_toggle_reg[3:0] {
      ScanInSource lbist_lp_hold_reg[0];
   }
   ScanRegister lbist_lp_switching_reg[3:0] {
      ScanInSource lbist_lp_toggle_reg[0];
   }
   ScanRegister lbist_lp_mask_shift_reg[30:0] {
      ScanInSource 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_static_control_i.ijtag_so;

   }
   ScanRegister bist_chain_mask[59:0] {
      ScanInSource 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i.ijtag_so;

   }
   ScanRegister bist_chain_mask_load_en {
      ScanInSource bist_chain_mask[0];
   }
   ScanRegister misr_1[31:0] {
      ScanInSource 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_chain_mask_i.ijtag_so;

   }
   ScanRegister misr_0[31:0] {
      ScanInSource misr_1[0];
   }
   ScanMux lbist_scan_in_mux SelectedBy ccm_en {
      1'b0 : ijtag_si;
   }
   ScanMux lfsm_vec_scan_in_mux SelectedBy lbist_en {
      1'b1 : lbist_scan_in_mux;
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_decompressor_i 
       Of msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib {
      InputPort ijtag_si = lbist_scan_in_mux;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lfsm_vec[0];
   }
   Instance 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_static_control_i 
       Of msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib {
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_decompressor_i.ijtag_so;

      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lbist_lp_switching_reg[0];
   }
   Instance 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i 
       Of msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib {
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_static_control_i.ijtag_so;

      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = lbist_lp_mask_shift_reg[0];
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_chain_mask_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib {
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i.ijtag_so;

      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = bist_chain_mask_load_en;
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_misr_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib {
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_chain_mask_i.ijtag_so;

      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = misr_0[0];
   }
}

// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_decompressor_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_static_control_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_chain_mask_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_misr_i
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib {
   // ICL module read from source on or near line 414 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
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
   Attribute tessent_signature = "0b0aa369123e423b36e2c41d6478e659";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
   LogicSignal to_sel_and {
      ijtag_sel, sib == 2'b11;
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr {
   // ICL module read from source on or near line 460 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source tdr[0];
   }
   DataOutPort edt_bypass {
      Source tdr[0];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_edt_bypass/Z}";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
      Port ijtag_tck;
      Port ijtag_reset;
      Port ijtag_ce;
      Port ijtag_se;
      Port ijtag_ue;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_instrument_subtype = "tessent_tdr";
   Attribute tessent_signature = "d8d8ff9235cf20820f1dae16096af46d";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_edt_lbist";
   ScanRegister tdr[0:0] {
      ScanInSource ijtag_si;
      CaptureSource tdr[0:0];
      DefaultLoadValue 1'b0;
      ResetValue 1'b0;
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist {
   // ICL module read from source on or near line 506 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   TCKPort ijtag_tck;
   ClockPort test_clock {
      Attribute forced_high_dft_signal_list = "ltest_en";
      Attribute connection_rule_option = "allowed_no_source";
      Attribute function_modifier = "sync_tester_clock";
      Attribute persistent_pin = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_fsm_i/tessent_persistent_cell_edt"
          ,"_clock_tck_mux/B";
   }
   ClockPort shift_clock_src {
      Attribute persistent_pin = 
          "msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_fsm_i/tessent_persistent_cell_shi"
          ,"ft_clock_int_mux/A";
   }
   ToClockPort lbist_test_clock_out {
      Source test_clock;
   }
   ScanInPort from_edt_scan_out;
   ScanOutPort to_edt_scan_in {
      Source 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_control_registers_i.ijtag_so;

   }
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source ijtag_so_mux;
   }
   DataOutPort lbist_en {
      Source bist_en;
   }
   DataInPort ccm_en {
      Attribute connection_rule_option = "allowed_tied_low";
      Attribute tessent_use_in_dft_specification = "false";
   }
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   ToSelectPort edt_sib_en {
      Source 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_edt_sib_i.ijtag_to_sel;
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
   }
   ScanInterface host {
      Port from_edt_scan_out;
      Port edt_sib_en;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_lbist.instrument";
   Attribute tessent_instrument_type = "mentor::logic_bist";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_signature = "49daa7e1bf3e6d3fa5f7ff9fac3dd174";
   Alias bist_done = bist_en {
      RefEnum YesNo;
   }
   Enum YesNo {
      Yes = 1'b1;
      No = 1'b0;
   }
   Enum BistSetupValues {
      Idle = 3'b000;
      LongSetup = 3'b001;
      DefaultLogicBist = 3'b010;
      NormalLogicBist = 3'b011;
      SingleChainMode = 3'b11x;
   }
   ScanRegister capture_phase_size[2:0] {
      ScanInSource from_lbist_register_path_mux;
   }
   ScanRegister warmup_pattern_cnt[7:0] {
      ScanInSource capture_phase_size[0];
   }
   ScanRegister bit_cnt_max[9:0] {
      ScanInSource warmup_pattern_cnt[0];
   }
   ScanRegister vector_cnt[10:0] {
      ScanInSource bit_cnt_max[0];
   }
   ScanRegister lbist_low_power_shift_en_reg {
      ScanInSource 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_bist_registers_i.ijtag_so;

      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister lbist_burn_in_reg {
      ScanInSource lbist_low_power_shift_en_reg;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister shift_clock_select[1:0] {
      ScanInSource lbist_burn_in_reg;
      CaptureSource 2'b00;
      ResetValue 2'b00;
   }
   ScanRegister bist_sync_reset {
      ScanInSource shift_clock_select[0];
      CaptureSource 1'b0;
      ResetValue 1'b0;
      Attribute explicit_iwrite_only = 1'b1;
   }
   ScanRegister bist_clock_disable {
      ScanInSource bist_sync_reset;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanRegister bist_setup[2:0] {
      ScanInSource bist_clock_disable;
      CaptureSource 3'b0;
      ResetValue 3'b0;
      Attribute explicit_iwrite_only = 3'b110;
      RefEnum BistSetupValues;
   }
   ScanRegister bist_en {
      ScanInSource bist_setup[0];
      ResetValue 1'b0;
      RefEnum YesNo;
   }
   ScanRegister ijtag_so_ff {
      ScanInSource 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_edt_sib_i.ijtag_so;
      CaptureSource 1'b0;
   }
   ScanMux ijtag_so_mux SelectedBy ccm_en {
      1'b0 : ijtag_so_ff;
   }
   ScanMux from_lbist_register_path_mux SelectedBy lbist_register_path_en {
      1'b1 : ijtag_si;
   }
   ScanMux from_edt_scan_out_mux SelectedBy edt_scan_path_en {
      1'b1 : from_edt_scan_out;
   }
   LogicSignal lbist_register_path_en {
      ((bist_setup[2:0] == LongSetup) && (bist_clock_disable == 1'b0)) && 
          (bist_en == 1'b1);
   }
   LogicSignal edt_scan_path_en {
      (bist_setup[2:0] == LongSetup) && (bist_clock_disable == 1'b0);
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_bist_registers_i 
       Of msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = vector_cnt[0];
   }
   Instance 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_control_registers_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_bist_registers_i.ijtag_so;

      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = bist_en;
   }
   Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_edt_sib_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib {
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_si = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_control_registers_i.ijtag_so;

      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_from_so = from_edt_scan_out_mux;
   }
}

// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist.msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_bist_registers_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist.msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_control_registers_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist.msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_edt_sib_i
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib {
   // ICL module read from source on or near line 698 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ShiftEnPort ijtag_se;
   CaptureEnPort ijtag_ce;
   UpdateEnPort ijtag_ue;
   SelectPort ijtag_sel;
   ToSelectPort ijtag_to_sel {
      Source to_enable_and;
   }
   ScanInPort ijtag_from_so;
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
   Attribute tessent_signature = "68e26962a3d419ae3e8fdff696a3d86f";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
   LogicSignal to_enable_and {
      ijtag_sel, sib == 2'b11;
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst
// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_occ {
   // ICL module read from source on or near line 745 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ClockPort fast_clock {
      Attribute icl_extraction_port_trigger_list = "clock_out";
   }
   ToClockPort clock_out {
      Source tck_mux;
      Attribute exclude_from_sdc = "on";
   }
   TCKPort ijtag_tck;
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source tdr_sib.scan_out;
   }
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   SelectPort ijtag_sel;
   DataInPort static_clock_control_mode {
      Attribute connection_rule_option = "allowed_tied";
   }
   DataInPort clock_sequence[2:0] {
      Attribute connection_rule_option = "allowed_no_source";
      Attribute function_modifier = "tessent_clock_sequence";
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::occ";
   Attribute tessent_instrument_subtype = "standard";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_occ.instrument";
   Attribute tessent_signature = "2fc6fe7f5652ff282b5b39b4cfcf97e8";
   Attribute tdr_parent_instance = "ijtag_control";
   Alias test_mode = tdr[0] {
   }
   Alias fast_capture_mode = tdr[1] {
   }
   Alias active_upstream_parent_occ = tdr[2] {
   }
   Alias capture_cycle_width[1:0] = tdr[4:3] {
   }
   Alias inject_tck = tdr[5] {
   }
   Alias ijtag_static_clock_control_mode = tdr[6] {
   }
   Alias ijtag_clock_sequence[2:0] = tdr[9:7] {
   }
   ScanRegister tdr[9:0] {
      ScanInSource ijtag_si;
      CaptureSource 10'b0000000000;
      ResetValue 10'b0000000000;
   }
   ClockMux tck_mux SelectedBy inject_tck {
      1'b1 : ijtag_tck;
      1'b0 : fast_clock;
   }
   Instance tdr_sib Of msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_sib_int {
      InputPort clock = ijtag_tck;
      InputPort reset = ijtag_reset;
      InputPort scan_in = ijtag_si;
      InputPort capture_en = ijtag_ce;
      InputPort shift_en = ijtag_se;
      InputPort update_en = ijtag_ue;
      InputPort enable = ijtag_sel;
      InputPort from_scan_out = tdr[0];
   }
}

// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_occ.tdr_sib
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_sib_int {
   // ICL module read from source on or near line 817 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   TCKPort clock;
   ResetPort reset {
      ActivePolarity 0;
   }
   ScanInPort scan_in;
   ScanOutPort scan_out {
      Source sib;
   }
   CaptureEnPort capture_en;
   ShiftEnPort shift_en;
   UpdateEnPort update_en;
   SelectPort enable;
   ToSelectPort to_scan_en {
      Source to_scan_en_and;
   }
   ScanInPort from_scan_out;
   ScanInterface client {
      Port scan_in;
      Port scan_out;
      Port enable;
   }
   ScanInterface host {
      Port from_scan_out;
      Port to_scan_en;
   }
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : scan_in;
      1'b1 : from_scan_out;
   }
   LogicSignal to_scan_en_and {
      enable, sib == 2'b11;
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_edt_inst
// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst
// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst
// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_ctrl_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_2 {
   // ICL module read from source on or near line 862 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ToSelectPort ijtag_to_sel {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort ijtag_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
      Port ijtag_tck;
      Port ijtag_reset;
      Port ijtag_se;
      Port ijtag_ce;
      Port ijtag_ue;
   }
   ScanInterface host {
      Port ijtag_from_so;
      Port ijtag_to_sel;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "f8162660fc966c63654fffab2ca4b1ed";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_ijtag";
   Attribute tessent_instrument_subtype = "sib";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource sib;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_1 {
   // ICL module read from source on or near line 915 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source sib;
   }
   ToSelectPort ijtag_to_sel {
      Attribute connection_rule_option = "allowed_no_destination";
   }
   ScanInPort ijtag_from_so {
      Attribute connection_rule_option = "allowed_no_source";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
      Port ijtag_tck;
      Port ijtag_reset;
      Port ijtag_se;
      Port ijtag_ce;
      Port ijtag_ue;
   }
   ScanInterface host {
      Port ijtag_from_so;
      Port ijtag_to_sel;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_resource_instrument_host";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_signature = "a14bf9b82e168a91cfc1586b7bcc42e2";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_ijtag";
   Attribute tessent_instrument_subtype = "sib";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource sib;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic {
   // ICL module read from source on or near line 969 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source single_chain_sib_i.ijtag_so;
   }
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   DataInPort edt_single_bypass_chain_in {
      Attribute tessent_no_input_constraints = "on";
      Attribute connection_rule_option = "allowed_tied_low";
   }
   DataOutPort edt_single_bypass_chain_out {
      Source edt_single_bypass_chain_ctrl;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_lbist.instrument";
   Attribute tessent_instrument_type = "mentor::logic_bist";
   Attribute tessent_instrument_subtype = "single_chain_mode_logic";
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_signature = "2128a39850383222cce8bb0d870f1a37";
   ScanRegister tdr_single_bypass {
      ScanInSource ijtag_si;
      ResetValue 1'b0;
   }
   LogicSignal edt_single_bypass_chain_ctrl {
      edt_single_bypass_chain_in || tdr_single_bypass;
   }
   Instance tdr_sib_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib {
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = tdr_single_bypass;
   }
   Instance 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers {
      InputPort ijtag_si = tdr_sib_i.ijtag_so;
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = single_chain_sib_i.ijtag_to_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort edt_single_bypass_chain = tdr_single_bypass;
   }
   Instance single_chain_sib_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib {
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_si = tdr_sib_i.ijtag_so;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_from_so = 
          msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers_i.ijtag_so;

   }
}

// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic.tdr_sib_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic.single_chain_sib_i
// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers.blk1_sib_i
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib {
   // ICL module read from source on or near line 1045 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
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
   Attribute tessent_signature = "aa89e75298f344da77ee0fa94978fbd7";
   ScanRegister sib {
      ScanInSource scan_in_mux;
      CaptureSource 1'b0;
      ResetValue 1'b0;
   }
   ScanMux scan_in_mux SelectedBy sib {
      1'b0 : ijtag_si;
      1'b1 : ijtag_from_so;
   }
   LogicSignal to_sel_and {
      ijtag_sel, sib == 2'b11;
   }
}

// instanced as msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers_i
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers {
   // ICL module read from source on or near line 1091 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so {
      Source blk1_sib_i.ijtag_so;
   }
   TCKPort ijtag_tck;
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   DataInPort edt_single_bypass_chain {
      Attribute tessent_no_input_constraints = "on";
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_instrument_type = "mentor::edt";
   Attribute tessent_instrument_subtype = "edt_internal_scan_registers";
   Attribute tessent_signature = "d2b57fabaad8a21e2197325a0dc93f3b";
   ScanRegister edt_lbist_chain1[1:0] {
      ScanInSource edt_lbist_chain1_single_chain_mode_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain2[1:0] {
      ScanInSource edt_lbist_chain2_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain3[1:0] {
      ScanInSource edt_lbist_chain3_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain4[1:0] {
      ScanInSource edt_lbist_chain4_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain5[1:0] {
      ScanInSource edt_lbist_chain5_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain6[1:0] {
      ScanInSource edt_lbist_chain6_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain7[1:0] {
      ScanInSource edt_lbist_chain7_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain8[1:0] {
      ScanInSource edt_lbist_chain8_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain9[1:0] {
      ScanInSource edt_lbist_chain9_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain10[1:0] {
      ScanInSource edt_lbist_chain10_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain11[1:0] {
      ScanInSource edt_lbist_chain11_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain12[1:0] {
      ScanInSource edt_lbist_chain12_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain13[1:0] {
      ScanInSource edt_lbist_chain13_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain14[1:0] {
      ScanInSource edt_lbist_chain14_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain15[1:0] {
      ScanInSource edt_lbist_chain15_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain16[1:0] {
      ScanInSource edt_lbist_chain16_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain17[1:0] {
      ScanInSource edt_lbist_chain17_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain18[1:0] {
      ScanInSource edt_lbist_chain18_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain19[1:0] {
      ScanInSource edt_lbist_chain19_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain20[1:0] {
      ScanInSource edt_lbist_chain20_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain21[1:0] {
      ScanInSource edt_lbist_chain21_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain22[1:0] {
      ScanInSource edt_lbist_chain22_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain23[1:0] {
      ScanInSource edt_lbist_chain23_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain24[1:0] {
      ScanInSource edt_lbist_chain24_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain25[1:0] {
      ScanInSource edt_lbist_chain25_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain26[1:0] {
      ScanInSource edt_lbist_chain26_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain27[1:0] {
      ScanInSource edt_lbist_chain27_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain28[1:0] {
      ScanInSource edt_lbist_chain28_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain29[1:0] {
      ScanInSource edt_lbist_chain29_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain30[1:0] {
      ScanInSource edt_lbist_chain30_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain31[1:0] {
      ScanInSource edt_lbist_chain31_single_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain32[1:0] {
      ScanInSource edt_lbist_chain32_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain33[1:0] {
      ScanInSource edt_lbist_chain33_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain34[1:0] {
      ScanInSource edt_lbist_chain34_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain35[1:0] {
      ScanInSource edt_lbist_chain35_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain36[1:0] {
      ScanInSource edt_lbist_chain36_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain37[1:0] {
      ScanInSource edt_lbist_chain37_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain38[1:0] {
      ScanInSource edt_lbist_chain38_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain39[1:0] {
      ScanInSource edt_lbist_chain39_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain40[1:0] {
      ScanInSource edt_lbist_chain40_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain41[1:0] {
      ScanInSource edt_lbist_chain41_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain42[1:0] {
      ScanInSource edt_lbist_chain42_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain43[1:0] {
      ScanInSource edt_lbist_chain43_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain44[1:0] {
      ScanInSource edt_lbist_chain44_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain45[1:0] {
      ScanInSource edt_lbist_chain45_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain46[1:0] {
      ScanInSource edt_lbist_chain46_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain47[1:0] {
      ScanInSource edt_lbist_chain47_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain48[1:0] {
      ScanInSource edt_lbist_chain48_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain49[1:0] {
      ScanInSource edt_lbist_chain49_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain50[1:0] {
      ScanInSource edt_lbist_chain50_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain51[1:0] {
      ScanInSource edt_lbist_chain51_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain52[1:0] {
      ScanInSource edt_lbist_chain52_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain53[1:0] {
      ScanInSource edt_lbist_chain53_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain54[1:0] {
      ScanInSource edt_lbist_chain54_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain55[1:0] {
      ScanInSource edt_lbist_chain55_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain56[1:0] {
      ScanInSource edt_lbist_chain56_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain57[1:0] {
      ScanInSource edt_lbist_chain57_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain58[1:0] {
      ScanInSource edt_lbist_chain58_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain59[1:0] {
      ScanInSource edt_lbist_chain59_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanRegister edt_lbist_chain60[1:0] {
      ScanInSource edt_lbist_chain60_bypass_mux;
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
   }
   ScanMux edt_lbist_chain1_single_chain_mode_mux SelectedBy 
       edt_single_bypass_chain {
      1'b1 : ijtag_si;
   }
   ScanMux edt_lbist_chain2_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain1[0];
   }
   ScanMux edt_lbist_chain3_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain2[0];
   }
   ScanMux edt_lbist_chain4_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain3[0];
   }
   ScanMux edt_lbist_chain5_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain4[0];
   }
   ScanMux edt_lbist_chain6_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain5[0];
   }
   ScanMux edt_lbist_chain7_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain6[0];
   }
   ScanMux edt_lbist_chain8_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain7[0];
   }
   ScanMux edt_lbist_chain9_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain8[0];
   }
   ScanMux edt_lbist_chain10_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain9[0];
   }
   ScanMux edt_lbist_chain11_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain10[0];
   }
   ScanMux edt_lbist_chain12_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain11[0];
   }
   ScanMux edt_lbist_chain13_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain12[0];
   }
   ScanMux edt_lbist_chain14_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain13[0];
   }
   ScanMux edt_lbist_chain15_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain14[0];
   }
   ScanMux edt_lbist_chain16_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain15[0];
   }
   ScanMux edt_lbist_chain17_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain16[0];
   }
   ScanMux edt_lbist_chain18_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain17[0];
   }
   ScanMux edt_lbist_chain19_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain18[0];
   }
   ScanMux edt_lbist_chain20_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain19[0];
   }
   ScanMux edt_lbist_chain21_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain20[0];
   }
   ScanMux edt_lbist_chain22_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain21[0];
   }
   ScanMux edt_lbist_chain23_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain22[0];
   }
   ScanMux edt_lbist_chain24_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain23[0];
   }
   ScanMux edt_lbist_chain25_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain24[0];
   }
   ScanMux edt_lbist_chain26_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain25[0];
   }
   ScanMux edt_lbist_chain27_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain26[0];
   }
   ScanMux edt_lbist_chain28_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain27[0];
   }
   ScanMux edt_lbist_chain29_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain28[0];
   }
   ScanMux edt_lbist_chain30_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain29[0];
   }
   ScanMux edt_lbist_chain31_single_bypass_mux SelectedBy 
       edt_single_bypass_chain {
      1'b1 : edt_lbist_chain30[0];
   }
   ScanMux edt_lbist_chain32_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain31[0];
   }
   ScanMux edt_lbist_chain33_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain32[0];
   }
   ScanMux edt_lbist_chain34_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain33[0];
   }
   ScanMux edt_lbist_chain35_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain34[0];
   }
   ScanMux edt_lbist_chain36_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain35[0];
   }
   ScanMux edt_lbist_chain37_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain36[0];
   }
   ScanMux edt_lbist_chain38_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain37[0];
   }
   ScanMux edt_lbist_chain39_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain38[0];
   }
   ScanMux edt_lbist_chain40_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain39[0];
   }
   ScanMux edt_lbist_chain41_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain40[0];
   }
   ScanMux edt_lbist_chain42_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain41[0];
   }
   ScanMux edt_lbist_chain43_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain42[0];
   }
   ScanMux edt_lbist_chain44_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain43[0];
   }
   ScanMux edt_lbist_chain45_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain44[0];
   }
   ScanMux edt_lbist_chain46_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain45[0];
   }
   ScanMux edt_lbist_chain47_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain46[0];
   }
   ScanMux edt_lbist_chain48_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain47[0];
   }
   ScanMux edt_lbist_chain49_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain48[0];
   }
   ScanMux edt_lbist_chain50_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain49[0];
   }
   ScanMux edt_lbist_chain51_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain50[0];
   }
   ScanMux edt_lbist_chain52_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain51[0];
   }
   ScanMux edt_lbist_chain53_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain52[0];
   }
   ScanMux edt_lbist_chain54_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain53[0];
   }
   ScanMux edt_lbist_chain55_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain54[0];
   }
   ScanMux edt_lbist_chain56_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain55[0];
   }
   ScanMux edt_lbist_chain57_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain56[0];
   }
   ScanMux edt_lbist_chain58_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain57[0];
   }
   ScanMux edt_lbist_chain59_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain58[0];
   }
   ScanMux edt_lbist_chain60_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1 : edt_lbist_chain59[0];
   }
   Instance blk1_sib_i Of 
       msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib {
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_from_so = edt_lbist_chain60[0];
   }
}

// instanced as msrv_soc_uncorewrapper.msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl {
   // ICL module read from source on or near line 1608 of file './TSDB/dft_inserted_designs/msrv_soc_uncorewrapper_pass2_rtl.dft_inserted_design/msrv_soc_uncorewrapper.icl'
   ResetPort ijtag_reset {
      ActivePolarity 0;
   }
   SelectPort ijtag_sel;
   ScanInPort ijtag_si;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   TCKPort ijtag_tck;
   ScanOutPort ijtag_so {
      Source tdr[0];
   }
   DataOutPort async_set_reset_static_disable {
      Source tdr[10];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "async_set_reset_static_disable";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "0";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_async_set_reset_static_disable/Z}";
   }
   DataOutPort mcp_bounding_en {
      Source tdr[9];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "mcp_bounding_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_mcp_bounding_en/Z}";
   }
   DataOutPort control_test_point_en {
      Source tdr[8];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "control_test_point_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_control_test_point_en/Z}";
   }
   DataOutPort observe_test_point_en {
      Source tdr[7];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "observe_test_point_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_observe_test_point_en/Z}";
   }
   DataOutPort x_bounding_en {
      Source tdr[6];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "x_bounding_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_x_bounding_en/Z}";
   }
   DataOutPort ext_mode {
      Source tdr[5];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "ext_mode";
      Attribute tessent_dft_signal_usage = "scan_mode";
      Attribute tessent_dft_signal_scan_mode_type = "external";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_ext_mode/Z}";
   }
   DataOutPort int_mode {
      Source tdr[4];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "int_mode";
      Attribute tessent_dft_signal_usage = "scan_mode";
      Attribute tessent_dft_signal_scan_mode_type = "internal";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_int_mode/Z}";
   }
   DataOutPort ext_ltest_en {
      Source tdr[3];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "ext_ltest_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_ext_ltest_en/Z}";
   }
   DataOutPort int_ltest_en {
      Source tdr[2];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "int_ltest_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_int_ltest_en/Z}";
   }
   DataOutPort controller_chain_mode {
      Source tdr[1];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "controller_chain_mode";
      Attribute tessent_dft_signal_usage = "scan_mode";
      Attribute tessent_dft_signal_scan_mode_type = "unwrapped";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_controller_chain_mode/Z}";
   }
   DataOutPort ltest_en {
      Source tdr[0];
      Attribute connection_rule_option = "allowed_no_destination";
      Attribute tessent_dft_signal_name = "ltest_en";
      Attribute tessent_dft_signal_usage = "logic_test_control";
      Attribute tessent_dft_signal_value_in_pre_scan_drc = "1";
      Attribute tessent_dft_signal_reset_value = 0;
      Attribute tessent_persistent_design_pin = 
          "{tessent_persistent_cell_ltest_en/Z}";
   }
   ScanInterface client {
      Port ijtag_si;
      Port ijtag_so;
      Port ijtag_sel;
      Port ijtag_tck;
      Port ijtag_reset;
      Port ijtag_ce;
      Port ijtag_se;
      Port ijtag_ue;
   }
   Attribute keep_active_during_scan_test = "true";
   Attribute tessent_dft_function = "scan_resource_instrument_dft_control";
   Attribute forced_low_output_port_list = 
       "x_bounding_en observe_test_point_en control_test_point_en mcp_bounding_en"
       ;
   Attribute tessent_use_in_dft_specification = "false";
   Attribute tessent_instrument_type = "mentor::ijtag_node";
   Attribute tessent_instrument_subtype = "tessent_tdr";
   Attribute tessent_signature = "c9d9b92829acc30e917bc7be5a6d1384";
   Attribute tessent_instrument_container = 
       "msrv_soc_uncorewrapper_pass2_rtl_ijtag";
   ScanRegister tdr[10:0] {
      ScanInSource ijtag_si;
      CaptureSource 11'b00000000000;
      DefaultLoadValue 11'b00000000000;
      ResetValue 11'b00000000000;
   }
}
