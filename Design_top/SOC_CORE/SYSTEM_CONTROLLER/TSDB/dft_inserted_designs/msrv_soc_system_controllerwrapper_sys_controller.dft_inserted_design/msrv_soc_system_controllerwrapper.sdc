#--------------------------------------------------------------------------
#
#  Unpublished work. Copyright 2026 Siemens
#
#  This material contains trade secrets or otherwise confidential 
#  information owned by Siemens Industry Software Inc. or its affiliates 
#  (collectively, SISW), or its licensors. Access to and use of this 
#  information is strictly limited as set forth in the Customer's 
#  applicable agreements with SISW.
#
#--------------------------------------------------------------------------
#  File created by: Tessent Shell
#          Version: 2026.1
#       Created on: Tue Aug 18 14:57:16 IST 2026
#--------------------------------------------------------------------------

#
#  Procs table of content:
#
#    tessent_set_default_variables
#    tessent_set_ijtag_non_modal
#    tessent_set_non_modal
#    set_ijtag_retargeting_options
#    tessent_set_ltest_set_timing_variables_default
#    tessent_set_ltest_create_clocks
#    tessent_set_ltest_non_modal
#    tessent_set_ltest_occ
#    tessent_set_ltest_modal_shift
#    tessent_set_ltest_modal_edt_fast_capture
#    tessent_set_ltest_modal_edt_slow_capture
#    tessent_set_ltest_modal_edt_shift
#    tessent_set_ltest_modal_bypass_shift
#    tessent_set_ltest_disable
#    tessent_set_ltest_pb_external_mode
#    tessent_set_ltest_core_external_mode
#    tessent_set_ltest_modal_lbist_shift
#    tessent_set_ltest_modal_lbist_capture
#    tessent_set_ltest_modal_lbist_setup
#    tessent_set_ltest_modal_lbist_single_chain
#    tessent_set_ltest_modal_lbist_controller_chain
#    tessent_set_ltest_set_pin_delays
#    tessent_get_cts_skew_groups_dict
#    tessent_msrv_soc_system_controllerwrapper_set_dft_signals
#    tessent_get_cells
#    tessent_get_flops
#    tessent_get_pins
#    tessent_get_ports
#    tessent_map_to_verilog
#    tessent_remap_vhdl_path_list
#    tessent_remove_clock_groups
#    tessent_get_clock_source
#    tessent_set_clock_sense_stop_propagation
#    tessent_kill_functional_paths
#    tessent_get_mem_cells
#    tessent_get_clocks
#    tessent_get_preserve_instances
#    tessent_get_size_only_instances
#    tessent_get_optimize_instances
#
proc tessent_set_default_variables {} {
  global time_unit_multiplier tessent_input_delay_percentage tessent_output_delay_percentage tessent_tck_clocks_group_created scan_resource_sib_list tessent_extra_control_setup_hold_cycles tessent_extra_reset_setup_hold_cycles tessent_extra_tms_setup_hold_cycles tessent_default_scan_out_strobe_point tessent_tck_period tessent_tck_clocks_list tessent_clock_mapping scan_en_port_name edt_update_port_name tessent_regQ tessent_regQB tessent_edt_mapping tessent_lbist_mapping tessent_lbist_single_chain_mode_logic_mapping tessent_timing_options tessent_hierarchy_separator tessent_path_cache tessent_timing_tool tessent_test_inst_regexp
  #
  # This proc defines the default value of the variables used in instrument timing constraints
  #

  # Time units assumed ns
  set time_unit_multiplier 1.0

  set tessent_input_delay_percentage 0.25

  set tessent_output_delay_percentage 0.25

  set tessent_tck_clocks_group_created 0

  set scan_resource_sib_list [list  \
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_edt_inst/to_enable_int* \
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_lbist_inst/to_enable_int* \
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_occ_inst/to_enable_int* \
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst/to_enable_int* \
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst/to_enable_int* \
  ]

  set tessent_extra_control_setup_hold_cycles 0

  set tessent_extra_reset_setup_hold_cycles 0

  set tessent_extra_tms_setup_hold_cycles 0

  set tessent_default_scan_out_strobe_point auto

  set tessent_tck_period 100.0

  set tessent_tck_clocks_list [list ts_tck_ijtag_tck_input_virtual ts_tck_ijtag_tck]

  array set tessent_clock_mapping {
    ts_tck_ijtag_tck_input_virtual ts_tck_ijtag_tck_input_virtual
    ts_tck_ijtag_tck ts_tck_ijtag_tck
  }

  set scan_en_port_name scan_en_w

  set edt_update_port_name edt_update

  set tessent_regQ Q

  set tessent_regQB QB

  # Use this mapping to find which unique identifier maps to which EDT controller instance.
  array set tessent_edt_mapping {
    edt_inst0 msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst
  }

  # Use this mapping to find which unique identifier maps to which LBIST controller instance.
  array set tessent_lbist_mapping {
    lbist_inst0 msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_inst
  }

  # Use this mapping to find which unique identifier maps to which LBIST single chain mode instance.
  array set tessent_lbist_single_chain_mode_logic_mapping {
    lbist_inst0 msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_inst
  }

 # Test procedure timing specifications:
  tessent_set_ltest_set_timing_variables_default


  set tessent_hierarchy_separator /

  array set tessent_path_cache {
  }

  switch -glob [file tail [info nameofexecutable]] {
    common_shell_exec {set tessent_timing_tool dc_shell}
    oasys*            {set tessent_timing_tool oasys}
    rc                {set tessent_timing_tool encounter}
    genus             {set tessent_timing_tool genus}
    dgcom_exec        {set tessent_timing_tool pt_shell}
    default           {set tessent_timing_tool pt_shell}
  }
  

  set tessent_test_inst_regexp {(.*_tessent_occ_.*)}

}
proc tessent_set_ijtag_non_modal {} {  
  
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_tck_clocks_group_created
  global tessent_clock_mapping tessent_input_delay tessent_input_delay_percentage tessent_output_delay tessent_output_delay_percentage
  global tessent_extra_control_setup_hold_cycles
  global tessent_extra_reset_setup_hold_cycles
  global tessent_extra_tms_setup_hold_cycles
  global tessent_default_scan_out_strobe_point
  
  global scan_resource_sib_list
  
  if {[info exists tessent_input_delay]} {
    set local_input_delay $tessent_input_delay
    set local_controls_input_delay $tessent_input_delay
    set local_tms_input_delay $tessent_input_delay
  } else {
    set local_input_delay [expr {$tessent_input_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
    set local_controls_input_delay [expr {$tessent_input_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
    set local_tms_input_delay [expr {$tessent_input_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
  }
  if {[info exists tessent_output_delay]} {
    set local_output_delay $tessent_output_delay
  } else {
    set local_output_delay [expr {$tessent_output_delay_percentage*$tessent_tck_period*$time_unit_multiplier}]
  }
      
  if {[sizeof_collection [tessent_get_clocks $tessent_clock_mapping(ts_tck_ijtag_tck) -quiet]] == 0} {
    create_clock [tessent_get_ports [list {ijtag_tck}]]  \
      -period [expr $tessent_tck_period*$time_unit_multiplier] \
      -name $tessent_clock_mapping(ts_tck_ijtag_tck) -add
  
    create_clock  \
      -period [expr $tessent_tck_period*$time_unit_multiplier] \
      -name $tessent_clock_mapping(ts_tck_ijtag_tck_input_virtual) -add
  
  }
  set_false_path -from [tessent_get_ports [list {ijtag_reset}]] 
  if {$tessent_default_scan_out_strobe_point eq "before_falling_edge_of_tck"} {
    set clock_edge "-clock_fall"
  } else {
    set clock_edge ""
  }
  set_input_delay $local_controls_input_delay -clock $tessent_clock_mapping(ts_tck_ijtag_tck_input_virtual) [tessent_get_ports {ijtag_ce}]  -clock_fall
  set_input_delay $local_controls_input_delay -clock $tessent_clock_mapping(ts_tck_ijtag_tck_input_virtual) [tessent_get_ports {ijtag_se}]  -clock_fall
  set_input_delay $local_controls_input_delay -clock $tessent_clock_mapping(ts_tck_ijtag_tck_input_virtual) [tessent_get_ports {ijtag_ue}] 
  set_input_delay $local_controls_input_delay -clock $tessent_clock_mapping(ts_tck_ijtag_tck_input_virtual) [tessent_get_ports {ijtag_sel}]  -clock_fall
  set_input_delay $local_input_delay -clock $tessent_clock_mapping(ts_tck_ijtag_tck_input_virtual) [tessent_get_ports {ijtag_si}]  -clock_fall
  set_output_delay $local_output_delay -clock $tessent_clock_mapping(ts_tck_ijtag_tck_input_virtual) [tessent_get_ports {ijtag_so}] {*}$clock_edge 
  set mapped_tck_clock_list [list]
  foreach tck_clock $tessent_tck_clocks_list {
    lappend mapped_tck_clock_list $tessent_clock_mapping($tck_clock)
  }
  if {[sizeof_collection [tessent_get_clocks $mapped_tck_clock_list -quiet]] > 0} {
    tessent_remove_clock_groups -asynchronous tessent_tck_clock_group
    set_clock_groups -asynchronous -group [tessent_get_clocks $mapped_tck_clock_list] -name tessent_tck_clock_group
    set tessent_tck_clocks_group_created 1
  }
  # Relaxing IJTAG select signals
  set_multicycle_path -setup [expr 2 + (3 * $tessent_extra_control_setup_hold_cycles)] \
      -from [tessent_get_cells $scan_resource_sib_list] 
  set_multicycle_path -hold [expr 2 + (5 * $tessent_extra_control_setup_hold_cycles)] \
      -from [tessent_get_cells $scan_resource_sib_list] 
  if {$tessent_extra_control_setup_hold_cycles > 0} {
    # Relaxing capture/shift/update timing with extra_control_setup_hold_cycles value
    set_multicycle_path -setup [expr 1 + $tessent_extra_control_setup_hold_cycles] \
        -from [tessent_get_ports [concat  \
            {ijtag_se} \
            {ijtag_ce} \
            {ijtag_ue}]] 
    set_multicycle_path -hold [expr 2 * $tessent_extra_control_setup_hold_cycles] \
        -from [tessent_get_ports [concat  \
            {ijtag_se} \
            {ijtag_ce} \
            {ijtag_ue}]] 
  }
  # Relaxing select timing with extra_control_setup_hold_cycles value, select can already be relaxed and its setup is additionally relaxed by stretching around capture_en rising edge
  set_multicycle_path -setup [expr 2 + (3 * $tessent_extra_control_setup_hold_cycles)] \
      -from [tessent_get_ports [list {ijtag_sel}]] 
  set_multicycle_path -hold [expr 2 + (5 * $tessent_extra_control_setup_hold_cycles)] \
      -from [tessent_get_ports [list {ijtag_sel}]] 
  
}
proc tessent_set_non_modal {{logictest "on"}} {
  tessent_set_ijtag_non_modal
  tessent_set_ltest_non_modal $logictest
}
proc set_ijtag_retargeting_options {args} {  
  
    # Issue the set_ijtag_retargeting_options command from within your master timing 
    # script in order establish the settings requirements for pattern generation.
    # Tessent Shell supports the same command with the same syntax, allowing you
    # to consistently specify these settings across your simulations, synthesis 
    # and STA runs. You may want to place the calls to this command into a file
    # and source it from Tessent Shell and your synthesis/timing tools.
    array set tessent_timing_option2var_mapping {
      -tck_period tessent_tck_period
      -extra_control_setup_hold_cycles tessent_extra_control_setup_hold_cycles
      -default_scan_out_strobe_point tessent_default_scan_out_strobe_point
      -extra_tms_setup_hold_cycles tessent_extra_tms_setup_hold_cycles
      -extra_reset_setup_hold_cycles tessent_extra_reset_setup_hold_cycles
      -hb_ijtag_tck_period tessent_hb_ijtag_tck_period
      -hb_ijtag_extra_control_setup_hold_cycles tessent_hb_ijtag_extra_control_setup_hold_cycles
    }
    foreach key [array names tessent_timing_option2var_mapping] {
      global [subst $tessent_timing_option2var_mapping($key)]
    }
    # Parse options, assuming default value from tessent_set_default_variables.
    foreach {key value} $args {
      if {![info exists tessent_timing_option2var_mapping($key)]} {
        set warning_list [list]
        lappend warning_list "Tessent SDC Warning: The option '$key' is not supported by the SDC version of set_ijtag_retargeting_options."
        lappend warning_list "                     Supported arguments are: [join [lsort [array get tessent_timing_option2var_mapping]]{, }]."
        puts [join $warning_list "\n"]
        continue
      }
      if {$key in [list -tck_period -hb_ijtag_tck_period]} {
        #get only the number from -tck_period
        set value [regexp -inline {^[0-9]+(?:.[0-9]+)?} $value]
      }
      set [subst $tessent_timing_option2var_mapping($key)] $value
    }
  
}
proc tessent_set_ltest_set_timing_variables_default {} {  
  
  global tessent_slow_clock_period
  global tessent_shift_clock_edge1_percentage
  global tessent_shift_clock_edge2_percentage
  global tessent_force_pi_percentage
  global tessent_measure_po_percentage
  global tessent_scan_input_delay
  global tessent_scan_output_delay
  global tessent_edt_channel_in_ports_list
  global tessent_edt_channel_out_ports_list
  
  global tessent_scan_en_setup_extra_cycles
  global tessent_scan_en_hold_extra_cycles
  global tessent_edt_update_setup_extra_cycles
  global tessent_edt_update_hold_extra_cycles
  
  
  set tessent_slow_clock_period       40.
  # The following variable settings reflect the default fastscan timeplate specifications:
  #     timeplate gen_tp1 =
  #        force_pi 0 ;
  #        measure_po 10 ;
  #        pulse_clock 20 10 ;
  #        period 40 ;
  #     end;
  # Please adjust these numbers according to your own settings.
  set tessent_shift_clock_edge1_percentage 50.
  set tessent_shift_clock_edge2_percentage 75.
  set tessent_force_pi_percentage          0.
  set tessent_measure_po_percentage        25.
  set tessent_scan_input_delay             0.
  set tessent_scan_output_delay            0.
  
  # Default dead cycles values for both scan_enable and edt_update signals.
  # WARNING: If you change these defaults, make sure that the new values match your
  # test_proc specifications once creating your ATPG test patterns.
  set tessent_scan_en_setup_extra_cycles    0
  set tessent_scan_en_hold_extra_cycles     0
  set tessent_edt_update_setup_extra_cycles 0
  set tessent_edt_update_hold_extra_cycles  0
  
  set tessent_edt_channel_in_ports_list {
    {msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_in[0]}
    {msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_in[1]}
  }
  set tessent_edt_channel_out_ports_list {
    {msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_out[0]}
    {msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_out[1]}
  }
  
  
}
proc tessent_set_ltest_create_clocks {} {  
  
  global time_unit_multiplier
  
  global tessent_slow_clock_period
  global tessent_shift_clock_edge1_percentage
  global tessent_shift_clock_edge2_percentage
  global tessent_force_pi_percentage
  global tessent_measure_po_percentage
  
  
  set slow_clock_period   [expr $tessent_slow_clock_period * $time_unit_multiplier]
  set sc_rise_time        [expr $tessent_shift_clock_edge1_percentage/100. * $slow_clock_period]
  set sc_fall_time        [expr $tessent_shift_clock_edge2_percentage/100. * $slow_clock_period]
  set sc_waveform         "$sc_rise_time $sc_fall_time"
  set force_pi_rise       [expr $tessent_force_pi_percentage/100.   * $slow_clock_period]
  set measure_po_rise     [expr $tessent_measure_po_percentage/100. * $slow_clock_period]
  set min_width           [expr 0.25 * $slow_clock_period]
  set force_pi_waveform   "$force_pi_rise   [expr $force_pi_rise   + $min_width]"
  set measure_po_waveform "$measure_po_rise [expr $measure_po_rise + $min_width]"
  
  # test_clock:
    create_clock [tessent_get_ports test_clock_w] \
      -add -period $slow_clock_period -waveform $sc_waveform \
      -name tessent_test_clock
  
  # Virtual force_pi clock, to comply with your timeplate "force_pi" specifications
    create_clock \
      -period $slow_clock_period -waveform $force_pi_waveform \
      -name tessent_virtual_force_pi
  
  # Virtual measure_po clock, to comply with your timeplate "measure_po" specifications
    create_clock \
      -period $slow_clock_period -waveform $measure_po_waveform \
      -name tessent_virtual_measure_po
  
  
}
proc tessent_set_ltest_non_modal {{logictest on}} {  
  
  global tessent_edt_mapping
  global scan_en_port_name
  global tessent_scan_en_setup_extra_cycles tessent_scan_en_hold_extra_cycles
  global edt_update_port_name
  global tessent_edt_update_setup_extra_cycles tessent_edt_update_hold_extra_cycles
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_lbist_shift_clock_src
  global tessent_clock_mapping
  
  
  if {$logictest eq "off"} {
    tessent_set_ltest_disable all_test_x
    return
  }
  if {![info exists tessent_lbist_shift_clock_src(lbist_inst0)] || [sizeof_collection [tessent_get_clocks $tessent_lbist_shift_clock_src(lbist_inst0) -quiet]] == 0} {
    puts "Tessent SDC Error: LBIST controller '$tessent_lbist_mapping(lbist_inst0)' shift_clock_src clock should be created by user and its name passed through \$tessent_lbist_shift_clock_src(lbist_inst0)."
    return -code error
  }
  
  # Create ltest slow clocks
  tessent_set_ltest_create_clocks
  
  # Block tck propagation to core
  create_generated_clock -source [tessent_get_clock_source $tessent_lbist_shift_clock_src(lbist_inst0)] \
                         -divide_by 1 \
                         -name tessent_lbist_shift_clock_src_to_core0 \
                         -add -master_clock $tessent_lbist_shift_clock_src(lbist_inst0) \
                         -combinational \
                         [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_capture_clock_gater_i/GCK]
  create_generated_clock -source [tessent_get_clock_source tessent_test_clock] \
                         -divide_by 1 \
                         -name tessent_shift_capture_clock_to_core0 \
                         -add -master_clock tessent_test_clock \
                         -combinational \
                         [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_capture_clock_gater_i/GCK]
  
  set_clock_groups -physically_exclusive -name tessent_lbist_block_tck_0 \
                  -group tessent_lbist_shift_clock_src_to_core0 \
                  -group tessent_shift_capture_clock_to_core0 \
  
  set_clock_groups -asynchronous -name tessent_lbist -group [list $tessent_lbist_shift_clock_src(lbist_inst0) tessent_lbist_shift_clock_src_to_core0]
   
  # Slow logic bist clocks are asynchronous to all other clocks, with LBIST logic
  set_clock_groups -asynchronous -name ltest_clocks \
                   -group [list tessent_virtual* tessent_test_clock tessent_shift_capture_clock_to_core0]
  
  # Constrain ltest ports
  tessent_set_ltest_set_pin_delays
  
  
  # scan_enable
  # You can time your scan_enable and edt_update signals by leaving them toggling in
  # synthesis/layout, at the cost of enabling many shift_clock-based false capture paths.
  # Otherwise, you can tie your scan_enable to its inactive value in your master script.
  set setup [expr $tessent_scan_en_setup_extra_cycles+1]
  set hold  [expr $tessent_scan_en_setup_extra_cycles + $tessent_scan_en_hold_extra_cycles]
  set_multicycle_path -setup $setup -from [tessent_get_ports $scan_en_port_name]
  set_multicycle_path -hold  $hold  -from [tessent_get_ports $scan_en_port_name]
  
  # edt_update
  set setup [expr $tessent_edt_update_setup_extra_cycles+1]
  set hold  [expr $tessent_edt_update_setup_extra_cycles + $tessent_edt_update_hold_extra_cycles]
  set_multicycle_path -setup $setup -from [tessent_get_ports $edt_update_port_name]
  set_multicycle_path -hold  $hold  -from [tessent_get_ports $edt_update_port_name]
  
  # Relax clock mux timing in On-Chip clock controllers (OCCs)
  tessent_set_ltest_occ
  
  # This OCC path is only valid in scan shift mode
  set  non_scan_clocks [remove_from_collection [all_clocks] [tessent_get_clocks "tessent_virtual* tessent_test_clock tessent_shift_capture_clock_to_core0 tessent_lbist_shift_clock_src_to_core0"]]
  if {[sizeof_collection $non_scan_clocks]} {
    set_false_path -from $non_scan_clocks -to [tessent_get_cells {
      msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/occ_control/scan_out*
    }]
    set_false_path -to $non_scan_clocks -from [tessent_get_cells {
      msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/occ_control/scan_out*
    }]
    set_false_path -from $non_scan_clocks -through [tessent_get_pins {
      msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_scan_in_buf/Z
    }]
  }
  
  # Mask registers are setup with TCK and static during test
  set_false_path -from [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_controller_i/edt_chain_mask*reg*] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  
  
  # LBIST scan enable
  set_multicycle_path -setup 8 \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/B]
  set_multicycle_path -hold 7 \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/B]
  
  # LBIST dynamic control signals
  set_multicycle_path -setup 8 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  set_multicycle_path -hold 7 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  set_multicycle_path -setup 8 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  set_multicycle_path -hold 7 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  
  # LBIST synchronous reset
  set_multicycle_path -setup 3 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  set_multicycle_path -setup 3 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_sync_reset_reg] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_sync_reset_reg] \
      -to [remove_from_collection [all_clocks] $tessent_clock_mapping(ts_tck_ijtag_tck)]
  
  # LBIST controller clock multiplexers
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  
}
proc tessent_set_ltest_occ {{mode all}} {  
  global tessent_timing_tool
  
  # Prevent tck propagation to functional domains
  set_disable_timing [tessent_get_pins {
    msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_inject_tck_mux/B
  }]
  
  # Muxes that switch long before logic test runs
  set_disable_clock_gating_check [tessent_get_cells {
    msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_inject_tck_mux
  }]
  
  # Scan_en toggles these OCC mux 'select' pin between load_unload and capture phases. 
  # Because their fast clock 'input0' pin is tied to zero during the switch, such  
  # mux end-up behaving like AND gates (scan_en & test_clock) and can be timed that way,
  # with a 'set_clock_gating_check -high' command.
  # For modes where the scan_en is constrained, we can disable clock gating check on these OCC mux.
  set mux_coll [tessent_get_cells {
    msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_clock_out*_mux
    msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/occ_control/tessent_persistent_cell_SHIFT_REG_CLK*_mux
  }]
  foreach_in_collection mux $mux_coll {
    # Skip over RTL cells
    if {$tessent_timing_tool in {dc_shell pt_shell} && [get_attribute $mux is_hierarchical] eq "true"} {
        continue
    } elseif {$tessent_timing_tool in {genus encounter} && [get_property $mux obj_type] eq "hinst" } {
        continue
    }
    if {$mode in {lbist_single_chain}} {
        set_disable_clock_gating_check $mux
    } else {
        set_clock_gating_check -high $mux
    }
  }
  
  
}
proc tessent_set_ltest_modal_shift {} {  
  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global scan_en_port_name
  
  # Create clocks and set input/output delays for ports
  tessent_set_ltest_create_clocks 
  # Set input/output delays for ports
  tessent_set_ltest_set_pin_delays
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  # Turn off LogicBist controller.
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  
  # Disable paths from LBIST controller to EDT blocks not used in shift
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]
  
  # LBIST controller chain disable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Forcing scan_en active allows timing all shift paths 
  # while blocking all intra or inter domain capture paths.
  set_case_analysis 1 [tessent_get_ports $scan_en_port_name]
  
  # Relax clock mux timing in On-Chip clock controllers (OCCs)
  tessent_set_ltest_occ
  
  
  # Mask registers are setup with TCK and static during test
  set_false_path -from [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_controller_i/edt_chain_mask*reg*]
  
  # EDT controller chain mode enable
  set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  
  # LBIST controller clock multiplexers
  set_case_analysis 1            [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  
}
proc tessent_set_ltest_modal_edt_fast_capture {} {  
  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ
  global tessent_regQB
  global scan_en_port_name
  
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  # Control test points timing fanout is always slow speed.
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_control_test_point_en/Z]
  
  # Define each variable below to match your final ATPG settings in fast capture mode.
  # By default, all possible capture paths are covered.
  global mcp_bounding_en_value
  if {[info exists mcp_bounding_en_value]} {
    set_case_analysis $mcp_bounding_en_value [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_mcp_bounding_en/Z]
  }
  global x_bounding_en_value
  if {[info exists x_bounding_en_value]} {
    set_case_analysis $x_bounding_en_value [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_x_bounding_en/Z]
  }
  global observe_test_point_en_value
  if {[info exists observe_test_point_en_value]} {
    set_case_analysis $observe_test_point_en_value [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_observe_test_point_en/Z]
  }
  global async_set_reset_static_disable_value
  if {[info exists async_set_reset_static_disable_value]} {
    set_case_analysis $async_set_reset_static_disable_value [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_async_set_reset_static_disable/Z]
  }
  
  # Turn off LogicBist controller.
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  
  # Disable single chain mode concatenation
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  # LBIST controller chain disable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Block all shift-only paths
  set_case_analysis 0 [tessent_get_ports $scan_en_port_name]
  
  # Relax clock mux timing in On-Chip clock controllers (OCCs)
  tessent_set_ltest_occ
  
  # Define the 'tessent_block_edt_bypass_in_fast_capture' global variable in your calling script
  # if you want to block the chain concatenation timing paths, which may exist at-speed if
  # the destination chain SI flop keeps shifting during capture. That should normally not happen
  # when using Tessent scan insertion tools, but if these paths do exist in your design
  # and you don't intend running edt_bypass mode along with fast_capture, then apply the
  # constraints below.
  global tessent_block_edt_bypass_in_fast_capture
  if {[info exists tessent_block_edt_bypass_in_fast_capture]} {
    # edt_inst0.edt_bypass:
      set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_edt_bypass_buf/Z]
    # edt_inst0.edt_single_bypass_chain:
      set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_edt_single_bypass_chain_buf/Z]
  }
  
  # edt_inst0.channels_out*:
    set_false_path -through [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_edt_channels_out_*_buf/Z]
  
  # EDT controller chain mode enable
  set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  
  
}
proc tessent_set_ltest_modal_edt_slow_capture {} {  
  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ
  global tessent_regQB
  global tessent_scan_input_delay tessent_scan_output_delay
  global scan_en_port_name
  global tessent_scan_en_setup_extra_cycles tessent_scan_en_hold_extra_cycles
  global edt_update_port_name
  global tessent_edt_update_setup_extra_cycles tessent_edt_update_hold_extra_cycles
  
  # Create clocks and set input/output delays for ports
  tessent_set_ltest_create_clocks 
  # Set input/output delays for ports
  set scan_inports   [remove_from_collection [all_inputs] [tessent_get_ports {test_clock_w clk lbist_shift_clk ijtag_tck ijtag_reset ijtag_ce ijtag_se ijtag_ue ijtag_sel ijtag_si test_clock_w}]]
  set_input_delay  $tessent_scan_input_delay   -clock tessent_virtual_force_pi $scan_inports
  set scan_outports  [remove_from_collection [all_outputs] [tessent_get_ports ijtag_so]]
  set_output_delay  $tessent_scan_output_delay  -clock tessent_virtual_measure_po $scan_outports
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  # Turn off LogicBist controller.
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  
  # Disable single chain mode concatenation
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  # LBIST controller chain disable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # In slow capture mode, tessent_test_clock propagates to all your scan flops, through sub-trees made of
  # your individual functional clock domains. Depending on whether your layout tool has balanced your
  # whole test_clock fanout and whether you want to declare some clock domain combinations as compatible,
  # you may or may not have to relax the hold for some capture paths. This edt_slow_capture proc assumes
  # you don't want to stress the hold across any domain, so it adds a 1-cycle hold margin for all
  # same-edge test_clock timing paths. Retimed paths are not relaxed: those might represent either
  # cross-domain scan lockup latches or intentionally retimed capture cross-domain paths.
  # Setup check is always preserved as one cycle of tessent_test_clock.
  # Set the following variable to 1 in your master SDC script if you want to skip that hold MCP:
  global tessent_time_hold_in_slow_capture
  if {!([info exists tessent_time_hold_in_slow_capture] && $tessent_time_hold_in_slow_capture == 1)} {
    set_multicycle_path -hold 1 -rise_from [tessent_get_clocks tessent_test_clock] -rise_to [tessent_get_clocks tessent_test_clock]
    set_multicycle_path -hold 1 -fall_from [tessent_get_clocks tessent_test_clock] -fall_to [tessent_get_clocks tessent_test_clock]
  }
  
  # scan_enable
  set setup [expr $tessent_scan_en_setup_extra_cycles+1]
  set hold  [expr $tessent_scan_en_setup_extra_cycles + $tessent_scan_en_hold_extra_cycles]
  set_multicycle_path -setup $setup -from [tessent_get_ports $scan_en_port_name]
  set_multicycle_path -hold  $hold  -from [tessent_get_ports $scan_en_port_name]
  
  # edt_update
  set setup [expr $tessent_edt_update_setup_extra_cycles+1]
  set hold  [expr $tessent_edt_update_setup_extra_cycles + $tessent_edt_update_hold_extra_cycles]
  set_multicycle_path -setup $setup -from [tessent_get_ports $edt_update_port_name]
  set_multicycle_path -hold  $hold  -from [tessent_get_ports $edt_update_port_name]
  
  # Relax clock mux timing in On-Chip clock controllers (OCCs)
  tessent_set_ltest_occ
  
  
  # Mask registers are setup with TCK and static during test
  set_false_path -from [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_controller_i/edt_chain_mask*reg*]
  
  # EDT controller chain mode enable
  set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Paths from LBIST controller to MISR are false
  set_false_path -from [tessent_get_cells [list $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg]] \
      -to [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_misr_i/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_misr_reg_i/misr*_reg*]
  set_false_path -from [tessent_get_cells [list $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]] \
      -to [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_misr_i/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_misr_reg_i/misr*_reg*]
  
  
  # LBIST controller clock multiplexers
  set_case_analysis 1            [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  
}
proc tessent_set_ltest_modal_edt_shift {} {  
  global tessent_edt_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ tessent_regQB
  
  tessent_set_ltest_modal_shift
  # edt_inst0.edt_bypass:
    set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_edt_bypass_buf/Z]
  # edt_inst0.edt_single_bypass_chain:
    set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_edt_single_bypass_chain_buf/Z]
  
  # Disable single chain mode concatenation
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  
}
proc tessent_set_ltest_modal_bypass_shift {} {  
  global tessent_edt_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ tessent_regQB
  
  tessent_set_ltest_modal_shift
  # edt_inst0.edt_bypass:
    set_case_analysis 1 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_edt_bypass_buf/Z]
  # edt_inst0.edt_single_bypass_chain:
    set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_edt_single_bypass_chain_buf/Z]
  
  # Disable single chain mode concatenation
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  
}
proc tessent_set_ltest_disable {{mode all_test_on}} {  
  
  # Invoke this proc when running modal signoff STA checks in any other modes than edt or lbist.
  # It turns all ltest-related DftSignals off and disables your logicbist controller when present.
  # It also prevents tessent_tck from propagating to functional domains.
  
  global tessent_lbist_mapping
  global tessent_clock_mapping
  
  global tessent_edt_mapping
  # Turn off all logictest-related dft_signals.
  tessent_msrv_soc_system_controllerwrapper_set_dft_signals $mode
  
  # Turn off LogicBist controller, and prevent bogus clock gating check warnings
  set_case_analysis 0            [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  # LBIST scan enable turned off
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/B]
  
  # Prevent tessent_tck from propagating to functional domains and avoid bogus clock gating check warnings.
  set_disable_timing             [tessent_get_pins  {msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_inject_tck_mux/*}]
  set_disable_clock_gating_check [tessent_get_cells {msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_clock_out*_mux}]
  
  
}
proc tessent_set_ltest_pb_external_mode {} {  
  # Call this proc after any one of the above xxx_ltest_modal_xxx procs, so as to force your core
  # in the external version of its shift, bypass, or capture mode.
  # Although our modal procs try to cover both internal and external mode paths in the same STA run,
  # the external mode constraints below might be needed when extracting your core timing model
  # for later use in your parent module flow. These constraints will prevent ambiguous timing
  # paths to affect the accuracy of your core extracted model timing arcs.
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ext_ltest_en/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_int_ltest_en/Z]
  
  
}
proc tessent_set_ltest_core_external_mode {} {  
  # This proc maintains backward-compatibility with your older timing scripts by
  # providing you with a translation from the old name:
  #    tessent_set_ltest_core_external_mode
  # to the following new name:
  
    tessent_set_ltest_pb_external_mode
  
  
}
proc tessent_set_ltest_modal_lbist_shift {{clock_select shift_clock_src}} {  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ tessent_regQB
  
  if {$clock_select in {ltest_clock edt_clock test_clock}} {
    tessent_set_ltest_create_clocks
  } elseif {$clock_select in {tck ijtag_tck}} {
    tessent_set_ijtag_non_modal
  }
  
  
  # LBIST scan enable
  set_multicycle_path -setup 8 \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/B]
  set_multicycle_path -hold 7 \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/B]
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/S]
  
  # LBIST shift enable mux
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_en_out_*mux/S]
  
  # LBIST dynamic control signals
  set_multicycle_path -setup 8 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z]
  set_multicycle_path -hold 7 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z]
  set_multicycle_path -setup 8 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z]
  set_multicycle_path -hold 7 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z]
  
  # LBIST synchronous reset
  set_multicycle_path -setup 3 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]
  
  # LBIST controller clock multiplexers
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  # LBIST clock source select
  if {$clock_select in {shift_clock_src}} {
    set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_1_buf/Z]
  } elseif {$clock_select in {ltest_clock edt_clock test_clock}} {
    set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_1_buf/Z]
    set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_0_buf/Z]
  } elseif {$clock_select in {tck ijtag_tck}} {
    set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_1_buf/Z]
    set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_0_buf/Z]
  }
  
  # LBIST enable
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  
  # LBIST static control signals
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_en_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_setup_reg*]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_run_mode_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_low_power_shift_en_reg]
  
  # LBIST controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Disable single chain mode concatenation
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  # Single chain mode logic controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  # Prevent tck injection to functional domains through OCC
  if {$clock_select in {tck ijtag_tck}} {
    set_disable_timing [tessent_get_pins {
      msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_inject_tck_mux/B
    }]
  }
  
  # Set the inject_tck muxes to not propagate clock from ijtag_tck pin 
  if {$clock_select in {tck ijtag_tck}} {
    set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_inject_tck_mux/S] 
  }
  
  # Mask registers are setup with TCK and static during test
  set_false_path -from [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_controller_i/edt_chain_mask*reg*]
  
  # EDT controller chain mode enable
  set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  
}
proc tessent_set_ltest_modal_lbist_capture {{clock_select shift_clock_src}} {  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ tessent_regQB
  
  if {$clock_select in {ltest_clock edt_clock test_clock}} {
    tessent_set_ltest_create_clocks
  } elseif {$clock_select in {tck ijtag_tck}} {
    tessent_set_ijtag_non_modal
  }
  
  
  # LBIST scan enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/B]
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/S]
  
  # LBIST shift enable mux
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_en_out_*mux/S]
  
  # LBIST capture enable
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/capture_en_reg]
  
  # LBIST dynamic control signals
  set_multicycle_path -setup 8 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z]
  set_multicycle_path -hold 7 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z]
  set_multicycle_path -setup 8 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z]
  set_multicycle_path -hold 7 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z]
  
  # LBIST synchronous reset
  set_multicycle_path -setup 3 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]
  set_multicycle_path -hold 2 \
      -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]
  
  # LBIST controller clock multiplexers
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  # LBIST clock source select
  if {$clock_select in {shift_clock_src}} {
    set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_1_buf/Z]
  } elseif {$clock_select in {ltest_clock edt_clock test_clock}} {
    set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_1_buf/Z]
    set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_0_buf/Z]
  } elseif {$clock_select in {tck ijtag_tck}} {
    set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_1_buf/Z]
    set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_clock_select_0_buf/Z]
  }
  
  # LBIST enable
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  
  # LBIST static control signals
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_en_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_setup_reg*]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_run_mode_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_low_power_shift_en_reg]
  
  # LBIST controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Disable single chain mode concatenation
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  # Single chain mode logic controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Relax clock mux timing in On-Chip clock controllers
  tessent_set_ltest_occ lbist_capture
  # Set the inject_tck muxes to not propagate clock from ijtag_tck pin 
  if {$clock_select in {tck ijtag_tck}} {
    set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/tessent_persistent_cell_inject_tck_mux/S] 
  }
  
  # Mask registers are setup with TCK and static during test
  set_false_path -from [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_controller_i/edt_chain_mask*reg*]
  
  # EDT controller chain mode enable
  set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  
}
proc tessent_set_ltest_modal_lbist_setup {} {  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ tessent_regQB
  
  tessent_set_ijtag_non_modal
  
  
  # LBIST dynamic control signals
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z]
  
  # LBIST synchronous reset
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_sync_reset_reg]
  
  # LBIST controller clock multiplexers
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  # LBIST enable
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  
  # Block clock propagation to scan cells
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_capture_clock_gater_i/GCK]
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_test_clock_out_gater_i/GCK]
  
  # LBIST static control signals
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_low_power_shift_en_reg]
  
  # LBIST controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Disable single chain mode concatenation
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  # Single chain mode logic controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Relax clock mux timing in On-Chip clock controllers
  tessent_set_ltest_occ lbist_setup
  
  # EDT controller chain mode enable
  set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  
}
proc tessent_set_ltest_modal_lbist_single_chain {} {  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_regQ tessent_regQB
  
  tessent_set_ijtag_non_modal
  
  
  # LBIST scan enable
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/B]
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_scan_en_out_*mux/S]
  
  # LBIST shift enable mux
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_en_out_*mux/S]
  
  # LBIST dynamic control signals
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/prpg_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_prpg_en/Z]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/misr_en_reg] \
      -through [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_misr_en/Z]
  
  # LBIST synchronous reset
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_reset_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_sync_reset_reg]
  
  # LBIST controller clock multiplexers
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  # LBIST enable
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_lbist_en_buf/Z]
  
  # LBIST static control signals
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_en_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_setup_reg*]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/lbist_run_mode_reg]
  set_false_path -from [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i/lbist_low_power_shift_en_reg]
  
  # LBIST controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Enable single chain mode concatenation
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_tdr_single_bypass*_buf/Z]
  
  # Single chain mode logic controller chain enable
  set_case_analysis 0 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Relax clock mux timing in On-Chip clock controllers
  tessent_set_ltest_occ lbist_single_chain
  
  # Mask registers are setup with TCK and static during test
  set_false_path -from [tessent_get_cells $tessent_edt_mapping(edt_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_controller_i/edt_chain_mask*reg*]
  
  # EDT controller chain mode enable
  set_case_analysis 0 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  
}
proc tessent_set_ltest_modal_lbist_controller_chain {} {  
  global tessent_edt_mapping
  global tessent_lbist_mapping
  global tessent_lbist_single_chain_mode_logic_mapping
  global tessent_scan_input_delay tessent_scan_output_delay
  global tessent_clock_mapping
  
  tessent_set_ijtag_non_modal
  
  tessent_set_ltest_set_pin_delays 1
  
  # LBIST controller clock multiplexers
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux/S]
  set_disable_clock_gating_check [tessent_get_cells $tessent_lbist_mapping(lbist_inst0)/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i/tessent_persistent_cell_*_mux]
  
  # Block clock propagation to scan cells
  set_disable_timing [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_shift_capture_clock_gater_i/GCK]
  
  # LBIST controller chain enable
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Single chain mode logic controller chain enable
  set_case_analysis 1 [tessent_get_pins $tessent_lbist_single_chain_mode_logic_mapping(lbist_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  # Relax clock mux timing in On-Chip clock controllers
  tessent_set_ltest_occ lbist_controller_chain
  
  # EDT controller chain mode enable
  set_case_analysis 1 [tessent_get_pins $tessent_edt_mapping(edt_inst0)/tessent_persistent_cell_ccm_en_buf/Z]
  
  
  set_case_analysis 1 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]
  
  
}
proc tessent_set_ltest_set_pin_delays {{controller_chain_mode 0}} {  
  
  global tessent_scan_input_delay tessent_scan_output_delay
  global scan_en_port_name edt_update_port_name
  global tessent_clock_mapping
  
  if {$controller_chain_mode} {
    set fpi_clock_name $tessent_clock_mapping(ts_tck_ijtag_tck)
    set mpo_clock_name $tessent_clock_mapping(ts_tck_ijtag_tck)
  } else {
    set fpi_clock_name tessent_virtual_force_pi
    set mpo_clock_name tessent_virtual_measure_po
  }
  # scan_enable
    set_input_delay  $tessent_scan_input_delay -add -clock $fpi_clock_name [tessent_get_ports $scan_en_port_name]
  
  # edt_update
    set_input_delay  $tessent_scan_input_delay -add -clock $fpi_clock_name [tessent_get_ports $edt_update_port_name]
  
  
  global tessent_edt_channel_in_ports_list
  global tessent_edt_channel_out_ports_list
  
  foreach port $tessent_edt_channel_in_ports_list {
    set_input_delay $tessent_scan_input_delay  -add -clock $fpi_clock_name [tessent_get_ports $port]
  }
  foreach port $tessent_edt_channel_out_ports_list {
    set_output_delay $tessent_scan_output_delay -add -clock $mpo_clock_name [tessent_get_ports $port]
  }
  
  
}
proc tessent_get_cts_skew_groups_dict {} {  
  
  # This proc returns a dictionary of information for clock tree synthesis.
  # Use it in your CTS script, along with your proper tool commands.
  # CTS stop pins indicate clock endpoints to be balanced during CTS.
  # CTS exclude pins indicate branches of a clock tree that should be excluded from CTS.
  # CTS root pins indicate points at which new CTS clock trees should be started.
  #   The CTS root pins listed for a specific SSH instance should all be included in the
  #   same skew group so that this group of clocks is balanced together.
  # In Synopsys ICC, invoke:
  #     set_clock_tree_exceptions -stop_pins    <stop_pin>
  #     set_clock_tree_exceptions -exclude_pins <exclude_pin>
  # In Cadence Innovus, invoke:
  #     modify_ccopt_skew_group -add_sinks <stop_pin>  -skew_group <group_name>
  #     create_ccopt_skew_group -sources <exclude_pin> -auto_sinks -skew_group <group name>
  # The effect of these commands is:
  # * In the OCC we add exclude_pins to prevent adding delay buffers to the small OCC internal clock tree, due to
  #   balancing with all flops in the OCC fanout, therefore helping the OCC clock enable signals meet setup timing.
  #
  # You can use the dictionary the following way:
  #    set cts_skew_groups_dict [tessent_get_cts_skew_groups_dict]
  #    dict for {skew_group sub_dict} $cts_skew_groups_dict {
  #      dict with sub_dict {
  #        foreach pin $cts_exclude_pins {
  #           puts "$skew_group : $dc_instance/$pin"
  #           <insert your CTS command here>
  #        }
  #        foreach pin $cts_stop_pins {
  #           puts "$skew_group : $dc_instance/$pin"
  #           <insert your CTS command here>
  #        }
  #      }
  #      unset -nocomplain cts_exclude_pins cts_stop_pins
  #    }
  set return_dict {
    cts_skew_group(occ0) {
      dc_instance      msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst
      cts_exclude_pins {occ_control/tessent_persistent_cell_ltest_ntc_sync_cell/clk occ_control/tessent_persistent_cell_cgc_SHIFT_REG_CLK/CK occ_control/tessent_persistent_cell_SHIFT_REG_CLK_mux/B}
    }
  }
  return $return_dict
  
  
}
proc tessent_msrv_soc_system_controllerwrapper_set_dft_signals {{mode reset}} {
#
# Force all dft_signal sources to either their reset or all_test value when applicable.
#   argument mode :== reset | all_test_on | all_test_x
#
  set_case_analysis 0 [tessent_get_ports scan_en_w]
  set_case_analysis 0 [tessent_get_ports edt_update]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_async_set_reset_static_disable/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_mcp_bounding_en/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_control_test_point_en/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_observe_test_point_en/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_x_bounding_en/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ext_mode/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_int_mode/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ext_ltest_en/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_int_ltest_en/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_controller_chain_mode/Z]
  set_case_analysis 0 [tessent_get_pins msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst/tessent_persistent_cell_ltest_en/Z]

}
proc tessent_get_cells {path_list args} {
  set actualArgs [list]
  set silent 0
  set cell_col {}
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    lappend actualArgs $argValue
  }
  if { [llength $path_list] == 0 && [lsearch $actualArgs "-of_objects"] > -1 } {
    set cell_col_tmp [get_cells {*}$actualArgs -quiet]
    if {[sizeof_collection $cell_col_tmp] > 0} {
      append_to_collection cell_col $cell_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC Warning: Cell was not found using $actualArgs"
    }
  }
  # Quietly try verilog syntax first. If not found, try VHDL remapping
  foreach path $path_list {
    set cell_col_tmp [get_cells [list [tessent_map_to_verilog $path]] {*}$actualArgs -quiet]
    if { [sizeof_collection $cell_col_tmp] == 0 && [regexp {%TSSEP%} $path]} {
      # try a partially ungrouped path with known markers
      set cell_col_tmp [get_cells [list [tessent_map_to_verilog $path -mappings [list {%TSSEP%} {?}]]] {*}$actualArgs -quiet]
    }
    if { [sizeof_collection $cell_col_tmp] == 0 } {
      set cell_col_tmp [get_cells [tessent_map_to_verilog [tessent_remap_vhdl_path_list [list $path]]] {*}$actualArgs -quiet]
    }
    if { [sizeof_collection $cell_col_tmp] == 0} {
      # check if there are cells with added prefix
      regsub {(.+)(\/)(.+)$} $path {\1/*\3} expanded_path
      set cell_col_tmp [get_cells [list [tessent_map_to_verilog $expanded_path]] {*}$actualArgs -quiet]
    }
    if {[sizeof_collection $cell_col_tmp] > 0} {
      append_to_collection cell_col $cell_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC Warning: Cell was not found with pattern '${path}'"
    }
  }
  if {[sizeof_collection $cell_col] > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    return $cell_col
  } elseif {!$silent} {
    puts "Tessent SDC Error: No cell found with pattern(s) '${path_list}'"
  }
  return

}
proc tessent_get_flops {path_list args} {
  global tessent_timing_tool
  set cell_col [tessent_get_cells $path_list {*}$args]
  
  if {[sizeof_collection $cell_col] == 0} {return {}}

  switch -- $tessent_timing_tool {
    encounter {set flop_col [filter sequential true $cell_col]}
    default   {set flop_col [filter_collection $cell_col "is_sequential == true"]}
  }

  return $flop_col
 
}
proc tessent_get_pins {path_list args} {
  global tessent_timing_tool
  set pin_col {}
  set actualArgs [list]
  set silent 0
  set hierarchical ""
  set warning_list [list]
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    if { [regexp {^-hier(archical)?$} $argValue] } { set hierarchical "-hierarchical"; continue }
    lappend actualArgs $argValue
  }
  switch -- $tessent_timing_tool {
    pt_shell {set pin_name_attribute "lib_pin_name"}
    default  {set pin_name_attribute "name"}
  }
  foreach path $path_list {
    set pin_sep_index [string last / $path]
    set mapped_cells [tessent_get_cells [list [string range $path 0 [expr $pin_sep_index - 1]]] -silent {*}$hierarchical]
    if {[sizeof_collection $mapped_cells] > 0} {
      set pin_col_tmp [get_pins -of_objects $mapped_cells -filter "$pin_name_attribute =~ [string range $path [expr $pin_sep_index + 1] end]" {*}$actualArgs -quiet]
    } else {
      set pin_col_tmp {}
    }
    if {[sizeof_collection $pin_col_tmp] > 0} {
      append_to_collection pin_col $pin_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC Warning: Pin was not found with pattern '${path}'"
    }
  }
  if {[sizeof_collection $pin_col] > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    return $pin_col
  } elseif {!$silent} {
    puts "Tessent SDC Error: No pin found with pattern(s) '${path_list}'"
  }
  return

}
proc tessent_get_ports {args} {
  global tessent_timing_tool
  set actualArgs [list]
  set silent 0
  set warning_list [list]
  set port_patterns [list *]
  set argNb 1
  foreach argValue $args {
    if { $argValue eq "-silent" } { set silent 1; continue }
    if { $argNb == 1 } {
      set port_patterns $argValue
    } else {
      lappend actualArgs $argValue
    }
    incr argNb
  }
  # Quietly try verilog syntax first. If not found, try advanced remapping
  set port_col {}
  foreach port_pattern $port_patterns {
    set port_col_tmp [get_ports [list [tessent_map_to_verilog $port_pattern]] {*}$actualArgs -quiet]
    if { [sizeof_collection $port_col_tmp] == 0 } {
      set port_col_tmp [get_ports [tessent_map_to_verilog [tessent_remap_vhdl_path_list [list $port_pattern] -type ports]] {*}$actualArgs -quiet]
    } 
    if {[sizeof_collection $port_col_tmp] > 0} {
      append_to_collection port_col $port_col_tmp -unique
    } else {
      lappend warning_list "Tessent SDC Warning: Port was not found with pattern '${port_pattern}'"
    }
  }
  set sc [sizeof_collection $port_col]
  if {$sc > 0} {
    if {[llength $warning_list] > 0 && !$silent} {
      puts [join $warning_list "\n"]
    }
    if {$sc == 1 && $tessent_timing_tool eq "oasys"} {
      return [index_collection $port_col 0]
    } else {
      return $port_col
    }
  } elseif {!$silent} {
    puts "Tessent SDC Error: No port found with pattern(s) '${port_patterns}'"
  }
  return
  
}
proc tessent_map_to_verilog {path_list args} {
  global tessent_hierarchy_separator tessent_custom_mapping_regsub

  set ARGS(-mappings) [list]
  array set ARGS $args

  set mapped_paths $path_list
  if {[array size tessent_custom_mapping_regsub] > 0} {
    foreach custom_re [array names tessent_custom_mapping_regsub] {
      set mapped_paths [regsub -all $custom_re $mapped_paths $tessent_custom_mapping_regsub($custom_re)]
    }
  }
  array set map_array {
    [ ?
    ] ?
    ) ?
    ( ?
    . ?
    - ?
  }
  set map_array(%TSSEP%) $tessent_hierarchy_separator
  if {$tessent_hierarchy_separator ne "/"} {
    set map_array(/) $tessent_hierarchy_separator
  }
  if {[string is list $ARGS(-mappings)]} {
    array set map_array $ARGS(-mappings)
  }
  set mapped_paths [string map [array get map_array] $mapped_paths]

  return $mapped_paths
  
}
proc tessent_remap_vhdl_path_list {path_list args} {
  global tessent_path_cache
  set remapped_path_list [list]
  array set ARGS {
    -type cells
  }
  array set ARGS $args
  set type $ARGS(-type)
  set get_cmd "get_${type}"
  foreach path $path_list {
    # Check if we have that full path cached
    if {[info exists tessent_path_cache($path)]} {
      set pathMapped $tessent_path_cache($path)
    } else {
      set pathMapped ""
      set pathUnmapped ""
      foreach sub_path [split $path "/"] {
        if {$pathUnmapped eq ""} {
          set slash ""
        } else {
          set slash "/"
        }
        append pathUnmapped $slash $sub_path
        # Problematic paths are the following:
        #   - Paths with unrolled VHDL generate loops
        #   - non-standard change names that would trim the trailing underscore of multi-bit register names
        #   - Complex ports in some timing tools

        # Check if we have that hiercarchy cached
        if {[info exists tessent_path_cache($pathUnmapped)]} {
          set pathMapped $tessent_path_cache($pathUnmapped)
          continue
        }
        append pathMapped $slash $sub_path
        # If for port, go straight into Complex ports mapping
        if {$type eq "ports"} {
          # Some timing tools address complex identifiers like Tessent Shell: <id>.<id> 
          # Some other timing tools address those same complex construct like this <id>[<id>]
          # Try to exclude indexes from identifier as is bus was intact
          #     i.s. <id>.<id>[n] -> <id>[id][n]
          set pathMappedTemp [regsub -all {\.([^\.\[]+)} $pathMapped {[\1]}]
          if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
            set pathMapped $pathMappedTemp
            set tessent_path_cache($pathUnmapped) $pathMapped
            continue
          }
          # Try to include indexes as part of a full "escaped" identifier 
          #     i.e. <id>.<id>[n] -> <id>[<id>[n]]
          set pathMappedTemp [regsub -all {\.([^\.]+)} $pathMapped {[\1]}]
          if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
            set pathMapped $pathMappedTemp
            set tessent_path_cache($pathUnmapped) $pathMapped
            continue
          }
          # rest of the mappings are for cells
          continue
        }
        # Try verilog first on this hierarchy
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMapped]]] > 0} {
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
        # Unrolled VHDL loop from HDLE - closing bracket of a generate loop identifier was removed
        set pathMappedTemp [regsub {[\])]\.} $pathMapped {.}]
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
          set pathMapped $pathMappedTemp
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
        # Identifier that would simply have had its last character trimmed
        #   This would be an underscore, adding '?' to support some pre-mapped paths in constraints
        set pathMappedTemp [regsub {[\]\?]$} $pathMapped {}]
        if {[sizeof_collection [$get_cmd -quiet [tessent_map_to_verilog $pathMappedTemp]]] > 0} {
          set pathMapped $pathMappedTemp
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        }
      }
    }
    lappend remapped_path_list $pathMapped 
  }
  return $remapped_path_list

}
proc tessent_remove_clock_groups {group_type group_name_list} {
  global tessent_timing_tool tessent_tck_clocks_group_created
  if {!$tessent_tck_clocks_group_created} {return}
  switch -- $tessent_timing_tool {
    dc_shell  {remove_clock_groups $group_type $group_name_list; set tessent_tck_clocks_group_created 0}
    pt_shell  {remove_clock_groups $group_type -name $group_name_list; set tessent_tck_clocks_group_created 0}
    encounter {#remove_clock_groups command does not exist}
    genus     {#remove_clock_groups command does not exist}
    default   {#do not assume remove_clock_groups exists}
  }
 
}
proc tessent_get_clock_source {clk} {
  global tessent_timing_tool
  set clockSource0 ""
  switch -- $tessent_timing_tool {
    encounter {set clockSource0 [lindex [get_attribute sources [tessent_get_clocks $clk]] 0]}
    genus     {set clockSource0 [lindex [get_db [tessent_get_clocks $clk] .sources] 0]}
    default   {set clockSource0 [index_collection [get_attribute [tessent_get_clocks $clk] sources] 0]}
  }
  return $clockSource0
 
}
proc tessent_set_clock_sense_stop_propagation {clk pin} {
  global tessent_timing_tool
  if {$tessent_timing_tool in {genus encounter}} {
    set target $pin
  } else {
    set cell_name [regsub {/[^/]*$} [get_attribute $pin full_name] {}]
    set cell [tessent_get_cells $cell_name]
    if {![get_attribute $cell is_hierarchical]} {
      set target $pin
    } else {
      set target ""
      foreach_in_collection ipin [tessent_get_pins [get_attribute $cell full_name]/*/*] {
        if {[get_attribute $ipin direction] eq "in" && [get_attribute [all_connected $ipin] full_name] eq [get_attribute $pin full_name]} {
          append_to_collection target $ipin
        }
      }
      if {[sizeof_collection $target] > 0} {
        puts "Tessent SDC Note: Hierarchical pin '[get_attribute $pin full_name]' maps to libcell pin(s) [join [get_attribute $target full_name] ,]."
      } else {
        puts "Tessent SDC Error: Failed to map hierarchical pin '[get_attribute $pin full_name]' to libcell pin."
        return
      }
    }
  }
  if {$tessent_timing_tool eq "pt_shell"} {
    set_sense -type clock -clocks $clk -stop_propagation $target
  } else {
    set_clock_sense -clocks $clk -stop_propagation $target
  }
 
}
proc tessent_kill_functional_paths {{verbose OFF}} {

  global ClockSeqCellModuleRegExp ClockSeqCellInstanceRegExp
  global CreateDisabledFlopsReport
  global tessent_test_inst_regexp
  global tessent_clock_mapping tessent_unmapped_functional_clocks
  set funcFlops {}
  set mapped_functional_clocks [list]
  foreach clk $tessent_unmapped_functional_clocks {
    lappend mapped_functional_clocks $tessent_clock_mapping($clk)
  }
  if {[llength $mapped_functional_clocks] == 0} {return}
  foreach_in_collection clk [tessent_get_clocks $mapped_functional_clocks] {
      set funcFlops [add_to_collection $funcFlops [all_registers -clock $clk]]
  }
  
  set funcFlops [filter_collection $funcFlops -regexp full_name!~"$tessent_test_inst_regexp"]
  
  # Exclude memory cell instances and their collar flops
  
  set funcFlops [remove_from_collection $funcFlops [ list  ]]

  if {[sizeof_collection $funcFlops] > 0} {
    puts "\n##################### Disabling timing to all functional registers #############################"

    set use_set_disable_timing 0
 
    # Exclude clock gating sequential cells by their module name, if needed
    if [info exists ClockSeqCellModuleRegExp] {
      set excludeRegExp "ref_name=~\"${ClockSeqCellModuleRegExp}\""
      set CScells [filter_collection $funcFlops -regexp $excludeRegExp]
      puts "\nExcluding sequential clock cells instances: "
      foreach_in_collection flop $CScells {
         set flopName [get_attribute $flop full_name]
         puts "     $flopName"
      }
      set funcFlops [remove_from_collection $funcFlops $CScells]
      set use_set_disable_timing 1
    }
 
    # Exclude clock gating sequential cells by their instance name, if needed
    if [info exists ClockSeqCellInstanceRegExp] {
      set excludeRegExp "full_name=~\"${ClockSeqCellInstanceRegExp}\""
      set ClockCells [filter_collection $funcFlops -regexp $excludeRegExp]
      puts "\nExcluding instances: "
      foreach_in_collection flop $ClockCells {
         set flopName [get_attribute $flop full_name]
         puts "     $flopName"
      }
      set funcFlops [remove_from_collection $funcFlops $ClockCells]
      set use_set_disable_timing 1
    }
 
    # Disable all flops in $funcFlops
    set funcFlops [sort_collection $funcFlops full_name]
    if {$use_set_disable_timing} {
        puts "Disabling functional registers with a set_disable_timing command:"
    } else {
        puts "Disabling functional registers with a set_false_path -to command:"
    }
    foreach_in_collection flop $funcFlops {
        set flopName [get_attribute $flop full_name]
        if {$verbose == "ON"} {
            puts "Disabling register: $flopName"
        }
        if {$use_set_disable_timing} {
            set_disable_timing [tessent_get_pins $flopName/*]
        } else {
            set_false_path -to [tessent_get_cells $flopName]
        }
    }
 

    # Create report file
    if {[info exists CreateDisabledFlopsReport]} {
        puts "\ntessent_kill_functional_paths: Creating report file \"DisabledFunctionalFlops.report\". \n"
        redirect DisabledFunctionalFlops.report {
            foreach_in_collection flop $funcFlops {
                set flopName [get_attribute $flop full_name]
                puts "$flopName"
            }
        }
    }
 
  }
  
}
proc tessent_get_mem_cells {inpath} {
  set out_cells [tessent_get_cells $inpath]
  foreach_in_collection cell $out_cells {
    if {[get_attribute $cell is_hierarchical] eq "true"} {
      set cell_path [get_attribute $cell full_name]
      if {[sizeof_collection [get_cells -quiet "$cell_path/*"]]>0} {
        set out_cells [add_to_collection $out_cells [tessent_get_mem_cells "$cell_path/*"]]
      }
    }
  }
  return [filter_collection $out_cells "is_sequential==true"]
  
}
proc tessent_get_clocks {patternList args} {
  # Genus does not support more than one <pattern> for 'get_clocks <pattern>'
  set C {}
  foreach p $patternList {
    append_to_collection C [get_clocks $p {*}$args] -unique
  }
  return $C
 
}
proc tessent_get_preserve_instances {select} {
  # The 'select' argument identifies a list of instances to be returned.
  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
  #   add_core_instances
  #   scan_insertion       superset of 'add_core_instances' list
  #   icl_extract          superset of 'scan_insertion' list

  set persistent_design_instance_glob_list {
    tessent_persistent_cell_*
  }

  set scan_instrument_instance_list {
    msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_inst
  }

  set scan_related_instance_list {
  }

  set tcd_scan_instance_list {
  }

  set non_scan_instance_list {
    dut/clk_gen
    msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_tdr_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_edt_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_lbist_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_occ_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst
    msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst
  }

  set icl_design_instance_list {
  }

  set keyList [list add_core_instances scan_insertion icl_extract]
  set concatDict {
    add_core_instances { persistent_design_instance_glob_list scan_instrument_instance_list scan_related_instance_list }
    scan_insertion     { tcd_scan_instance_list non_scan_instance_list }
    icl_extract        { icl_design_instance_list }
  }
  set instanceColl {}
  # Nothing to return when 'select' is unknown
  if { [lsearch -exact $keyList $select] < 0 } {
    return $instanceColl
  }
  # Assemble a superset list depending on the 'select' value
  # based on the list of list of variables names to concatenate
  # for each 'select' value.
  foreach {validSelect concatVarnameList} $concatDict {
    foreach concatVarname $concatVarnameList {
      set getCellsArg [expr {[string match *_glob_list $concatVarname] ? "-hierarchical" : ""}]
      foreach instancePattern [set $concatVarname] {
        append_to_collection instanceColl [tessent_get_cells $instancePattern -filter {is_hierarchical==true} $getCellsArg -silent] -unique
      }
    }
    if { $select eq $validSelect } {
      break
    }
  }
  return $instanceColl

}
proc tessent_get_size_only_instances {} {
  set persistent_cell_instance_glob_list {
    tessent_persistent_cell_*
  }

  set instanceColl {}
  foreach instancePattern $persistent_cell_instance_glob_list {
    append_to_collection instanceColl [get_cells $instancePattern -filter {is_hierarchical==false} -hierarchical -quiet] -unique
  }

  return $instanceColl
}
proc tessent_get_optimize_instances {} {
  set optimize_instance_list {
    msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_bypass_logic_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_compactor_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_controller_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_decompressor_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_c1_misr_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_ctrl_signals_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_edt_sib_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_inst/msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_fsm_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/ijtag_control
    msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst/occ_control
    msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_inst/blk1_sib_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_inst/single_chain_sib_i
    msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_inst/tdr_sib_i
  }

  set instanceColl {}
  foreach instancePattern $optimize_instance_list {
    append_to_collection instanceColl [tessent_get_cells $instancePattern -silent]
  }
  return $instanceColl

}

# Provide pre-2021.2 tessent-shell plugin proc mapping to 2021.3 convention, 
# so as to maintain backward-compatibility with older customer scripts.
set tessent_old_2_new_proc_name_mapping {
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_lbist_setup tessent_set_ltest_modal_lbist_setup no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_shift tessent_set_ltest_modal_shift no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_disable tessent_set_ltest_disable yes}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_edt_shift tessent_set_ltest_modal_edt_shift no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_lbist_controller_chain tessent_set_ltest_modal_lbist_controller_chain no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_core_external_mode tessent_set_ltest_core_external_mode no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_non_modal tessent_set_ltest_non_modal yes}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_pb_external_mode tessent_set_ltest_pb_external_mode no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_edt_slow_capture tessent_set_ltest_modal_edt_slow_capture no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_edt_fast_capture tessent_set_ltest_modal_edt_fast_capture no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ijtag_non_modal tessent_set_ijtag_non_modal no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_create_clocks tessent_set_ltest_create_clocks no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_set_pin_delays tessent_set_ltest_set_pin_delays yes}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_bypass_shift tessent_set_ltest_modal_bypass_shift no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_lbist_single_chain tessent_set_ltest_modal_lbist_single_chain no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_lbist_capture tessent_set_ltest_modal_lbist_capture yes}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_occ tessent_set_ltest_occ yes}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_modal_lbist_shift tessent_set_ltest_modal_lbist_shift yes}
  {tessent_constrain_msrv_soc_system_controllerwrapper_mentor_ltest_set_timing_variables_default tessent_set_ltest_set_timing_variables_default no}
  {tessent_constrain_msrv_soc_system_controllerwrapper_non_modal tessent_set_non_modal yes}
}
foreach line $tessent_old_2_new_proc_name_mapping {
  lassign $line old_proc_name new_proc_name arguments
  if {$arguments eq "yes"} {
    proc $old_proc_name args "$new_proc_name {*}\$args"
  } else {
    proc $old_proc_name {} $new_proc_name
  }
}
    
