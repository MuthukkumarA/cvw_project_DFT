import cvw::*;
`include "config.vh"
`include "parameter-defs.vh"

module msrv_soc_system_controllerwrapper (
    input  logic [P.PA_BITS-1:0] HADDR,
    input  logic                 HWRITE,
    input  logic [2:0]           HSIZE,
    input  logic [P.AHBW-1:0]    HWDATA,
    input  logic [P.XLEN/8-1:0]  HWSTRB,
    input  logic                 HREADY,
    input  logic [1:0]           HTRANS,
    output logic                 HRESPSYS_CTRL, HREADYSYS_CTRL,
    output logic                 HSELSYS_CTRL,
    input  logic                 clk,	  
    // external asynchronous reset pin
    input  logic                 reset_ext, 

    // reset synchronized to clk to prevent races on release
    output logic                reset,
    output logic                clk_out,
   //DFT addded by mk
    input logic lbist_shift_clk   , input wire ijtag_tck, 
    input wire ijtag_reset, input wire ijtag_ce, input wire ijtag_se, 
    input wire ijtag_ue, input wire ijtag_sel, input wire ijtag_si, 
    output wire ijtag_so, input wire scan_en_w, input wire edt_update, 
    input wire test_clock_w, 
    input wire [1:0] msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_in, 
    output wire [1:0] msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_out);

	
    wire msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst_so, 
         msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst_to_select, 
         msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_lbist_inst_so, 
         msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_occ_inst_so, 
         msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_edt_inst_so, 
         msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst_so, 
         msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst_to_select, 
         edt_update_inv, async_set_reset_static_disable, 
         tessent_persistent_cell_async_set_reset_dynamic_disable_ZN, GCK, 
         ext_ltest_en, ijtag_to_sel, ijtag_so_ts1, edt_bypass, ijtag_to_sel_ts1, 
         ijtag_so_ts2, ijtag_to_sel_ts2, ijtag_so_ts3, to_edt_scan_in, 
         ijtag_so_ts4, ijtag_so_ts5, to_edt_channels_in, 
         edt_single_bypass_chain_out, lbist_en, lbist_low_power_shift_en, 
         capture_en_out, shift_en_out, 
         msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_tmp_net, 
         lbist_test_clock_out, edt_update_out, edt_lbist_clock, edt_sib_en, 
         misr_accumulate_en, lbist_prpg_en, lbist_reset;
    logic clk_ts1;
    msrv_soc_system_controller #(P) dut(.*, .clk(clk_ts1));

  msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_1 msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(ijtag_sel), .ijtag_si(ijtag_si), .ijtag_ce(ijtag_ce), 
      .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), .ijtag_so(ijtag_so), 
      .ijtag_from_so(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_to_sel(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst_to_select)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_2 msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_lbist_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst_to_select), 
      .ijtag_si(ijtag_si), .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), 
      .ijtag_tck(ijtag_tck), .ijtag_so(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_lbist_inst_so), 
      .ijtag_from_so(ijtag_so_ts3), .ijtag_to_sel(ijtag_to_sel_ts2)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_2 msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_occ_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst_to_select), 
      .ijtag_si(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_lbist_inst_so), 
      .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), 
      .ijtag_so(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_occ_inst_so), 
      .ijtag_from_so(ijtag_so_ts1), .ijtag_to_sel(ijtag_to_sel)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_2 msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_edt_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst_to_select), 
      .ijtag_si(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_occ_inst_so), 
      .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), 
      .ijtag_so(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_edt_inst_so), 
      .ijtag_from_so(ijtag_so_ts2), .ijtag_to_sel(ijtag_to_sel_ts1)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_2 msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_inst_to_select), 
      .ijtag_si(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_edt_inst_so), 
      .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), 
      .ijtag_so(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst_so), 
      .ijtag_from_so(msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst_so), 
      .ijtag_to_sel(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst_to_select)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_sri_ctrl_inst_to_select), 
      .ijtag_si(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_edt_inst_so), 
      .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), 
      .async_set_reset_static_disable(async_set_reset_static_disable), .mcp_bounding_en(), 
      .control_test_point_en(), .observe_test_point_en(), .x_bounding_en(), .ext_mode(), 
      .int_mode(), .ext_ltest_en(ext_ltest_en), .int_ltest_en(), .controller_chain_mode(), 
      .ltest_en(), .ijtag_so(msrv_soc_system_controllerwrapper_sys_controller_tessent_tdr_sri_ctrl_inst_so)
  );

  OR2_X4 tessent_persistent_cell_async_set_reset_dynamic_disable(
      .A1(msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_tmp_net), 
      .A2(async_set_reset_static_disable), .ZN(tessent_persistent_cell_async_set_reset_dynamic_disable_ZN)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_occ msrv_soc_system_controllerwrapper_sys_controller_tessent_occ_clk_inst(
      .fast_clock(clk), .slow_clock(GCK), .scan_en(shift_en_out), .capture_en(capture_en_out), 
      .static_clock_control_mode(lbist_en), .clock_sequence({1'b0, 1'b0, 
      1'b0}), .shift_only_mode(ext_ltest_en), .ijtag_tck(ijtag_tck), .ijtag_reset(ijtag_reset), 
      .ijtag_sel(ijtag_to_sel), .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), 
      .ijtag_si(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_lbist_inst_so), 
      .ijtag_so(ijtag_so_ts1), .clock_out(clk_ts1), .scan_in(1'b0), .scan_out()
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1 msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_inst(
      .edt_clock(edt_lbist_clock), .edt_update(edt_update_out), .edt_bypass(edt_bypass), 
      .edt_single_bypass_chain(edt_single_bypass_chain_out), .edt_channels_in({
      msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_in[1], 
      to_edt_channels_in}), .edt_channels_out(msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_out[1:0]), 
      .edt_scan_in(), .edt_scan_out(60'b000000000000000000000000000000000000000000000000000000000000), 
      .lbist_reset(lbist_reset), .lbist_en(lbist_en), .lbist_prpg_en(lbist_prpg_en), 
      .misr_accumulate_en(misr_accumulate_en), .lbist_low_power_shift_en(lbist_low_power_shift_en), 
      .ijtag_tck(ijtag_tck), .ijtag_reset(ijtag_reset), .ijtag_sel(edt_sib_en), 
      .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ccm_en(1'b0), 
      .ccm_scan_in(1'b0), .ccm_scan_out(), .scan_en(1'b0), .ijtag_si(to_edt_scan_in), 
      .ijtag_so(ijtag_so_ts4)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_tdr msrv_soc_system_controllerwrapper_sys_controller_tessent_edt_lbist_c1_tdr_inst(
      .ijtag_reset(ijtag_reset), .ijtag_sel(ijtag_to_sel_ts1), .ijtag_si(msrv_soc_system_controllerwrapper_sys_controller_tessent_sib_occ_inst_so), 
      .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ijtag_tck(ijtag_tck), 
      .edt_bypass(edt_bypass), .ijtag_so(ijtag_so_ts2)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_inst(
      .ijtag_tck(ijtag_tck), .test_clock(test_clock_w), .shift_clock_src(lbist_shift_clk), 
      .edt_lbist_clock(edt_lbist_clock), .lbist_test_clock_out(lbist_test_clock_out), 
      .to_edt_scan_in(to_edt_scan_in), .from_edt_scan_out(ijtag_so_ts4), .ijtag_si(ijtag_so_ts5), 
      .ijtag_so(ijtag_so_ts3), .lbist_en(lbist_en), .lbist_reset(lbist_reset), 
      .edt_update_in(edt_update), .edt_update_out(edt_update_out), .ccm_en(1'b0), 
      .ccm_scan_in(1'b0), .ccm_scan_out(), .lbist_low_power_shift_en(lbist_low_power_shift_en), 
      .scan_en_in(scan_en_w), .scan_en_out(msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist_tmp_net), 
      .shift_capture_clock_out(GCK), .shift_en_out(shift_en_out), .capture_en_out(capture_en_out), 
      .lbist_prpg_en(lbist_prpg_en), .misr_accumulate_en(misr_accumulate_en), .ijtag_reset(ijtag_reset), 
      .ijtag_sel(ijtag_to_sel_ts2), .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), 
      .edt_sib_en(edt_sib_en)
  );

  msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic_inst(
      .ijtag_tck(ijtag_tck), .lbist_en(lbist_en), .ijtag_reset(ijtag_reset), .ijtag_sel(ijtag_to_sel_ts2), 
      .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), .ccm_en(1'b0), 
      .ccm_scan_out(), .scan_en(1'b0), .ccm_scan_in(1'b0), .ijtag_si(ijtag_si), 
      .edt_single_bypass_chain_in(1'b0), .edt_channels_in(msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_in[0]), 
      .edt_channels_out(msrv_soc_system_controllerwrapper_sys_controller_controller_c1_edt_channels_out[0]), 
      .ijtag_so(ijtag_so_ts5), .edt_single_bypass_chain_out(edt_single_bypass_chain_out), 
      .to_edt_channels_in(to_edt_channels_in)
  );
endmodule