#################################################
#LBIST EDT OCC #Leo Started Working   
#################################################

set_context dft -rtl -design_identifier sys_controller

set_tsdb_output_directory TSDB

read_cell_library ../../../libs/NangateOpenCellLibrary.tcelllib 

set msrv_soc "/home1/PD07/AMuthuKKumar/DFT_SOC_PROJECT/rtl/"

set_design_sources -Y $msrv_soc/ -extension vh

#packages

read_verilog $msrv_soc/cvw.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/msrv_soc_mmu/*.sv -format sv2012 -vcs_compatibility

#generic
#it comes in unore 
read_verilog $msrv_soc/msrv_soc_generic/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_generic/msrv_soc_flop/*.sv -format sv2012 -vcs_compatibility
#read_verilog $msrv_soc/msrv_soc_generic/msrv_soc_mem/*.sv -format sv2012 -vcs_compatibility

#sys top
read_verilog $msrv_soc/msrv_soc_top/*.sv -format sv2012 -vcs_compatibility

#wrapper
read_verilog $msrv_soc/wrapper/msrv_soc_system_controllerwrapper.sv -format sv2012 -vcs_compatibility

set_current_design msrv_soc_system_controllerwrapper -show_elaboration_warnings 

set_design_level physical_block

report_dft_signal_names

add_dft_signals ltest_en 

add_dft_signals scan_en edt_update test_clock -source_node {scan_en_w edt_update test_clock_w}

add_dft_signals shift_capture_clock edt_clock -create_from_other_signals

add_dft_signals controller_chain_mode

add_dft_signals	int_ltest_en ext_ltest_en int_mode ext_mode

add_dft_signals {x_bounding_en observe_test_point_en control_test_point_en mcp_bounding_en}

report_dft_signals

set_dft_specification_requirements -logic_test on

#check_design_rules cmd i will get clk error so i defined the clock 

add_clocks [get_ports clk] -period 2ns

#add_black_boxes -auto

//check_design_rules
//  Error: The pin 'dut/clk_gen/GLITCH_FREE_CKT1/rtlcreg_q3/CP' (4885.3) source tracing stopped at pin 'dut/clk_gen/rtlcreg_counter_1/Q' (4886.0).
//         Correct the blocking conditions or use the 'add_clocks -period' if this is an embedded oscillator
//         or 'add_clocks -reference' if this is an active PLL or clock divider. (DFT_C6-1)
//  Error: The pin 'dut/clk_gen/GLITCH_FREE_CKT0/rtlcreg_q2/CP' (4880.3) source tracing stopped at pin 'dut/clk_gen/rtlcreg_counter_0/Q' (4887.0).
//         Correct the blocking conditions or use the 'add_clocks -period' if this is an embedded oscillator
//         or 'add_clocks -reference' if this is an active PLL or clock divider. (DFT_C6-2)
//  Note: There was 1 'add_dft_control_points -type async_set_reset' command inferred from DRC. Use report_dft_control_points to see it.
//  Error: There were 2 DFT_C6 violations (Clock of scannable flip-flops not properly sourced by a declared clock).
//  Error: Rules checking unsuccessful, cannot exit SETUP mode.


add_nonscan_instances -instances dut/clk_gen

check_design_rules

report_dft_control_points 
	
set spec [create_dft_specification -sri_sib_list {edt occ lbist}]
   	
report_config_data $spec 

#OCC specification given by sir.

read_config_data -in $spec -from_string { OCC { ijtag_host_interface : Sib(occ); static_clock_control : both; capture_trigger : capture_en; }}

set id_clk_list [list clk clk]

foreach {id clk} $id_clk_list {
 set occ [add_config_element OCC/controller($id) -in $spec]
 set_config_value clock_intercept_node -in $occ $clk
}

#EDT specification given by the sir.

read_config_data -in $spec -from_string {
  EDT {
    ijtag_host_interface : Sib(edt);
    Controller (c1) {
      longest_chain_range : 50, 65;
      scan_chain_count : 60;
      input_channel_count : 2;
      output_channel_count : 2;
        LogicBistOptions { 
          misr_input_ratio : 1 ;
          ShiftPowerOptions {
            present : on ;
            default_operation : disabled ;
            SwitchingThresholdPercentage {
              hardware_default : 25 ;
           }
         }
       }
    }
  }
}

report_config_data $spec

#LBIST specification given by the sir.

read_config_data -in $spec -from_string {
  LogicBist {
    ijtag_host_interface : Sib(lbist);
    Controller(1%ctrl_lbist) {
      burn_in : on ;
      pre_post_shift_dead_cycles : 8 ;
      SingleChainForDiagnosis {
        Present : on ;
      }  
      ControllerChain {
         present : on; 
         clock : tck;
      }
      Connections {
        shift_clock_src:lbist_shift_clk;
      }

      NcpOptions {
        count : 1;
      }
  
      ShiftCycles { max :800 ; }   
      CaptureCycles { max : 7; }   
      PatternCount { max : 1024; }   
      WarmupPatternCount { max : 128; }   
    }
  
   }
}


report_config_data $spec

report_dft_signal_names

process_dft_specification

#after this cmd i will get error like x bonding and warning so i add dft signals in the top.then again i will run process dft cmd.

extract_icl

set_quick_synthesis_options -complete_synthesis on

set_system_mode	analysis

write_design -output_file synthesis_sys_controller.v -replace 

write_design -output_file synthesis_sys_controller.vg -replace 



