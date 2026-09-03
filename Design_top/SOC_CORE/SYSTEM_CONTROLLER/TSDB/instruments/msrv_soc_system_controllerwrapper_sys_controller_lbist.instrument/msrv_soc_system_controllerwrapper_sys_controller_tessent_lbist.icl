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


Module msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist { // {{{
    TCKPort             ijtag_tck;
    ClockPort           test_clock {
        Attribute forced_high_dft_signal_list = "ltest_en";
        Attribute connection_rule_option      = "allowed_no_source";
        Attribute function_modifier           = "sync_tester_clock";
        Attribute persistent_pin              = "msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_edt_clock_tck_mux/B";
    }
    ClockPort           shift_clock_src {
        Attribute persistent_pin = "msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_shift_clock_int_mux/A";
    }
    ToClockPort         lbist_test_clock_out { Source test_clock; }
    ScanInPort          from_edt_scan_out;
    ScanOutPort         to_edt_scan_in      { Source msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib_control_registers_i.ijtag_so; }
    ScanInPort          ijtag_si;
    ScanOutPort         ijtag_so            { Source ijtag_so_mux; }
    DataOutPort         lbist_en            { Source bist_en; }
    DataInPort          ccm_en              {
        Attribute connection_rule_option           = "allowed_tied_low";
        Attribute tessent_use_in_dft_specification = "false";
    }
    ResetPort           ijtag_reset         { ActivePolarity 0; }
    SelectPort          ijtag_sel;
    CaptureEnPort       ijtag_ce;
    ShiftEnPort         ijtag_se;
    UpdateEnPort        ijtag_ue;
    ToSelectPort        edt_sib_en          { Source msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_edt_sib_i.ijtag_to_sel; }
 
    ScanInterface client {
       Port ijtag_si;
       Port ijtag_so;
       Port ijtag_sel;
    }
    ScanInterface host {
       Port from_edt_scan_out;
       Port edt_sib_en;
    }
 
    ScanMux ijtag_so_mux SelectedBy ccm_en {
        1'b0 : ijtag_so_ff;
    }
 
    Alias bist_done    = bist_en { RefEnum YesNo;}
 
    //
    // Bist registers
    //
    LogicSignal lbist_register_path_en  {
        ( bist_setup[2:0] == LongSetup ) && ( bist_clock_disable == 1'b0 ) && ( bist_en == 1'b1 );
    }
    ScanMux from_lbist_register_path_mux SelectedBy lbist_register_path_en {
        1'b1 : ijtag_si;
    }
    ScanRegister capture_phase_size[2:0] {
        ScanInSource    from_lbist_register_path_mux;
    }
    ScanRegister warmup_pattern_cnt[7:0] {
        ScanInSource    capture_phase_size[0];
    }
    ScanRegister bit_cnt_max[9:0] {
        ScanInSource    warmup_pattern_cnt[0];
    }
    ScanRegister vector_cnt[10:0] {
        ScanInSource    bit_cnt_max[0];
    }
 
    Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib_bist_registers_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib {
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_si      = ijtag_si;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_from_so = vector_cnt[0];
    }
 
    //
    // Control registers
    //
    ScanRegister lbist_low_power_shift_en_reg {
        ScanInSource    msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib_bist_registers_i.ijtag_so;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanRegister lbist_burn_in_reg {
        ScanInSource    lbist_low_power_shift_en_reg;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanRegister shift_clock_select[1:0] {
        ScanInSource    lbist_burn_in_reg;
        CaptureSource   2'b00;
        ResetValue      2'b00;
    }
    ScanRegister bist_sync_reset {
        ScanInSource    shift_clock_select[0];
        CaptureSource   1'b0;
        ResetValue      1'b0;
        Attribute explicit_iwrite_only = 1'b1;
    }
    ScanRegister bist_clock_disable {
        ScanInSource    bist_sync_reset;
        CaptureSource   1'b0;
        ResetValue      1'b0;
    }
    ScanRegister bist_setup[2:0] {
        ScanInSource    bist_clock_disable;
        CaptureSource   3'b0;
        ResetValue      3'b0;
        RefEnum         BistSetupValues; 
        Attribute explicit_iwrite_only = 3'b110;
    }
    ScanRegister bist_en {
        ScanInSource    bist_setup[0];
        ResetValue      1'b0;
        RefEnum         YesNo;
    }
    Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib_control_registers_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib {
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_si      = msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib_bist_registers_i.ijtag_so;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_from_so = bist_en;
    }
 
    LogicSignal edt_scan_path_en  {
        ( bist_setup[2:0] == LongSetup ) && ( bist_clock_disable == 1'b0 );
    }
    ScanMux from_edt_scan_out_mux SelectedBy edt_scan_path_en {
        1'b1 : from_edt_scan_out;
    }
 
    Instance msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_edt_sib_i Of msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib {
        InputPort ijtag_reset   = ijtag_reset;
        InputPort ijtag_sel     = ijtag_sel;
        InputPort ijtag_si      = msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib_control_registers_i.ijtag_so;
        InputPort ijtag_ce      = ijtag_ce;
        InputPort ijtag_se      = ijtag_se;
        InputPort ijtag_ue      = ijtag_ue;
        InputPort ijtag_tck     = ijtag_tck;
        InputPort ijtag_from_so = from_edt_scan_out_mux;
    }
 
    ScanRegister ijtag_so_ff {
        ScanInSource    msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_edt_sib_i.ijtag_so;
        CaptureSource   1'b0;
    }
 
    Enum YesNo {
        Yes                 = 1'b1;
        No                  = 1'b0;
    }
    Enum BistSetupValues {
        Idle                = 3'b000;
        LongSetup           = 3'b001;
        DefaultLogicBist    = 3'b010;
        NormalLogicBist     = 3'b011;
        SingleChainMode     = 3'b11x;
    }
    Attribute keep_active_during_scan_test = "true";
    Attribute tessent_instrument_container = "msrv_soc_system_controllerwrapper_sys_controller_lbist.instrument";
    Attribute tessent_instrument_type = "mentor::logic_bist";
    Attribute tessent_use_in_dft_specification = "false";
    Attribute tessent_signature       = "db613b4b34d84b2b92532c8019fa978b";
} // }}}
 
Module msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_sib { // {{{
    TCKPort             ijtag_tck;
    ResetPort           ijtag_reset         { ActivePolarity 0; }
    ScanInPort          ijtag_si;
    ScanOutPort         ijtag_so            { Source sib; }
    ShiftEnPort         ijtag_se;
    CaptureEnPort       ijtag_ce;
    UpdateEnPort        ijtag_ue;
    SelectPort          ijtag_sel;
    ToSelectPort        ijtag_to_sel        { Source to_enable_and; }
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
    LogicSignal to_enable_and  {
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
    Attribute tessent_signature                = "9628ecbac306c0695cf9e70d8cf8fa47";
} // }}}
 
