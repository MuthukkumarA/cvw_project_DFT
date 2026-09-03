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
  Title "CTL for design 'msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist'";
  Date "Tue Aug 18 14:57:08 IST 2026";
  Source "Tessent Shell 2026.1";
}
Signals {
  ijtag_tck In;
  test_clock In;
  shift_clock_src In;
  edt_lbist_clock Out;
  lbist_test_clock_out Out;
  to_edt_scan_in Out;
  from_edt_scan_out In;
  ijtag_si In;
  ijtag_so Out;
  lbist_en Out;
  lbist_reset Out;
  edt_update_in In;
  edt_update_out Out;
  ccm_en In;
  ccm_scan_in In;
  ccm_scan_out Out;
  lbist_low_power_shift_en Out;
  scan_en_in In;
  scan_en_out Out;
  shift_capture_clock_out Out;
  shift_en_out Out;
  capture_en_out Out;
  lbist_prpg_en Out;
  misr_accumulate_en Out;
  ijtag_reset In;
  ijtag_sel In;
  ijtag_ce In;
  ijtag_se In;
  ijtag_ue In;
  edt_sib_en Out;
}
SignalGroups {
  all_inputs = 'ijtag_tck + test_clock + shift_clock_src + from_edt_scan_out + ijtag_si + edt_update_in + ccm_en + ccm_scan_in + scan_en_in + ijtag_reset + ijtag_sel + ijtag_ce + ijtag_se + ijtag_ue';
  all_outputs = 'edt_lbist_clock + lbist_test_clock_out + to_edt_scan_in + ijtag_so + lbist_en + lbist_reset + edt_update_out + ccm_scan_out + lbist_low_power_shift_en + scan_en_out + shift_capture_clock_out + shift_en_out + capture_en_out + lbist_prpg_en + misr_accumulate_en + edt_sib_en';
  all_ports = 'all_inputs + all_outputs';
}
ScanStructures {
  ScanChain "chain_0" {
    ScanLength 107;
    ScanIn ccm_scan_in;
    ScanOut ccm_scan_out;
    ScanEnable scan_en_in;
    ScanMasterClock ijtag_tck;
  }
}
Timing timing {
}
MacroDefs {
}
Environment msrv_soc_system_controllerwrapper_sys_controller_tessent_lbist {
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
      scan_en_in {
        DataType ScanEnable {
          ActiveState ForceUp;
        }
      }
    }
  }
}

