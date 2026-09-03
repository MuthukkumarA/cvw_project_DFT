//--------------------------------------------------------------------------
//
//  Unpublished work. Copyright 2026 Siemens
//
//  This material contains trade secrets or otherwise confidential 
//  information owned by Siemens Industry Software Inc. or its affiliates 
//  (collectively, SISW), or its licensors. Access to and use of this 
//  information is strictly limited as set forth in the Customer's 
//  applicable agreements with SISW.
//
//--------------------------------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2026.1
//       Created on: Tue Aug 18 14:51:18 IST 2026
//--------------------------------------------------------------------------

     
module msrv_soc_uncorewrapper_pass2_rtl_tessent_clk_inv (
  input wire a,
  output wire y
);
 
not gate (y, a);
    
endmodule
  
