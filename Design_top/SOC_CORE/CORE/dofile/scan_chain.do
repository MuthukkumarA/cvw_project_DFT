set_context dft -test_point -no_rtl -scan -design_identifier gate1

set_tsdb_output_directory ./TSDB

read_cell_library ../../../libs/NangateOpenCellLibrary.tcelllib ../../../libs/dft_sim.tcelllib

read_verilog ./synthesis_core.vg

read_design msrv_soc_pipelinedcorewrapper -design_identifier pass1_rtl -no_hdl 
 
set_current_design msrv_soc_pipelinedcorewrapper -show_elaboration_warnings

set_design_level physical_block

report_clocks

report_static_dft_signal_settings 

add_black_boxes -auto
 
#analyze_control_signals -auto

#set_test_logic -set on -clock on -reset on

#check_design_rules

set_system_mode analysis

report_dft_signals

set_xbounding_options -exclude {reset}  //this port is exclude where you can see means after the report_wrapper_cells then come back and exclude the reset

report_input_constraints

analyze_xbounding 

report_xbounding -verbose

report_xbounding -verbose -ignored_x_sources on

set_wrapper_analysis_options -exclude_ports [get_ports {*_edt_channels_*}]

analyze_wrapper_cells 

report_wrapper_cells

set_attribute_value [get_instances *tessent_single_chain_mode_logic_*] -name active_child_scan_mode -value controller_chain_mode

set_attribute_value [get_instances *tessent_lbist_inst] -name active_child_scan_mode -value controller_chain_mode

set_attribute_value [get_instances -of_modules *_edt_lbist_c1] -name active_child_scan_mode -value controller_chain_mode

set ccm [get_scan_elements -of_child_scan_modes controller_chain_mode]
  
puts ccm
   
set core [remove_from_collection [get_scan_elements] $ccm]
   
set edt_instance [get_instances -of_icl_instances [get_icl_instances -filter tessent_instrument_type==mentor::edt]]
   
add_scan_mode int_mode -edt $edt_instance -include_elements $core -enable_dft_signal int_mode
   
add_scan_mode controller_chain_mode -include_elements $ccm -chain_count 1 \
 -enable_dft_signal controller_chain_mode -si_port_format ccm_scan_in%d -so_port_format ccm_scan_out%d

add_scan_mode ext_mode -chain_count 10 -type external 

#analyze_scan_chains 

#set_scan_insertion_options -port_index_start_value 1 -si_timing any_edge -so_timing any_edge -chain_count 22 

analyze_scan_chains

report_scan_chains 
 
insert_test_logic 

report_scan_chains 

report_test_logic 

report_scan_cells 


write_design -output_file ./scan_inserted_netlist/scan_inserted_netlist.v -replace

write_atpg_setup ./scan_inserted_netlist/atpg_setup -replace



