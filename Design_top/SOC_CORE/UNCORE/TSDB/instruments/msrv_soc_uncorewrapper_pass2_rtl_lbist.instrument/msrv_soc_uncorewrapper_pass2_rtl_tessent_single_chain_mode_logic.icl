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
//       Created on: Tue Aug 18 14:51:24 IST 2026
//--------------------------------------------------------------------------------


Module msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic { // {{{
    ScanInPort          ijtag_si;
    ScanOutPort         ijtag_so            { Source single_chain_sib_i.ijtag_so; }
    TCKPort             ijtag_tck;
    ResetPort           ijtag_reset         { ActivePolarity 0; }
    SelectPort          ijtag_sel;
    CaptureEnPort       ijtag_ce;
    ShiftEnPort         ijtag_se;
    UpdateEnPort        ijtag_ue;
    DataInPort          edt_single_bypass_chain_in { Attribute tessent_no_input_constraints = "on"; Attribute connection_rule_option = "allowed_tied_low"; }
    DataOutPort         edt_single_bypass_chain_out { Source edt_single_bypass_chain_ctrl; }
 
    LogicSignal edt_single_bypass_chain_ctrl {
        edt_single_bypass_chain_in || tdr_single_bypass;
    }
 
    ScanRegister tdr_single_bypass {
        ScanInSource    ijtag_si;
        ResetValue      1'b0;
    }
 
    Instance tdr_sib_i Of msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib {
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_si      = ijtag_si;
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_from_so = tdr_single_bypass;
    }
 
    Instance msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers_i Of msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers {
        InputPort ijtag_si      = tdr_sib_i.ijtag_so;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = single_chain_sib_i.ijtag_to_sel;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort edt_single_bypass_chain = tdr_single_bypass;
    }
 
    Instance single_chain_sib_i Of msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib {
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_si      = tdr_sib_i.ijtag_so;
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_from_so = msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers_i.ijtag_so;
    }
 
    Attribute keep_active_during_scan_test = "true";
    Attribute tessent_instrument_container = "msrv_soc_uncorewrapper_pass2_rtl_lbist.instrument";
    Attribute tessent_instrument_type    = "mentor::logic_bist";
    Attribute tessent_instrument_subtype = "single_chain_mode_logic";
    Attribute tessent_use_in_dft_specification = "false";
    Attribute tessent_signature          = "2128a39850383222cce8bb0d870f1a37";
}  // }}}
 
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib { // {{{
    TCKPort             ijtag_tck;
    ResetPort           ijtag_reset         { ActivePolarity 0; }
    ScanInPort          ijtag_si;
    ScanOutPort         ijtag_so            { Source sib; }
    CaptureEnPort       ijtag_ce;
    ShiftEnPort         ijtag_se;
    UpdateEnPort        ijtag_ue;
    SelectPort          ijtag_sel;
    ToSelectPort        ijtag_to_sel        { Source to_sel_and; }
    ScanInPort          ijtag_from_so;
 
    ScanRegister sib {
        ScanInSource    scan_in_mux;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanMux scan_in_mux SelectedBy sib {
        1'b0 : ijtag_si;
        1'b1 : ijtag_from_so;
    }
    LogicSignal to_sel_and  {
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
    Attribute keep_active_during_scan_test     = "true";
    Attribute tessent_use_in_dft_specification = "false";
    Attribute tessent_instrument_type          = "mentor::ijtag_node";
    Attribute tessent_signature                = "aa89e75298f344da77ee0fa94978fbd7";
} // }}}
 
Module msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_internal_scan_registers {
   ScanInPort ijtag_si;
   ScanOutPort ijtag_so { Source blk1_sib_i.ijtag_so; }
   TCKPort ijtag_tck;
   ResetPort ijtag_reset { ActivePolarity 0; }
   SelectPort ijtag_sel;
   CaptureEnPort ijtag_ce;
   ShiftEnPort ijtag_se;
   UpdateEnPort ijtag_ue;
   DataInPort edt_single_bypass_chain {
      Attribute tessent_no_input_constraints = "on";
   }

   ScanMux edt_lbist_chain1_single_chain_mode_mux SelectedBy edt_single_bypass_chain {
      1'b1: ijtag_si;
   }
   ScanRegister edt_lbist_chain1[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain1_single_chain_mode_mux;
   }

   ScanMux edt_lbist_chain2_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain1[0];
   }
   ScanRegister edt_lbist_chain2[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain2_bypass_mux;
   }

   ScanMux edt_lbist_chain3_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain2[0];
   }
   ScanRegister edt_lbist_chain3[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain3_bypass_mux;
   }

   ScanMux edt_lbist_chain4_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain3[0];
   }
   ScanRegister edt_lbist_chain4[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain4_bypass_mux;
   }

   ScanMux edt_lbist_chain5_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain4[0];
   }
   ScanRegister edt_lbist_chain5[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain5_bypass_mux;
   }

   ScanMux edt_lbist_chain6_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain5[0];
   }
   ScanRegister edt_lbist_chain6[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain6_bypass_mux;
   }

   ScanMux edt_lbist_chain7_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain6[0];
   }
   ScanRegister edt_lbist_chain7[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain7_bypass_mux;
   }

   ScanMux edt_lbist_chain8_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain7[0];
   }
   ScanRegister edt_lbist_chain8[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain8_bypass_mux;
   }

   ScanMux edt_lbist_chain9_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain8[0];
   }
   ScanRegister edt_lbist_chain9[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain9_bypass_mux;
   }

   ScanMux edt_lbist_chain10_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain9[0];
   }
   ScanRegister edt_lbist_chain10[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain10_bypass_mux;
   }

   ScanMux edt_lbist_chain11_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain10[0];
   }
   ScanRegister edt_lbist_chain11[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain11_bypass_mux;
   }

   ScanMux edt_lbist_chain12_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain11[0];
   }
   ScanRegister edt_lbist_chain12[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain12_bypass_mux;
   }

   ScanMux edt_lbist_chain13_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain12[0];
   }
   ScanRegister edt_lbist_chain13[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain13_bypass_mux;
   }

   ScanMux edt_lbist_chain14_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain13[0];
   }
   ScanRegister edt_lbist_chain14[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain14_bypass_mux;
   }

   ScanMux edt_lbist_chain15_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain14[0];
   }
   ScanRegister edt_lbist_chain15[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain15_bypass_mux;
   }

   ScanMux edt_lbist_chain16_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain15[0];
   }
   ScanRegister edt_lbist_chain16[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain16_bypass_mux;
   }

   ScanMux edt_lbist_chain17_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain16[0];
   }
   ScanRegister edt_lbist_chain17[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain17_bypass_mux;
   }

   ScanMux edt_lbist_chain18_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain17[0];
   }
   ScanRegister edt_lbist_chain18[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain18_bypass_mux;
   }

   ScanMux edt_lbist_chain19_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain18[0];
   }
   ScanRegister edt_lbist_chain19[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain19_bypass_mux;
   }

   ScanMux edt_lbist_chain20_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain19[0];
   }
   ScanRegister edt_lbist_chain20[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain20_bypass_mux;
   }

   ScanMux edt_lbist_chain21_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain20[0];
   }
   ScanRegister edt_lbist_chain21[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain21_bypass_mux;
   }

   ScanMux edt_lbist_chain22_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain21[0];
   }
   ScanRegister edt_lbist_chain22[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain22_bypass_mux;
   }

   ScanMux edt_lbist_chain23_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain22[0];
   }
   ScanRegister edt_lbist_chain23[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain23_bypass_mux;
   }

   ScanMux edt_lbist_chain24_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain23[0];
   }
   ScanRegister edt_lbist_chain24[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain24_bypass_mux;
   }

   ScanMux edt_lbist_chain25_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain24[0];
   }
   ScanRegister edt_lbist_chain25[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain25_bypass_mux;
   }

   ScanMux edt_lbist_chain26_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain25[0];
   }
   ScanRegister edt_lbist_chain26[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain26_bypass_mux;
   }

   ScanMux edt_lbist_chain27_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain26[0];
   }
   ScanRegister edt_lbist_chain27[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain27_bypass_mux;
   }

   ScanMux edt_lbist_chain28_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain27[0];
   }
   ScanRegister edt_lbist_chain28[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain28_bypass_mux;
   }

   ScanMux edt_lbist_chain29_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain28[0];
   }
   ScanRegister edt_lbist_chain29[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain29_bypass_mux;
   }

   ScanMux edt_lbist_chain30_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain29[0];
   }
   ScanRegister edt_lbist_chain30[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain30_bypass_mux;
   }

   ScanMux edt_lbist_chain31_single_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain30[0];
   }
   ScanRegister edt_lbist_chain31[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain31_single_bypass_mux;
   }

   ScanMux edt_lbist_chain32_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain31[0];
   }
   ScanRegister edt_lbist_chain32[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain32_bypass_mux;
   }

   ScanMux edt_lbist_chain33_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain32[0];
   }
   ScanRegister edt_lbist_chain33[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain33_bypass_mux;
   }

   ScanMux edt_lbist_chain34_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain33[0];
   }
   ScanRegister edt_lbist_chain34[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain34_bypass_mux;
   }

   ScanMux edt_lbist_chain35_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain34[0];
   }
   ScanRegister edt_lbist_chain35[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain35_bypass_mux;
   }

   ScanMux edt_lbist_chain36_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain35[0];
   }
   ScanRegister edt_lbist_chain36[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain36_bypass_mux;
   }

   ScanMux edt_lbist_chain37_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain36[0];
   }
   ScanRegister edt_lbist_chain37[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain37_bypass_mux;
   }

   ScanMux edt_lbist_chain38_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain37[0];
   }
   ScanRegister edt_lbist_chain38[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain38_bypass_mux;
   }

   ScanMux edt_lbist_chain39_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain38[0];
   }
   ScanRegister edt_lbist_chain39[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain39_bypass_mux;
   }

   ScanMux edt_lbist_chain40_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain39[0];
   }
   ScanRegister edt_lbist_chain40[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain40_bypass_mux;
   }

   ScanMux edt_lbist_chain41_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain40[0];
   }
   ScanRegister edt_lbist_chain41[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain41_bypass_mux;
   }

   ScanMux edt_lbist_chain42_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain41[0];
   }
   ScanRegister edt_lbist_chain42[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain42_bypass_mux;
   }

   ScanMux edt_lbist_chain43_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain42[0];
   }
   ScanRegister edt_lbist_chain43[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain43_bypass_mux;
   }

   ScanMux edt_lbist_chain44_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain43[0];
   }
   ScanRegister edt_lbist_chain44[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain44_bypass_mux;
   }

   ScanMux edt_lbist_chain45_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain44[0];
   }
   ScanRegister edt_lbist_chain45[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain45_bypass_mux;
   }

   ScanMux edt_lbist_chain46_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain45[0];
   }
   ScanRegister edt_lbist_chain46[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain46_bypass_mux;
   }

   ScanMux edt_lbist_chain47_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain46[0];
   }
   ScanRegister edt_lbist_chain47[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain47_bypass_mux;
   }

   ScanMux edt_lbist_chain48_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain47[0];
   }
   ScanRegister edt_lbist_chain48[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain48_bypass_mux;
   }

   ScanMux edt_lbist_chain49_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain48[0];
   }
   ScanRegister edt_lbist_chain49[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain49_bypass_mux;
   }

   ScanMux edt_lbist_chain50_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain49[0];
   }
   ScanRegister edt_lbist_chain50[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain50_bypass_mux;
   }

   ScanMux edt_lbist_chain51_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain50[0];
   }
   ScanRegister edt_lbist_chain51[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain51_bypass_mux;
   }

   ScanMux edt_lbist_chain52_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain51[0];
   }
   ScanRegister edt_lbist_chain52[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain52_bypass_mux;
   }

   ScanMux edt_lbist_chain53_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain52[0];
   }
   ScanRegister edt_lbist_chain53[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain53_bypass_mux;
   }

   ScanMux edt_lbist_chain54_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain53[0];
   }
   ScanRegister edt_lbist_chain54[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain54_bypass_mux;
   }

   ScanMux edt_lbist_chain55_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain54[0];
   }
   ScanRegister edt_lbist_chain55[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain55_bypass_mux;
   }

   ScanMux edt_lbist_chain56_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain55[0];
   }
   ScanRegister edt_lbist_chain56[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain56_bypass_mux;
   }

   ScanMux edt_lbist_chain57_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain56[0];
   }
   ScanRegister edt_lbist_chain57[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain57_bypass_mux;
   }

   ScanMux edt_lbist_chain58_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain57[0];
   }
   ScanRegister edt_lbist_chain58[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain58_bypass_mux;
   }

   ScanMux edt_lbist_chain59_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain58[0];
   }
   ScanRegister edt_lbist_chain59[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain59_bypass_mux;
   }

   ScanMux edt_lbist_chain60_bypass_mux SelectedBy edt_single_bypass_chain {
      1'b1: edt_lbist_chain59[0];
   }
   ScanRegister edt_lbist_chain60[1:0] {
      Attribute tessent_scan_register = "*";
      Attribute tessent_ignore_during_icl_verification = "on";
      ScanInSource edt_lbist_chain60_bypass_mux;
   }

   Instance blk1_sib_i Of msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_sib {
      InputPort ijtag_tck = ijtag_tck;
      InputPort ijtag_reset = ijtag_reset;
      InputPort ijtag_si = ijtag_si;
      InputPort ijtag_ce = ijtag_ce;
      InputPort ijtag_se = ijtag_se;
      InputPort ijtag_ue = ijtag_ue;
      InputPort ijtag_sel = ijtag_sel;
      InputPort ijtag_from_so = edt_lbist_chain60[0];
   }

   Attribute keep_active_during_scan_test = "true";

   Attribute tessent_instrument_type = "mentor::edt";
   Attribute tessent_instrument_subtype = "edt_internal_scan_registers";
   Attribute tessent_signature = "d2b57fabaad8a21e2197325a0dc93f3b";
}
