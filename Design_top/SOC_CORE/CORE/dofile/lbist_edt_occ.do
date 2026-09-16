#################################################
#LBIST EDT OCC #Leo Started Working   
#################################################

set_context dft -rtl -design_identifier pass1_rtl

set_tsdb_output_directory TSDB

read_cell_library ../../../libs/NangateOpenCellLibrary.tcelllib 

set msrv_soc "/home1/PD07/AMuthuKKumar/DFT_SOC_PROJECT/rtl/"

#set rtl_path {}
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_cache"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ebu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_fpu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_fpu/msrv_soc_fdivsqrt"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_fpu/msrv_soc_fma"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_fpu/msrv_soc_postproc"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_generic"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_generic/msrv_soc_mem"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_generic/msrv_soc_flop"
#3set rtl_path "$rtl_path $msrv_soc/msrv_soc_hazard"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ieu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ifu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ieu/msrv_soc_aes"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ieu/msrv_soc_bmu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ieu/msrv_soc_kmu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ieu/msrv_soc_sha"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_ifu/msrv_soc_bpred"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_lsu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_mdu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_mmu/msrv_soc_tlb"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_mmu"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_privileged"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_top"
#set rtl_path "$rtl_path $msrv_soc/msrv_soc_uncore"
#set rtl_path "$rtl_path $msrv_soc/wrapper" 

#reading the header file .vh 

#if i read this then i am reading the rtl that time it is showing the syntax error
#so i am going to cmd it 

#set_design_sources -V $msrv_soc/wrapper/*.vh -extension vh
#set_design_sources -V $msrv_soc/msrv_soc_ifu/msrv_soc_bpred/*.vh -extension vh
#set_design_sources -V $msrv_soc/msrv_soc_fpu/*.vh -extension vh

#if i read the header file first then i got error so i am reading at the last after the RTL readed.
#then i got another error from that i understand first we should read set design sources

#set_design_sources -V $msrv_soc/*.vh -extension vh -vcs_compatibility

#if i use -V then i am getting the error while reading the rtl.so i am going to change to -Y and try

#if i read like this also rtl is showing error.
#set_design_sources -Y $msrv_soc/*.vh -extension vh

#SETUP> set_design_sources -V $msrv_soc/ -extension vh
#Error: /home1/PD07/AMuthuKKumar/DFT_SOC_PROJECT/rtl/ is a directory.

#now it is read properly
set_design_sources -Y $msrv_soc/ -extension vh


#packages

read_verilog $msrv_soc/cvw.sv -format sv2012 -vcs_compatibility


#fpu 

read_verilog $msrv_soc/msrv_soc_fpu/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_fpu/msrv_soc_fdivsqrt/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_fpu/msrv_soc_fma/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_fpu/msrv_soc_postproc/*.sv -format sv2012 -vcs_compatibility

#ifu

read_verilog $msrv_soc/msrv_soc_ifu/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_ifu/msrv_soc_bpred/*.sv -format sv2012 -vcs_compatibility

#ieu

read_verilog $msrv_soc/msrv_soc_ieu/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_ieu/msrv_soc_bmu/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_ieu/msrv_soc_aes/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_ieu/msrv_soc_kmu/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_ieu/msrv_soc_sha/*.sv -format sv2012 -vcs_compatibility

#lsu

read_verilog $msrv_soc/msrv_soc_lsu/*.sv -format sv2012 -vcs_compatibility

#ebu

read_verilog $msrv_soc/msrv_soc_ebu/*.sv -format sv2012 -vcs_compatibility

#hazard

read_verilog $msrv_soc/msrv_soc_hazard/*.sv -format sv2012 -vcs_compatibility

#privileged

read_verilog $msrv_soc/msrv_soc_privileged/*.sv -format sv2012 -vcs_compatibility

#mdu block

read_verilog $msrv_soc/msrv_soc_mdu/*.sv -format sv2012 -vcs_compatibility


#mmu

read_verilog $msrv_soc/msrv_soc_mmu/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_mmu/msrv_soc_tlb/*.sv -format sv2012 -vcs_compatibility

##############################################################################
#i am not reading the memory files like cache and mem (generic msrv soc mem)
###############################################################################

#cache

#read_verilog $msrv_soc/msrv_soc_cache/*.sv -format sv2012 -vcs_compatibility

#generic
#it comes in unore 
read_verilog $msrv_soc/msrv_soc_generic/*.sv -format sv2012 -vcs_compatibility
read_verilog $msrv_soc/msrv_soc_generic/msrv_soc_flop/*.sv -format sv2012 -vcs_compatibility
#read_verilog $msrv_soc/msrv_soc_generic/msrv_soc_mem/*.sv -format sv2012 -vcs_compatibility

###############################################
#if we read the cache and mem files itv shows undifined so we are creating black box for those two blocks
##############################################

#core top
read_verilog $msrv_soc/msrv_soc_top/*.sv -format sv2012 -vcs_compatibility

#wrapper
read_verilog $msrv_soc/wrapper/msrv_soc_pipelinedcorewrapper.sv -format sv2012 -vcs_compatibility

#why i am not reading the below wrapper because this wrappers are created by sir. and then next one we are deling with whole core so top wrapper is enough.
#read_verilog $msrv_soc/wrapper/msrv_soc_ifuwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_ieuwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_lsuwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_ebuwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_hazardwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_privilegedwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_mduwrapper.sv -format sv2012 -vcs_compatibility

#read_verilog $msrv_soc/wrapper/msrv_soc_fpuwrapper.sv -format sv2012 -vcs_compatibility


#add_black_boxes -modules { \
#                    msrv_soc_cache \
#                    msrv_soc_ram2p1r1wbe \			
#             }

set_current_design msrv_soc_pipelinedcorewrapper -show_elaboration_warnings 


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

add_black_boxes -auto

check_design_rules
	
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

write_design -output_file synthesis_core.v -replace 

write_design -output_file synthesis_core.vg -replace 



