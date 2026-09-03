/********************************************************************************************
 Copyright 2025 - Maven Silicon Softech Pvt Ltd.
 www.maven-silicon.com

 All Rights Reserved.

 This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
 It is not to be shared with or used by any third parties who have not enrolled for our paid
 training courses or received any written authorization from Maven Silicon.

 Filename                :       msrv_soc_system_controller.sv

 Module Name             :       msrv_soc_system_controller

 Description             :       This module contains the instances of reset synchroniser,address decoder,
	                         register bank ,clk generator and PMU

 Author Name             :       Karthik, Aishwarya

 Support e-mail          :       For any queries, reach out to us on "techsupport_vm@maven-silicon.com"

 Version                 :       3.0 
 *********************************************************************************************/

  //System Controller 
  module msrv_soc_system_controller import cvw::*;  #(parameter cvw_t P, 
                                             parameter RANGE = 6553) (
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
    input logic lbist_shift_clk   , 
    input wire tessent_persistent_cell_async_set_reset_dynamic_disable_ZN);

    logic [12:0] HSELRegions;
    logic [31:0] clk_divider_reg;
    logic [31:0] clk_shift_enb_reg;
    logic [31:0] pmu_state_config;
    // The logic begins here
    //synchronize reset to SOC clock domain
    
    wire async_set_reset_dynamic_disable_inv_ts1, resetsync_q;
    msrv_soc_reset_synchronizer resetsync(.clk(clk), 
 	                                  .d(reset_ext), 
			  	          .q(resetsync_q));

    //clock generator
    msrv_soc_clk_generator clk_gen(.clk(clk),
	                           .reset(reset),
	                           .clk_divider_reg(clk_divider_reg),
		  	           .clk_shift_enb_reg(clk_shift_enb_reg),
	                           .clk_out(clk_out));

    //register bank
    msrv_soc_register_bank #(P) reg_bank(.clk(clk),
	                                 .reset(reset),
			                 .sel(HSELSYS_CTRL),
			                 .wr_enable(HWRITE),
                                         .addr(HADDR),
		                         .wdata(HWDATA),
			                 .trans(HTRANS),
			                 .ready(HREADY),
			                 .ready_sys_ctrl(HREADYSYS_CTRL),
                                         .resp_sys_ctrl(HRESPSYS_CTRL),
			                 .clk_divider_reg(clk_divider_reg),
			                 .clk_shift_enb_reg(clk_shift_enb_reg),
			                 .pmu_state_config(pmu_state_config));
 

    //address decoder
    msrv_soc_adrdecs #(P) adrdecs(.PhysicalAddress(HADDR), 
	                          .AccessRW(1'b1), 
			          .AccessRX(1'b1), 
			          .AccessRWXC(1'b1), 
			          .Size(HSIZE[1:0]), 
			          .SelRegions(HSELRegions));

    //Power Management Unit
    msrv_soc_pmu PMU(.clk(clk),
	             .pmu_state_config(pmu_state_config),
	             .uart_powergate_enb(uart_powergate_enb),
	             .uart_isolation_enb(uart_isolation_enb),
	             .uart_retention_save_enb(uart_retention_save_enb),
	             .uart_retention_restore_enb(uart_retention_restore_enb),
	             .spi_powergate_enb(spi_powergate_enb),
	             .spi_isolation_enb(spi_isolation_enb),
	             .spi_retention_save_enb(spi_retention_save_enb),
	             .spi_retention_restore_enb(spi_retention_restore_enb),
	             .eeprom_powergate_enb(eeprom_powergate_enb),
	             .eeprom_isolation_enb(eeprom_isolation_enb));

    assign HSELSYS_CTRL=HSELRegions[12];

    

   // The logic ends here
  
    INV_X8 async_set_reset_dynamic_disable_inv(
        .A(tessent_persistent_cell_async_set_reset_dynamic_disable_ZN), .ZN(async_set_reset_dynamic_disable_inv_ts1)
    );

    AND2_X4 dft_ctrl_async_set_reset_dynamic_disable_inv_and2(
        .A1(resetsync_q), .A2(async_set_reset_dynamic_disable_inv_ts1), .ZN(reset)
    );
  endmodule