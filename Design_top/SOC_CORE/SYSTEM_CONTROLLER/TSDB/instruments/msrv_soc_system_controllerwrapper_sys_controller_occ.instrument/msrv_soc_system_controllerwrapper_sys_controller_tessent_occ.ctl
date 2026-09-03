//-------------------------------------------------
//  File created by: Tessent Shell
//          Version: 2026.1
//       Created on: Tue Aug 18 14:57:02 IST 2026
//-------------------------------------------------


STIL 1.0 {
  Design 2005;
  CTL 2005;
}
Header {
  Title "CTL for design 'msrv_soc_system_controllerwrapper_sys_controller_tessent_occ'";
  Date "Tue Aug 18 14:57:02 IST 2026";
  Source "Tessent Shell 2026.1";
}
Signals {
  fast_clock In;
  slow_clock In;
  scan_en In;
  capture_en In;
  static_clock_control_mode In;
  clock_sequence[0] In;
  clock_sequence[1] In;
  clock_sequence[2] In;
  shift_only_mode In;
  ijtag_tck In;
  ijtag_reset In;
  ijtag_sel In;
  ijtag_ce In;
  ijtag_se In;
  ijtag_ue In;
  ijtag_si In;
  ijtag_so Out;
  clock_out Out;
  scan_in In;
  scan_out Out;
}
SignalGroups {
  all_inputs = 'fast_clock + slow_clock + scan_en + capture_en + static_clock_control_mode + clock_sequence[0] + clock_sequence[1] + clock_sequence[2] + shift_only_mode + ijtag_tck + ijtag_reset + ijtag_sel + ijtag_ce + ijtag_se + ijtag_ue + ijtag_si + scan_in';
  all_outputs = 'ijtag_so + clock_out + scan_out';
  all_ports = 'all_inputs + all_outputs';
}
ScanStructures {
  ScanChain "chain_0" {
    ScanLength 3;
    ScanIn scan_in;
    ScanOut scan_out;
    ScanEnable scan_en;
    ScanMasterClock slow_clock;
  }
}
Timing timing {
}
MacroDefs {
}
Environment msrv_soc_system_controllerwrapper_sys_controller_tessent_occ {
  CTLMode internal_test {
    TestMode InternalTest;
    DomainReferences {
    }
    Internal {
      slow_clock {
        DataType ScanMasterClock {
          ActiveState ForceUp;
        }
      }
      scan_en {
        DataType ScanEnable {
          ActiveState ForceUp;
        }
      }
      scan_in {
        ScanStyle MultiplexedData;
        DataType ScanDataIn {
          ScanDataType Internal;
        }
        CaptureClock slow_clock {
          LeadingEdge ;
        }
      }
      scan_out {
        ScanStyle MultiplexedData;
        DataType ScanDataOut {
          ScanDataType Internal;
        }
        LaunchClock slow_clock {
          TrailingEdge ;
        }
      }
    }
  }
}

