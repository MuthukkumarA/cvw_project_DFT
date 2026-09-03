###########################
#SOC
###########################

set_context dft -rtl -design_identifier soc

set_tsdb_output_directory TSDB

read_cell_library ../../libs/NangateOpenCellLibrary.tcelllib 

set msrv_soc "/home1/PD07/AMuthuKKumar/DFT_SOC_PROJECT/rtl/"

open_tsdb ./core/TSDB/

open_tsdb ./uncore/TSDB/

open_tsdb ./sys_ctr/TSDB/

read_design msrv_soc_pipelinedcorewrapper -design_identifier pass1_rtl -verbose

read_design msrv_soc_uncorewrapper -design_identifier pass2_rtl -verbose

read_design msrv_soc_system_controllerwrapper -design_identifier sys_controller -verbose


read_verilog $msrv_soc/cvw.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/msrv_soc_top/msrv_soc_pipelinedsoc.sv -format sv2012 -vcs_compatibility

read_verilog $msrv_soc/wrapper/msrv_soc_pipelinedsocwrapper.sv -format sv2012 -vcs_compatibility

set_current_design msrv_soc_pipelinedsocwrapper

report_module_matching -icl

add_black_boxes -auto

set_design_level physical_block

set_quick_synthesis_options -complete_synthesis on -verbose on


add_clocks clk -period 10ns 

check_design_rules 
  
create_dft_specification 

//report_config_data $spec 
   
process_dft_specification 

#dut/lbist_shift_clk
#dut/core_dft/lbist_shift_clk

add_ijtag_logical_connection -from dut/lbist_shift_clk -to dut/sys_ctrl/lbist_shift_clk

add_ijtag_logical_connection -from dut/lbist_shift_clk -to dut/uncore_dft/lbist_shift_clk

add_ijtag_logical_connection -from dut/lbist_shift_clk -to dut/core_dft/lbist_shift_clk

add_icl_ports lbist_shift_clk -type clock

add_ijtag_logical_connection -from dut/core_dft/HCLK -to dut/uncore_dft/HCLK

add_ijtag_logical_connection -from clk -to dut/uncore_dft/HCLK

add_ijtag_logical_connection -from clk -to dut/uncore_dft/PCLK


extract_icl 

create_patterns_specification
 
process_patterns_specification

write_design -output_file ./netlist/pipelinedsoc_netlist.v -replace

write_design -output_file ./netlist/pipelinedsoc_netlist.vg -replace  

//add_ijtag_logical_connection -from dut/lbist_shift_clk -to dut/sys_ctrl/lbist_shift_clk

//dd_ijtag_logical_connection -from dut/lbist_shift_clk -to dut/uncore_dft/lbist_shift_clk

//add_ijtag_logical_connection -from dut/lbist_shift_clk -to dut/core_dft/lbist_shift_clk

#add_ijtag_logical_connection -from dut/core/HCLK -to dut/uncore_dft/HCLK

#add_ijtag_logical_connection -from clk -to dut/uncore/HCLK

#add_ijtag_logical_connection -from clk -to dut/uncore/PCLK






