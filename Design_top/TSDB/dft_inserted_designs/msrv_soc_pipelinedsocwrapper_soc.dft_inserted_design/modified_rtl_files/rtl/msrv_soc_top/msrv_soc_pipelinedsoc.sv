/********************************************************************************************
 Copyright 2025 - Maven Silicon Softech Pvt Ltd.
 www.maven-silicon.com

 All Rights Reserved.

 This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
 It is not to be shared with or used by any third parties who have not enrolled for our paid
 training courses or received any written authorization from Maven Silicon.

 Filename                :       msrv_soc_pipelinedsoc.sv

 Module Name             :       msrv_soc_pipelinedsoc

 Description             :       msrv_soc_pipelinedsoc consists of Instances like Core , Uncore and System Controller

 Author Name             :       Karthik, Aishwarya

 Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com"

 Version                 :       3.0 
 *********************************************************************************************/
 //Pipelined soc 
 module msrv_soc_pipelinedsoc import cvw::*; #(parameter cvw_t P)  (
  input  logic                clk, 
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
    input logic lbist_shift_clk, output wire uncore_dft_so, 
  output wire sys_ctrl_so, output wire core_dft_so, 
  input wire msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_so, 
  input wire msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst_to_select, 
  input wire msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_so, 
  input wire msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_to_select, 
  input wire ijtag_si, 
  input wire msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_to_select, 
  input wire ijtag_tck, input wire ijtag_ue, input wire ijtag_reset, 
  input wire ijtag_se, input wire ijtag_ce);

  // Uncore signals
  logic                       HRESP;            // response from AHB
  // timer and software interrupts from CLINT
  logic                       MTimerInt, MSwInt;
  logic [63:0]                MTIME_CLINT;      // from CLINT to CSRs
  logic                       MExtInt,SExtInt;  // from PLIC

  logic [P.AHBW-1:0]          HRDATAEXT;
  logic                       HREADYEXT, HRESPEXT;
  logic                       HSELEXT;

  // outputs to external memory, shared with uncore memory
  logic                       HCLK, HRESETn;
  logic [P.PA_BITS-1:0]       HADDR;
  logic [P.AHBW-1:0]          HWDATA;
  logic [P.XLEN/8-1:0]        HWSTRB;
  logic                       HWRITE;
  logic [2:0]                 HSIZE;
  logic [2:0]                 HBURST;
  logic [3:0]                 HPROT;
  logic [1:0]                 HTRANS;
  logic                       HMASTLOCK;
  logic                       HREADY;
  logic [P.AHBW-1:0]          HRDATA;           // from AHB mux in uncore


   //system controller signals

   logic                        HSELSYS_CTRL;
   logic                        HREADYSYS_CTRL;
   logic                        HRESPSYS_CTRL;

   // The logic begins here
  // instantiate processor and internal memories
  //msrv_soc_pipelinedcore #(P) core(.clk(clk),
msrv_soc_pipelinedcorewrapper core_dft(.clk(clk),
	                           .reset(reset),
                                   .MTimerInt(MTimerInt),
                                   .MExtInt(MExtInt), 
			           .SExtInt(SExtInt), 
			           .MSwInt(MSwInt), 
			           .MTIME_CLINT(MTIME_CLINT),
                                   .HRDATA(HRDATA), 
			           .HREADY(HREADY), 
			           .HRESP(HRESP), 
			           .HCLK(HCLK), 
			           .HRESETn(HRESETn), 
			           .HADDR(HADDR), 
			           .HWDATA(HWDATA), 
			           .HWSTRB(HWSTRB),
                                   .HWRITE(HWRITE), 
			           .HSIZE(HSIZE),
			           .HBURST(HBURST),
			           .HPROT(HPROT), 
			           .HTRANS(HTRANS),
			           .HMASTLOCK(HMASTLOCK),
			           .ExternalStall(ExternalStall), .ijtag_tck(ijtag_tck), 
                                       .ijtag_reset(ijtag_reset), .ijtag_ce(ijtag_ce), 
                                       .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), 
                                       .ijtag_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb1_inst_to_select), 
                                       .ijtag_si(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_so), 
                                       .ijtag_so(core_dft_so), .scan_en_w(1'b0)
                                    );

  // instantiate uncore if a bus interface exists
 // if (P.BUS_SUPPORTED) 
   // begin : uncoregen
   // msrv_soc_uncore #(P) uncore(.HCLK(HCLK),
      msrv_soc_uncorewrapper uncore_dft (.HCLK(HCLK), 
	                        .HRESETn(HRESETn), 
                                .HADDR(HADDR),
		                .HWDATA(HWDATA),
		                .HWSTRB(HWSTRB),
		                .HWRITE(HWRITE), 
		                .HSIZE(HSIZE), 
		                .HBURST(HBURST), 
		                .HPROT(HPROT), 
		                .HTRANS(HTRANS), 
		                .HMASTLOCK(HMASTLOCK), 
		                .HRDATAEXT(HRDATAEXT),
                                .HREADYEXT(HREADYEXT),
		                .HRESPEXT(HRESPEXT),
		                .HRDATA(HRDATA), 
		                .HREADY(HREADY),
		                .HRESP(HRESP), 
		                .HSELEXT(HSELEXT), 
		                .MTimerInt(MTimerInt), 
		                .MSwInt(MSwInt), 
                                .MExtInt(MExtInt), 
		                .SExtInt(SExtInt), 
		                .MTIME_CLINT(MTIME_CLINT), 
		                .out_pad_oen(out_pad_oen),
		                .out_pad_o(out_pad_o),
		                .in_pad_i(in_pad_i),
	                        .PCLK(clk_out),
		                .PRESETn(~reset), .ijtag_tck(ijtag_tck), 
                                         .ijtag_reset(ijtag_reset), .ijtag_ce(ijtag_ce), 
                                         .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), 
                                         .ijtag_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_to_select), 
                                         .ijtag_si(ijtag_si), .ijtag_so(uncore_dft_so), 
                                         .scan_en_w(1'b0));
 /*   end 
  else 
    begin
      assign {HRDATA, HREADY, HRESP, HSELEXT, MTimerInt, MSwInt, MExtInt,
	      SExtInt, MTIME_CLINT, out_pad_oen,out_pad_o} = '0; 
    end */

  //system controller

  // if(P.SYS_CTRL_SUPPORTED)
    // begin : sys_ctrl_gen
      // msrv_soc_system_controller # (.P(P),
        //                             .RANGE(P.SYS_CTRL_RANGE))
        msrv_soc_system_controllerwrapper sys_ctrl (.HSELSYS_CTRL(HSELSYS_CTRL),
                                    .HADDR(HADDR),
                                    .HWRITE(HWRITE),
                                    .HWDATA(HWDATA),
		                    .HSIZE(HSIZE),
                                    .HWSTRB(HWSTRB),
                                    .HREADY(HREADY),
                                    .HTRANS(HTRANS),
                                    .HRESPSYS_CTRL(HRESPSYS_CTRL),
                                    .HREADYSYS_CTRL(HREADYSYS_CTRL),
                                    .clk(clk),
                                    .reset_ext(reset_ext),
                                    .reset(reset),
                                    .clk_out(clk_out), .ijtag_tck(ijtag_tck), .ijtag_reset(ijtag_reset), 
                        .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), .ijtag_ue(ijtag_ue), 
                        .ijtag_sel(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb2_inst_to_select), 
                        .ijtag_si(msrv_soc_pipelinedsocwrapper_soc_tessent_sib_pb3_inst_so), 
                        .ijtag_so(sys_ctrl_so), .scan_en_w(1'b0));

    /* end
   else
     assign {HRESPSYS_CTRL, HREADYSYS_CTRL} = '0; */

			     
  // The logic ends here
endmodule