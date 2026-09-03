//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2026.1
//       Created on: Tue Aug 18 14:57:08 IST 2026
//-------------------------------------------------


STIL 1.0 {
  Design 2005;
  CTL 2005;
}
Header {
  Title "CTL for design 'msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic'";
  Date "Tue Aug 18 14:57:08 IST 2026";
  Source "Tessent Shell 2026.1";
}
Signals {
  ijtag_tck In;
  lbist_en In;
  ijtag_reset In;
  ijtag_sel In;
  ijtag_ce In;
  ijtag_se In;
  ijtag_ue In;
  ccm_en In;
  ccm_scan_out Out;
  scan_en In;
  ccm_scan_in In;
  ijtag_si In;
  edt_single_bypass_chain_in In;
  edt_channels_in In;
  edt_channels_out In;
  ijtag_so Out;
  edt_single_bypass_chain_out Out;
  to_edt_channels_in Out;
}
SignalGroups {
  all_inputs = 'ijtag_tck + lbist_en + ijtag_reset + ijtag_sel + ijtag_ce + ijtag_se + ijtag_ue + ccm_en + scan_en + ccm_scan_in + ijtag_si + edt_single_bypass_chain_in + edt_channels_in + edt_channels_out';
  all_outputs = 'ccm_scan_out + ijtag_so + edt_single_bypass_chain_out + to_edt_channels_in';
  all_ports = 'all_inputs + all_outputs';
}
ScanStructures {
  ScanChain "chain_0" {
    ScanLength 16;
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
Environment msrv_soc_system_controllerwrapper_sys_controller_tessent_single_chain_mode_logic {
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
      ccm_scan_in {
        ScanStyle MultiplexedData;
        DataType ScanDataIn {
          ScanDataType Internal;
        }
        CaptureClock ijtag_tck {
          LeadingEdge ;
        }
      }
    }
  }
}

