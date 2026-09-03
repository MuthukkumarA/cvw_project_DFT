#--------------------------------------------------------------------------
#
#  Unpublished work. Copyright 2026 Siemens
#
#  This material contains trade secrets or otherwise confidential 
#  information owned by Siemens Industry Software Inc. or its affiliates 
#  (collectively, SISW), or its licensors. Access to and use of this 
#  information is strictly limited as set forth in the Customer's 
#  applicable agreements with SISW.
#
#--------------------------------------------------------------------------
#  File created by: Tessent Shell
#          Version: 2026.1
#       Created on: Tue Aug 18 14:51:24 IST 2026
#--------------------------------------------------------------------------

   
proc msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist {args} {
        
  create_clock shift_clock_src -period 10.0 -name shift_clock_src -add
       
  create_clock test_clock -period 40.0 -name test_clock -add
       
  create_clock ijtag_tck -period 100.0 -name ijtag_clock -add
}
