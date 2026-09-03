################################
#uncore 
#LBIST EDT OCC
################################

#set_context dft -help

set_context dft -rtl -design_identifier pass2_rtl 
    
set_tsdb_output_directory TSDB
   
read_cell_library ../../../libs/NangateOpenCellLibrary.tcelllib 
    
set msrv_soc "/home1/PD07/AMuthuKKumar/DFT_SOC_PROJECT/rtl/"
    
set_design_sources -Y $msrv_soc/ -extension vh
    

#Wrappers no need to read.

#read_verilog $msrv_soc/wrapper/msrv_soc_adrdecswrapper.sv -format sv2012 -vcs_compatibility 
   
#read_verilog $msrv_soc/wrapper/msrv_soc_ahbapbbridgewrapper.sv -format sv2012 -vcs_compatibility
   
#read_verilog $msrv_soc/wrapper/msrv_soc_clint_apbwrapper.sv -format sv2012 -vcs_compatibility
   
#read_verilog $msrv_soc/wrapper/msrv_soc_gpio_apbwrapper.sv -format sv2012 -vcs_compatibility
   
#read_verilog $msrv_soc/wrapper/msrv_soc_plic_apbwrapper.sv -format sv2012 -vcs_compatibility
   
#read_verilog $msrv_soc/wrapper/msrv_soc_spi_apbwrapper.sv -format sv2012 -vcs_compatibility
  
#read_verilog $msrv_soc/wrapper/msrv_soc_uart_apbwrapper.sv -format sv2012 -vcs_compatibility
   
#read_verilog $msrv_soc/wrapper/msrv_soc_flopenlwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_flopenrwrapper.sv -format sv2012 -vcs_compatibility


#packages
   
read_verilog $msrv_soc/cvw.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/msrv_soc_uncore/*.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/msrv_soc_mmu/msrv_soc_adrdec.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/msrv_soc_mmu/msrv_soc_adrdecs.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/msrv_soc_mmu/*.sv -format sv2012 -vcs_compatibility
 	
read_verilog $msrv_soc/msrv_soc_generic/*.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/msrv_soc_generic/msrv_soc_flop/*.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/wrapper/msrv_soc_uncorewrapper.sv -format sv2012 -vcs_compatibility
 
set_current_design msrv_soc_uncorewrapper 

//-show_elaboration_warnings

set_design_level physical_block

report_dft_signal_names

add_dft_signals ltest_en 

add_dft_signals scan_en edt_update test_clock -source_node {scan_en_w edt_update test_clock_w}

add_dft_signals shift_capture_clock edt_clock -create_from_other_signals

add_dft_signals controller_chain_mode

add_dft_signals	int_ltest_en ext_ltest_en int_mode ext_mode

#add_dft_signals scan_en -source_nodes scan_en

add_dft_signals x_bounding_en observe_test_point_en control_test_point_en mcp_bounding_en

report_dft_signals

set_dft_specification_requirements -logic_test on

#check_design_rules

# If i run the check design rules then i get the errors like clock is not defined for HCLK and PCLK.
# I nedd to add the clock period for two clock.

add_clocks HCLK -period 2ns 

add_clocks PCLK -period 2ns

add_black_boxes -auto

check_design_rules

set spec [create_dft_specification -sri_sib_list {edt occ lbist}]
   	
report_config_data $spec 

#OCC specification given by sir.
//OCC { ijtag_host_interface : Sib(occ); static_clock_control : both; capture_trigger : capture_en; }}

read_config_data -in $spec -from_string { 
 OCC {
    ijtag_host_interface : Sib(occ);
    static_clock_control : both;
    capture_trigger : capture_en;
    Controller(PCLK) {
      clock_intercept_nodes : PCLK;
          }
    Controller(HCLK) {
      clock_intercept_nodes : HCLK;
    }
  }
}



set id_clk_list [list PCLK HCLK]

//foreach {id clk} $id_clk_list {
// set occ [add_config_element OCC/controller($id) -in $spec]
// set_config_value clock_intercept_node -in $occ HCLK
//}


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

process_dft_specification

#If i run the process dft specification cmd then i get scan en error and other signals i have add in the up side of my scripts as add dft signal.


extract_icl

set_quick_synthesis_options -complete_synthesis on

set_system_mode	analysis

write_design -output_file synthesis_uncore.v -replace 

write_design -output_file synthesis_uncore.vg -replace 







