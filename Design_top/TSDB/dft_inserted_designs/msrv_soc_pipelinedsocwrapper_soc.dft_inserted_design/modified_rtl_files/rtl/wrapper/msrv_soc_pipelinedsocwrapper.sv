import cvw::*;
`include "config.vh"
`include "parameter-defs.vh"

module msrv_soc_pipelinedsocwrapper (  input  logic                clk, 
  // external asynchronous reset pin
  input  logic                reset_ext,       
  // reset synchronized to clk to prevent races on release
  output logic                reset,         
  output logic                clk_out, 
  // fpga debug signals
  input  logic                ExternalStall,
  
  // I/O Interface
  input logic  [31:0]         in_pad_i,
  output logic [31:0]         out_pad_oen,
  output logic [31:0]         out_pad_o,

  //DFT addded by mk
  input logic lbist_shift_clk , input wire ijtag_tck, input wire ijtag_reset, 
                                       input wire ijtag_ce, 
                                       input wire ijtag_se, 
                                       input wire ijtag_ue, 
                                       input wire ijtag_sel, 
                                       input wire ijtag_si, 
                                       output wire ijtag_so);
  

	
    wire msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst_so, 
         uncore_dft_so, 
         msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst_to_select, 
         msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_so, sys_ctrl_so, 
         msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_so, core_dft_so, 
         msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst_to_select, 
         msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_to_select, 
         msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_to_select;
    msrv_soc_pipelinedsoc #(P) dut(.*);

  msrv_soc_pipelinedsocwrapper_soc_tessent_sib_1 msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(ijtag_sel), .ijtag_si(ijtag_si), .ijtag_ce(ijtag_ce), 
      .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), .ijtag_so(ijtag_so), 
      .ijtag_from_so(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst_so), 
      .ijtag_to_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst_to_select)
  );

  msrv_soc_pipelinedsocwrapper_soc_tessent_sib_2 msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst_to_select), 
      .ijtag_si(ijtag_si), .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), 
      .ijtag_tck(ijtag_tck), .ijtag_so(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_so), 
      .ijtag_from_so(uncore_dft_so), .ijtag_to_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_to_select)
  );

  msrv_soc_pipelinedsocwrapper_soc_tessent_sib_2 msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst_to_select), 
      .ijtag_si(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_so), .ijtag_ce(ijtag_ce), 
      .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), .ijtag_so(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_so), 
      .ijtag_from_so(sys_ctrl_so), .ijtag_to_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_to_select)
  );

  msrv_soc_pipelinedsocwrapper_soc_tessent_sib_2 msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_sri_inst_to_select), 
      .ijtag_si(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_so), .ijtag_ce(ijtag_ce), 
      .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), .ijtag_so(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst_so), 
      .ijtag_from_so(core_dft_so), .ijtag_to_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst_to_select)
  );
endmodule