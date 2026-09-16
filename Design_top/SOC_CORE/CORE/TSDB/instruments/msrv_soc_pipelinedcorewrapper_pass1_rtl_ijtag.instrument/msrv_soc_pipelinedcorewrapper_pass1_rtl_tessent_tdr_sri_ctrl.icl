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
//       Created on: Tue Aug 18 14:31:14 IST 2026
//--------------------------------------------------------------------------

Module msrv_soc_pipelinedcorewrapper_pass1_rtl_tessent_tdr_sri_ctrl {
 
  ResetPort     ijtag_reset             { ActivePolarity 0;      }
  SelectPort    ijtag_sel;
  ScanInPort    ijtag_si;
  CaptureEnPort ijtag_ce;
  ShiftEnPort   ijtag_se;
  UpdateEnPort  ijtag_ue;
  TCKPort       ijtag_tck;
  ScanOutPort   ijtag_so                { Source tdr[0];         }
  DataOutPort   mcp_bounding_en         {
    Source tdr[9];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "mcp_bounding_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_mcp_bounding_en/Z";
  }
  DataOutPort   control_test_point_en   {
    Source tdr[8];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "control_test_point_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_control_test_point_en/Z";
  }
  DataOutPort   observe_test_point_en   {
    Source tdr[7];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "observe_test_point_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_observe_test_point_en/Z";
  }
  DataOutPort   x_bounding_en           {
    Source tdr[6];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "x_bounding_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_x_bounding_en/Z";
  }
  DataOutPort   ext_mode                {
    Source tdr[5];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "ext_mode";
    Attribute tessent_dft_signal_usage = "scan_mode";
    Attribute tessent_dft_signal_scan_mode_type = "external";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_ext_mode/Z";
  }
  DataOutPort   int_mode                {
    Source tdr[4];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "int_mode";
    Attribute tessent_dft_signal_usage = "scan_mode";
    Attribute tessent_dft_signal_scan_mode_type = "internal";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_int_mode/Z";
  }
  DataOutPort   ext_ltest_en            {
    Source tdr[3];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "ext_ltest_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_ext_ltest_en/Z";
  }
  DataOutPort   int_ltest_en            {
    Source tdr[2];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "int_ltest_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "x";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_int_ltest_en/Z";
  }
  DataOutPort   controller_chain_mode   {
    Source tdr[1];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "controller_chain_mode";
    Attribute tessent_dft_signal_usage = "scan_mode";
    Attribute tessent_dft_signal_scan_mode_type = "unwrapped";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_controller_chain_mode/Z";
  }
  DataOutPort   ltest_en                {
    Source tdr[0];
    Attribute connection_rule_option = "allowed_no_destination";
    Attribute tessent_dft_signal_name = "ltest_en";
    Attribute tessent_dft_signal_usage = "logic_test_control";
    Attribute tessent_dft_signal_value_in_pre_scan_drc = "1";
    Attribute tessent_dft_signal_reset_value = 0;
    Attribute tessent_persistent_design_pin = "tessent_persistent_cell_ltest_en/Z";
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
  Attribute forced_low_output_port_list = "x_bounding_en observe_test_point_en control_test_point_en mcp_bounding_en";
 
  ScanRegister tdr[9:0] {
    ScanInSource     ijtag_si;
    CaptureSource    10'b0000000000;
    ResetValue       10'b0000000000;
    DefaultLoadValue 10'b0000000000;
  }
 
 
  Attribute tessent_use_in_dft_specification = "false";
  Attribute tessent_instrument_type          = "mentor::ijtag_node";
  Attribute tessent_instrument_subtype       = "tessent_tdr";
  Attribute tessent_signature                = "526371dd99c3b83cf820acf4bce84ec6";
  Attribute tessent_instrument_container     = "msrv_soc_pipelinedcorewrapper_pass1_rtl_ijtag";
}
