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
#       Created on: Fri Aug 28 13:52:59 IST 2026
#--------------------------------------------------------------------------

#
#  Procs table of content:
#
#    tessent_set_default_variables
#    tessent_set_ijtag_non_modal
#    tessent_set_non_modal
#    set_ijtag_retargeting_options
#    tessent_set_modal_lower_pbs
#    tessent_get_cells
#    tessent_get_flops
#    tessent_get_pins
#    tessent_get_ports
#    tessent_map_to_verilog
#    tessent_remap_vhdl_path_list
#    tessent_remove_clock_groups
#    tessent_get_clock_source
#    tessent_set_clock_sense_stop_propagation
#    tessent_get_mem_cells
#    tessent_get_clocks
#    tessent_get_preserve_instances
#    tessent_get_size_only_instances
#    tessent_get_optimize_instances
#
proc tessent_set_default_variables {} {
  global time_unit_multiplier tessent_input_delay_percentage tessent_output_delay_percentage tessent_tck_clocks_group_created scan_resource_sib_list tessent_extra_control_setup_hold_cycles tessent_extra_reset_setup_hold_cycles tessent_extra_tms_setup_hold_cycles tessent_default_scan_out_strobe_point tessent_tck_period tessent_tck_clocks_list tessent_clock_mapping tessent_hierarchy_separator tessent_path_cache tessent_timing_tool
  #
  # This proc defines the default value of the variables used in instrument timing constraints
  #

  # Time units assumed ns
  set time_unit_multiplier 1.0

  set tessent_input_delay_percentage 0.25

  set tessent_output_delay_percentage 0.25

  set tessent_tck_clocks_group_created 0

  set scan_resource_sib_list [list  \
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst/to_enable_int* \
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst/to_enable_int* \
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst/to_enable_int* \
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst/to_enable_int* \
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
proc tessent_set_non_modal {} {
  tessent_set_ijtag_non_modal
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
proc tessent_set_modal_lower_pbs {} {

# Call this proc when you run ijtag/membist/membisr/bscan (dft) STA mode and you need 
# to cover all paths between your parent Mentor dft logic and your core dft logic.
# The proc disables timing through all of your core pins except those related to mentor
# DFT, therefore killing all functional clocks within the core, so you don't
# need to deal with any in-core functional path timing violation.
#
# The remaining enabled paths go through the following core pins:
#  * ijtag scan interface pins, 
#  * lower core BISR registers interface pins
#  * embedded Bscan interface pins.
# Logictest/EDT/LogicBist paths are covered by other procs in this file.
#
# The constraints below are conditional, so they will work regardless of whether the 
# core model is loaded or not, giving you the freedom of loading only the cores you
# need at any specific moment in your flow.

# Core: dut/core_dft
if {[sizeof_collection [tessent_get_cells dut/core_dft]] > 0} {
  set core_icl_pins [tessent_get_pins {
    dut/core_dft/ijtag_ce
    dut/core_dft/ijtag_reset
    dut/core_dft/ijtag_se
    dut/core_dft/ijtag_sel
    dut/core_dft/ijtag_si
    dut/core_dft/ijtag_so
    dut/core_dft/ijtag_tck
    dut/core_dft/ijtag_ue
  }]
  if {[sizeof_collection $core_icl_pins] > 0} {
    set_disable_timing [remove_from_collection [tessent_get_pins dut/core_dft/*] $core_icl_pins]
  }
}

# Core: dut/sys_ctrl
if {[sizeof_collection [tessent_get_cells dut/sys_ctrl]] > 0} {
  set core_icl_pins [tessent_get_pins {
    dut/sys_ctrl/ijtag_ce
    dut/sys_ctrl/ijtag_reset
    dut/sys_ctrl/ijtag_se
    dut/sys_ctrl/ijtag_sel
    dut/sys_ctrl/ijtag_si
    dut/sys_ctrl/ijtag_so
    dut/sys_ctrl/ijtag_tck
    dut/sys_ctrl/ijtag_ue
  }]
  if {[sizeof_collection $core_icl_pins] > 0} {
    set_disable_timing [remove_from_collection [tessent_get_pins dut/sys_ctrl/*] $core_icl_pins]
  }
}

# Core: dut/uncore_dft
if {[sizeof_collection [tessent_get_cells dut/uncore_dft]] > 0} {
  set core_icl_pins [tessent_get_pins {
    dut/uncore_dft/ijtag_ce
    dut/uncore_dft/ijtag_reset
    dut/uncore_dft/ijtag_se
    dut/uncore_dft/ijtag_sel
    dut/uncore_dft/ijtag_si
    dut/uncore_dft/ijtag_so
    dut/uncore_dft/ijtag_tck
    dut/uncore_dft/ijtag_ue
  }]
  if {[sizeof_collection $core_icl_pins] > 0} {
    set_disable_timing [remove_from_collection [tessent_get_pins dut/uncore_dft/*] $core_icl_pins]
  }
}

# paths from SIB update stages
if {[sizeof_collection [set to_enable_int [tessent_get_cells to_enable_int* -hier -silent]]] > 0 } {
  global tessent_extra_control_setup_hold_cycles

  set_multicycle_path -setup [expr {2 + (3 * $tessent_extra_control_setup_hold_cycles)}] -from $to_enable_int
  set_multicycle_path -hold [expr {2 + (5 * $tessent_extra_control_setup_hold_cycles)}] -from $to_enable_int
}

# In all OCCs, prevent TCK from propagating to functional domains in lower cores
if {[sizeof_collection [set muxes [tessent_get_pins *inject_tck_mux/* -hierarchical -silent]]] > 0 } {
  set_disable_timing $muxes
}
# In all OCCs, skip clock gating checks on statically controlled muxes
if {[sizeof_collection [set muxes [tessent_get_cells {*clock_out_mux *ltest_clock_mux *SHIFT_REG_CLK_mux} -hierarchical -silent]]] > 0 } {
  set_disable_clock_gating_check $muxes
}

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
  }

  set scan_related_instance_list {
  }

  set tcd_scan_instance_list {
  }

  set non_scan_instance_list {
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst
    msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst
  }

  set icl_design_instance_list {
    dut/core_dft
    dut/sys_ctrl
    dut/uncore_dft
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
}

# Provide pre-2021.2 tessent-shell plugin proc mapping to 2021.3 convention, 
# so as to maintain backward-compatibility with older customer scripts.
set tessent_old_2_new_proc_name_mapping {
  {tessent_constrain_msrv_soc_pipelinedsocwrapper_mentor_ijtag_non_modal tessent_set_ijtag_non_modal no}
  {tessent_constrain_msrv_soc_pipelinedsocwrapper_non_modal tessent_set_non_modal no}
  {tessent_constrain_msrv_soc_pipelinedsocwrapper_mentor_dft_lower_cores_setup tessent_set_modal_lower_pbs}
  {tessent_constrain_msrv_soc_pipelinedsocwrapper_modal_lower_pbs tessent_set_modal_lower_pbs}
}
foreach line $tessent_old_2_new_proc_name_mapping {
  lassign $line old_proc_name new_proc_name arguments
  if {$arguments eq "yes"} {
    proc $old_proc_name args "$new_proc_name {*}\$args"
  } else {
    proc $old_proc_name {} $new_proc_name
  }
}
    
