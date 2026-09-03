//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2026.1
//       Created on: Tue Aug 18 14:51:24 IST 2026
//-------------------------------------------------


STIL 1.0 {
  Design 2005;
  CTL 2005;
}
Header {
  Title "CTL for design 'msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1'";
  Date "Tue Aug 18 14:51:24 IST 2026";
  Source "Tessent Shell 2026.1";
}
Signals {
  edt_clock In;
  edt_update In;
  edt_bypass In;
  edt_single_bypass_chain In;
  edt_channels_in[0] In;
  edt_channels_in[1] In;
  edt_channels_out[0] Out;
  edt_channels_out[1] Out;
  edt_scan_in[0] Out;
  edt_scan_in[1] Out;
  edt_scan_in[2] Out;
  edt_scan_in[3] Out;
  edt_scan_in[4] Out;
  edt_scan_in[5] Out;
  edt_scan_in[6] Out;
  edt_scan_in[7] Out;
  edt_scan_in[8] Out;
  edt_scan_in[9] Out;
  edt_scan_in[10] Out;
  edt_scan_in[11] Out;
  edt_scan_in[12] Out;
  edt_scan_in[13] Out;
  edt_scan_in[14] Out;
  edt_scan_in[15] Out;
  edt_scan_in[16] Out;
  edt_scan_in[17] Out;
  edt_scan_in[18] Out;
  edt_scan_in[19] Out;
  edt_scan_in[20] Out;
  edt_scan_in[21] Out;
  edt_scan_in[22] Out;
  edt_scan_in[23] Out;
  edt_scan_in[24] Out;
  edt_scan_in[25] Out;
  edt_scan_in[26] Out;
  edt_scan_in[27] Out;
  edt_scan_in[28] Out;
  edt_scan_in[29] Out;
  edt_scan_in[30] Out;
  edt_scan_in[31] Out;
  edt_scan_in[32] Out;
  edt_scan_in[33] Out;
  edt_scan_in[34] Out;
  edt_scan_in[35] Out;
  edt_scan_in[36] Out;
  edt_scan_in[37] Out;
  edt_scan_in[38] Out;
  edt_scan_in[39] Out;
  edt_scan_in[40] Out;
  edt_scan_in[41] Out;
  edt_scan_in[42] Out;
  edt_scan_in[43] Out;
  edt_scan_in[44] Out;
  edt_scan_in[45] Out;
  edt_scan_in[46] Out;
  edt_scan_in[47] Out;
  edt_scan_in[48] Out;
  edt_scan_in[49] Out;
  edt_scan_in[50] Out;
  edt_scan_in[51] Out;
  edt_scan_in[52] Out;
  edt_scan_in[53] Out;
  edt_scan_in[54] Out;
  edt_scan_in[55] Out;
  edt_scan_in[56] Out;
  edt_scan_in[57] Out;
  edt_scan_in[58] Out;
  edt_scan_in[59] Out;
  edt_scan_out[0] In;
  edt_scan_out[1] In;
  edt_scan_out[2] In;
  edt_scan_out[3] In;
  edt_scan_out[4] In;
  edt_scan_out[5] In;
  edt_scan_out[6] In;
  edt_scan_out[7] In;
  edt_scan_out[8] In;
  edt_scan_out[9] In;
  edt_scan_out[10] In;
  edt_scan_out[11] In;
  edt_scan_out[12] In;
  edt_scan_out[13] In;
  edt_scan_out[14] In;
  edt_scan_out[15] In;
  edt_scan_out[16] In;
  edt_scan_out[17] In;
  edt_scan_out[18] In;
  edt_scan_out[19] In;
  edt_scan_out[20] In;
  edt_scan_out[21] In;
  edt_scan_out[22] In;
  edt_scan_out[23] In;
  edt_scan_out[24] In;
  edt_scan_out[25] In;
  edt_scan_out[26] In;
  edt_scan_out[27] In;
  edt_scan_out[28] In;
  edt_scan_out[29] In;
  edt_scan_out[30] In;
  edt_scan_out[31] In;
  edt_scan_out[32] In;
  edt_scan_out[33] In;
  edt_scan_out[34] In;
  edt_scan_out[35] In;
  edt_scan_out[36] In;
  edt_scan_out[37] In;
  edt_scan_out[38] In;
  edt_scan_out[39] In;
  edt_scan_out[40] In;
  edt_scan_out[41] In;
  edt_scan_out[42] In;
  edt_scan_out[43] In;
  edt_scan_out[44] In;
  edt_scan_out[45] In;
  edt_scan_out[46] In;
  edt_scan_out[47] In;
  edt_scan_out[48] In;
  edt_scan_out[49] In;
  edt_scan_out[50] In;
  edt_scan_out[51] In;
  edt_scan_out[52] In;
  edt_scan_out[53] In;
  edt_scan_out[54] In;
  edt_scan_out[55] In;
  edt_scan_out[56] In;
  edt_scan_out[57] In;
  edt_scan_out[58] In;
  edt_scan_out[59] In;
  lbist_reset In;
  lbist_en In;
  lbist_prpg_en In;
  misr_accumulate_en In;
  lbist_low_power_shift_en In;
  ijtag_tck In;
  ijtag_reset In;
  ijtag_sel In;
  ijtag_ce In;
  ijtag_se In;
  ijtag_ue In;
  ccm_en In;
  ccm_scan_in In;
  ccm_scan_out Out;
  scan_en In;
  ijtag_si In;
  ijtag_so Out;
}
SignalGroups {
  all_inputs = 'edt_clock + edt_update + edt_bypass + edt_single_bypass_chain + edt_channels_in[0] + edt_channels_in[1] + edt_scan_out[0] + edt_scan_out[1] + edt_scan_out[2] + edt_scan_out[3] + edt_scan_out[4] + edt_scan_out[5] + edt_scan_out[6] + edt_scan_out[7] + edt_scan_out[8] + edt_scan_out[9] + edt_scan_out[10] + edt_scan_out[11] + edt_scan_out[12] + edt_scan_out[13] + edt_scan_out[14] + edt_scan_out[15] + edt_scan_out[16] + edt_scan_out[17] + edt_scan_out[18] + edt_scan_out[19] + edt_scan_out[20] + edt_scan_out[21] + edt_scan_out[22] + edt_scan_out[23] + edt_scan_out[24] + edt_scan_out[25] + edt_scan_out[26] + edt_scan_out[27] + edt_scan_out[28] + edt_scan_out[29] + edt_scan_out[30] + edt_scan_out[31] + edt_scan_out[32] + edt_scan_out[33] + edt_scan_out[34] + edt_scan_out[35] + edt_scan_out[36] + edt_scan_out[37] + edt_scan_out[38] + edt_scan_out[39] + edt_scan_out[40] + edt_scan_out[41] + edt_scan_out[42] + edt_scan_out[43] + edt_scan_out[44] + edt_scan_out[45] + edt_scan_out[46] + edt_scan_out[47] + edt_scan_out[48] + edt_scan_out[49] + edt_scan_out[50] + edt_scan_out[51] + edt_scan_out[52] + edt_scan_out[53] + edt_scan_out[54] + edt_scan_out[55] + edt_scan_out[56] + edt_scan_out[57] + edt_scan_out[58] + edt_scan_out[59] + lbist_reset + lbist_en + lbist_prpg_en + misr_accumulate_en + lbist_low_power_shift_en + ijtag_tck + ijtag_reset + ijtag_sel + ijtag_ce + ijtag_se + ijtag_ue + ccm_en + ccm_scan_in + scan_en + ijtag_si';
  all_outputs = 'edt_channels_out[0] + edt_channels_out[1] + edt_scan_in[0] + edt_scan_in[1] + edt_scan_in[2] + edt_scan_in[3] + edt_scan_in[4] + edt_scan_in[5] + edt_scan_in[6] + edt_scan_in[7] + edt_scan_in[8] + edt_scan_in[9] + edt_scan_in[10] + edt_scan_in[11] + edt_scan_in[12] + edt_scan_in[13] + edt_scan_in[14] + edt_scan_in[15] + edt_scan_in[16] + edt_scan_in[17] + edt_scan_in[18] + edt_scan_in[19] + edt_scan_in[20] + edt_scan_in[21] + edt_scan_in[22] + edt_scan_in[23] + edt_scan_in[24] + edt_scan_in[25] + edt_scan_in[26] + edt_scan_in[27] + edt_scan_in[28] + edt_scan_in[29] + edt_scan_in[30] + edt_scan_in[31] + edt_scan_in[32] + edt_scan_in[33] + edt_scan_in[34] + edt_scan_in[35] + edt_scan_in[36] + edt_scan_in[37] + edt_scan_in[38] + edt_scan_in[39] + edt_scan_in[40] + edt_scan_in[41] + edt_scan_in[42] + edt_scan_in[43] + edt_scan_in[44] + edt_scan_in[45] + edt_scan_in[46] + edt_scan_in[47] + edt_scan_in[48] + edt_scan_in[49] + edt_scan_in[50] + edt_scan_in[51] + edt_scan_in[52] + edt_scan_in[53] + edt_scan_in[54] + edt_scan_in[55] + edt_scan_in[56] + edt_scan_in[57] + edt_scan_in[58] + edt_scan_in[59] + ccm_scan_out + ijtag_so';
  all_ports = 'all_inputs + all_outputs';
}
ScanStructures {
  ScanChain "chain_0" {
    ScanLength 332;
    ScanIn ccm_scan_in;
    ScanOut ccm_scan_out;
    ScanEnable scan_en;
    ScanMasterClock ijtag_tck;
  }
}
Timing timing {
}
MacroDefs {
}
Environment msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1 {
  CTLMode internal_test {
    TestMode InternalTest;
    DomainReferences {
    }
    Internal {
      ijtag_tck {
        DataType ScanMasterClock {
          ActiveState ForceUp;
        }
      }
      ccm_en {
        DataType TestMode {
          ActiveState ForceUp;
        }
      }
      ccm_scan_in {
        ScanStyle MultiplexedData;
        DataType ScanDataIn {
          ScanDataType Internal;
        }
        CaptureClock ijtag_tck {
          LeadingEdge ;
        }
      }
      ccm_scan_out {
        ScanStyle MultiplexedData;
        DataType ScanDataOut {
          ScanDataType Internal;
        }
        LaunchClock ijtag_tck {
          TrailingEdge ;
        }
      }
      scan_en {
        DataType ScanEnable {
          ActiveState ForceUp;
        }
      }
    }
  }
}

