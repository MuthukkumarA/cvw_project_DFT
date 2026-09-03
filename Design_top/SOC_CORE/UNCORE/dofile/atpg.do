set_context patterns -scan

set_tsdb_output_directory ./TSDB

read_cell_library ../../../libs/NangateOpenCellLibrary.tcelllib ../../../libs/dft_sim.tcelllib

read_design msrv_soc_uncorewrapper -design_identifier gate2 -verbose

#read_verilog ./scan_inserted_netlist/scan_inserted_netlist.v 

set_current_design msrv_soc_uncorewrapper -show_elaboration_warnings

set_current_mode edt_int_stuck -type internal

report_dft_signals

import_scan_mode int_mode

add_black_boxes -auto

#analyze_control_signals 

#dofile ./scan_inserted_netlist/atpg_setup.dofile 

#tessent_scan_setup

check_design_rules

//delete_clocks PCLK
//add_clocks PCLK -period 2 -pulse_in_capture
//add_clocks 0 PCLK -pulse_in_capture
//set_system_mode analysis

report_clocks

add_faults -all

report_statistics -detail

create_patterns

report_statistics -detail

write_tsdb_data -replace

write_patterns patterns/msrv_soc_uncorewrapper_stuck_parallel.v -verilog -parallel -replace

set_pattern_filtering -sample_per_type 2

write_patterns patterns/msrv_soc_uncorewrapper_stuck_serial.v -verilog -serial -replace

#read_faults -mode ext_multi_stuck -fault_type stuck -merge

report_statistics -detail



