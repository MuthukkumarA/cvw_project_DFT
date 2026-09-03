//
// Verilog format test patterns produced by Tessent Shell 2026.1
// Filename        : patterns/msrv_soc_uncorewrapper_stuck_serial.v
// Scan operation  : SERIAL
// Idstamp         : 2026.1:827d:acf5:8:6ee6
// Fault           : STUCK
// Coverage        : 75.81(TC) 68.11(FC)
// Date            : Tue Aug 18 14:54:23 2026
//
// Begin_Verify_Section 
//   format            = Verilog 
//   top_module_name   = msrv_soc_uncorewrapper_msrv_soc_uncorewrapper_stuck_serial_v_ctl 
//   serial_flag       = ON 
//   test_set_type     = EDT_ALL_TEST 
//   test_set_source   = SCAN_ATPG 
//   pad_value         = 0 
//   pattern_begin     = 0 
//   pattern_end       = 7 
//   one_setup         = ON 
//   no_initialization = ON 
//   pattern_checksum  = 83820 
//   edt_external      = ON 
// End_Verify_Section 
(* tessent_dut_module_name = "msrv_soc_uncorewrapper" *)

`define SIM_INSTANCE_NAME msrv_soc_uncorewrapper_inst


`timescale 1ns / 1ns

module msrv_soc_uncorewrapper_msrv_soc_uncorewrapper_stuck_serial_v_ctl;

integer     _wrote_fail;
integer     _write_DIAG_file;
integer     _DIAG_file_header;
integer     _diag_file;
integer     _diag_chain_header;
integer     _diag_scan_header;
integer     _last_fail_pattern;
integer     _fail_pattern_cnt;
integer     _write_MASK_file;
integer     _MASK_file_header;
integer     _mask_file;
integer     _par_shift_cnt;
integer     _chain_test_;
integer     _compare_fail;
integer     _bit_count;
integer     _report_bit_cnt;
integer     _miscompare_limit;
integer     _found_fail;
integer     _found_fail_per_cycle;
integer     _allow_bad_message_index;
reg[2:0]    _found_fail_obus;
integer     _end_vec_file_ok;
integer     _cycle_count, _save_cycle_count;
integer     _pattern_count, _repeat_count_nest[0:8], _repeat_count, _message_index;
integer     _index, _scan_index, _file_cnt, _max_index, _vec_pat_count, _save_index[0:8];
integer     _repeat_depth;
integer     _file_check;
integer     _run_testsetup;
integer     _in_testsetup;
integer     _start_pat;
integer     _end_pat;
integer     _end_after_setup;
integer     _no_setup;
integer     _save_state;
integer     _restart_state;
integer     _in_restart;
integer     _override_cfg;
integer     _in_range;
integer     _do_compare;
integer     _in_chaintest;
integer     _pat_num;
integer     _skipped_patterns;
integer     _end_simulation;
integer     _config_file;
integer     _fstat;
integer     _max_file_cnt;
reg[256*8:1] _vec_file_name;
reg[256*8:1] _cfg_file_name;
integer     _scan_shift_count;
reg[11:0]    _ibus;
reg[2:0]    _exp_obus, _msk_obus;
wire[2:0]   _sim_obus;
reg[2:0]    _pat_type;
reg         _tp_num;
reg         mgcdft_save_signal, mgcdft_restart_signal;
reg[38:0]   vect;

wire ijtag_tck, ijtag_reset, ijtag_ce, ijtag_se, ijtag_ue, ijtag_sel, 
     ijtag_si, scan_en_w, edt_update, test_clock_w, \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_in[1] , 
     \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_in[0] , 
     ijtag_so, \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_out[1] , 
     \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_out[0] ;

event       before_finish;
assign ijtag_tck = _ibus[11];
assign ijtag_reset = _ibus[10];
assign ijtag_ce = _ibus[9];
assign ijtag_se = _ibus[8];
assign ijtag_ue = _ibus[7];
assign ijtag_sel = _ibus[6];
assign ijtag_si = _ibus[5];
assign scan_en_w = _ibus[4];
assign edt_update = _ibus[3];
assign test_clock_w = _ibus[2];
assign \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_in[1]  = _ibus[1];
assign \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_in[0]  = _ibus[0];

assign _sim_obus[2] = ijtag_so;
assign _sim_obus[1] = \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_out[1] ;
assign _sim_obus[0] = \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_out[0] ;

// Change Path Variables & Get Argument 
integer      _change_path; 
integer      _change_out_path; 
reg[512*8:1]  _new_path; 
reg[512*8:1]  _new_out_path; 
reg[512*8:1]  _new_filename; 
reg[512*8:1]  _vcd_dump_file_name; 
reg[512*8:1]  _utvcd_dump_file_name; 
reg[512*8:1]  _fsdb_dump_file_name; 
reg[512*8:1]  _qwave_dump_file_name; 
reg[512*8:1]  _tmp_filename; 
initial begin 
  _change_path = 0; 
  _change_out_path = 0; 
  if ($value$plusargs("NEWPATH=%s", _new_path)) begin 
    $display("Found New Path %0s\n", _new_path); 
    _change_path = 1; 
  end 
  if ($value$plusargs("NEWOUTPATH=%s", _new_out_path)) begin 
    $display("Found New Out Path %0s\n", _new_out_path); 
    _change_out_path = 1; 
  end 

`ifdef VCD
    $sformat(_vcd_dump_file_name, "msrv_soc_uncorewrapper_stuck_serial.v.dump");
    if(_change_out_path) begin 
      $sformat(_vcd_dump_file_name, "%0s/%0s", _new_out_path, _vcd_dump_file_name);
    end
    $dumpfile(_vcd_dump_file_name);
    $dumpvars;
`endif

`ifdef UTVCD
    $sformat(_utvcd_dump_file_name, "msrv_soc_uncorewrapper_stuck_serial.v.dump");
    if(_change_out_path) begin 
      $sformat(_utvcd_dump_file_name, "%0s/%0s", _new_out_path, _utvcd_dump_file_name);
    end
    $dumpfile(_utvcd_dump_file_name);
    $vtDump;
    $dumpvars;
`endif

`ifdef debussy
    $sformat(_fsdb_dump_file_name, "msrv_soc_uncorewrapper_stuck_serial.v.fsdb");
    if(_change_out_path) begin 
      $sformat(_fsdb_dump_file_name, "%0s/%0s", _new_out_path, _fsdb_dump_file_name);
    end
    $fsdbDumpfile(_fsdb_dump_file_name);
    $fsdbDumpvars;
`endif

`ifdef QWAVE
    $sformat(_qwave_dump_file_name, "msrv_soc_uncorewrapper_stuck_serial.v.qwave.db");
    if(_change_out_path) begin 
      $sformat(_qwave_dump_file_name, "%0s/%0s", _new_out_path, _qwave_dump_file_name);
    end
    $qwavedb_dumpvars_filename(_qwave_dump_file_name);
    $qwavedb_dumpvars;
`endif
end 

reg /* sparse */[527:0] _nam_obus[2:0];
initial begin 
   if(_change_path) begin 
     $sformat(_new_filename,"%0s/msrv_soc_uncorewrapper_stuck_serial.v.po.name",_new_path); 
     $display("Loading %0s\n", _new_filename ); 
     $readmemh(_new_filename,_nam_obus,2,0); 
   end 
   else begin
     $display("Loading msrv_soc_uncorewrapper_stuck_serial.v.po.name");
     $readmemh("msrv_soc_uncorewrapper_stuck_serial.v.po.name",_nam_obus,2,0);
   end 
end 


// Declare Wires for tracking Vector Type
reg[3:0] _MGCDFT_VECTYPE ;
reg[160:0] _procedure_string ;
reg mgcdft_test_setup, mgcdft_load_unload, mgcdft_shift,
     mgcdft_single_shift, mgcdft_shift_extra, 
     mgcdft_shadow_control, mgcdft_master_observe,
     mgcdft_shadow_observe, mgcdft_skew_load, 
     mgcdft_seq_transparent, mgcdft_launch_capture,
     mgcdft_clock_proc, mgcdft_test_end, mgcdft_unknown; 

event       set_vector_type;
always @(_MGCDFT_VECTYPE) begin
  assign mgcdft_test_setup      = 1'b0;
  assign mgcdft_load_unload     = 1'b0;
  assign mgcdft_shift           = 1'b0;
  assign mgcdft_single_shift    = 1'b0;
  assign mgcdft_shift_extra     = 1'b0;
  assign mgcdft_shadow_control  = 1'b0;
  assign mgcdft_master_observe  = 1'b0;
  assign mgcdft_shadow_observe  = 1'b0;
  assign mgcdft_skew_load       = 1'b0;
  assign mgcdft_seq_transparent = 1'b0;
  assign mgcdft_launch_capture  = 1'b0;
  assign mgcdft_clock_proc      = 1'b0;
  assign mgcdft_test_end        = 1'b0;
  assign mgcdft_unknown         = 1'b0;
  case (_MGCDFT_VECTYPE)
    4'b0001: begin
               assign mgcdft_test_setup      = 1'b1;
               _procedure_string = "TEST_SETUP";
               _scan_shift_count = 0;
             end
    4'b0010: begin
               assign mgcdft_load_unload     = 1'b1;
               _procedure_string = "LOAD";
               _scan_shift_count = 0;
             end
    4'b0011: begin
               assign mgcdft_shift           = 1'b1;
               _procedure_string = "SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0100: begin
               assign mgcdft_single_shift    = 1'b1;
               _procedure_string = "SINGLE_SHIFT";
               if(!(_scan_shift_count)) begin
                 _scan_shift_count = 1;
               end
             end
    4'b0101: begin
               assign mgcdft_shift_extra     = 1'b1;
               _procedure_string = "SHIFT_EXTRA";
               _scan_shift_count = 0;
             end
    4'b0110: begin
               assign mgcdft_shadow_control  = 1'b1;
               _procedure_string = "SHADOW_CONTROL";
               _scan_shift_count = 0;
             end
    4'b0111: begin
               assign mgcdft_master_observe  = 1'b1;
               _procedure_string = "MASTER_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1000: begin
               assign mgcdft_shadow_observe  = 1'b1;
               _procedure_string = "SHADOW_OBSERVE";
               _scan_shift_count = 0;
             end
    4'b1001: begin
               assign mgcdft_skew_load       = 1'b1;
               _procedure_string = "SKEW_LOAD";
               _scan_shift_count = 0;
             end
    4'b1010: begin
               assign mgcdft_seq_transparent = 1'b1;
               _procedure_string = "SEQ_TRANSPARENT";
               _scan_shift_count = 0;
             end
    4'b1011: begin
               assign mgcdft_launch_capture  = 1'b1;
               _procedure_string = "LAUNCH_CAPTURE";
               _scan_shift_count = 0;
             end
    4'b1101: begin
               assign mgcdft_clock_proc      = 1'b1;
               _procedure_string = "CLOCK_PROC";
               _scan_shift_count = 0;
             end
    4'b1111: begin
               assign mgcdft_test_end        = 1'b1;
               _procedure_string = "TEST_END";
               _scan_shift_count = 0;
             end
    4'b0000: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
    default: begin
               assign mgcdft_unknown         = 1'b1;
               _procedure_string = "UNKNOWN";
               _scan_shift_count = 0;
             end
  endcase
end

event       compare_exp_sim_obus;
always @(compare_exp_sim_obus) begin
 _found_fail = 0;
 if (_do_compare) begin
  if (_exp_obus !== _sim_obus) begin
     for(_bit_count = 0;
         ((_bit_count < 3)&&(_found_fail==0));
          _bit_count =_bit_count +1) begin
        if ((_msk_obus[_bit_count] === 1'b1) &&
            (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
           _found_fail = 1;
           _found_fail_per_cycle = 1;
           _found_fail_obus[_bit_count] = 1'b1;
        end
     end
  end
  if (_found_fail == 1) begin
    $write($realtime, "ns: Simulated response %b pattern %d cycle %d\n",_sim_obus,_pattern_count,_cycle_count);
    $write($realtime, "ns: Expected  response %b pattern %d cycle %d\n",_exp_obus,_pattern_count,_cycle_count);
     for(_bit_count = 0;
         ((_bit_count < 3)&&((_miscompare_limit==0)||(_compare_fail<=_miscompare_limit)));
          _bit_count =_bit_count +1) begin
      if ((_msk_obus[_bit_count] === 1'b1) &&
          (_exp_obus[_bit_count] !== _sim_obus[_bit_count])) begin
        _found_fail_obus[_bit_count] = 1'b1;
        $write($realtime, "ns: Mismatch at pin %d name %s, Simulated %b, Expected %b\n",_bit_count,_nam_obus[_bit_count],_sim_obus[_bit_count],_exp_obus[_bit_count]);
        if (_write_MASK_file == 0) begin
         if (_scan_shift_count != 0) begin 
            case (_bit_count) // Scan Chain Failure 
              0: begin
                      $write($realtime, "ns: Mismatch on chain: edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel1 at shift cycle: %d\n", (_scan_shift_count-1));
               end
              1: begin
                      $write($realtime, "ns: Mismatch on chain: edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel2 at shift cycle: %d\n", (_scan_shift_count-1));
               end
            endcase
          end // _scan_shift_count
        end
        if (_write_DIAG_file == 1) begin
          if (_DIAG_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v_%0d_%0d.fail",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v_%0d.fail",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v__%0d.fail",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v.fail");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _diag_file = $fopen(_tmp_filename);
            if (_diag_file == 0) begin
              $display("ERROR: Couldn't open .fail file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            if(_change_out_path) begin 
              $fwrite(_diag_file, "// This File is simulation generated (%0s/msrv_soc_uncorewrapper_stuck_serial.v)\n", _new_out_path);
            end
            else begin
              $fwrite(_diag_file, "// This File is simulation generated (msrv_soc_uncorewrapper_stuck_serial.v)\n");
            end
            $fwrite(_diag_file, "format cycle\n");
            $fwrite(_diag_file, " failures_begin\n");
            $fwrite(_diag_file, "//cycle_number  PO_name  expected_value  simulated_value  ");
            $fwrite(_diag_file, "pattern_id  chain_name  cell_number\n\n");
            _DIAG_file_header = 1;
          end
          if ((_pattern_count == _last_fail_pattern) && (_pattern_count == 0)) begin
             _fail_pattern_cnt = 1; 
          end
          if (_pattern_count > _last_fail_pattern) begin 
             _fail_pattern_cnt = _fail_pattern_cnt + 1;
             _last_fail_pattern = _pattern_count;
          end

          $fwrite(_diag_file, "%d  %s ", _cycle_count, _nam_obus[_bit_count]);
          case ( _exp_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, "            H"); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, "            L"); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, "            Z"); 
                  end
          endcase
          case ( _sim_obus[_bit_count] )
            1'b1: begin
                    $fwrite(_diag_file, " H  // Pattern %d ", _pattern_count); 
                  end
            1'b0: begin
                    $fwrite(_diag_file, " L  // Pattern %d ", _pattern_count); 
                  end
            1'bZ: begin
                    $fwrite(_diag_file, " Z  // Pattern %d ", _pattern_count); 
                  end
            1'bX: begin
                    $fwrite(_diag_file, " X  // Pattern %d ", _pattern_count); 
                  end
          endcase
         if (_scan_shift_count == 0) begin
                 $fwrite(_diag_file, ", simulation_time=%.0f\n", $realtime);
         end // EndIf  _ScanShift_count
         if (_scan_shift_count != 0) begin
          case (_bit_count) // Scan Chain Failure
            0: begin
                 $fwrite(_diag_file, "chain: edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel1  cell: %d, simulation_time=%.0f\n", (_scan_shift_count-1), $realtime);
                end
            1: begin
                 $fwrite(_diag_file, "chain: edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel2  cell: %d, simulation_time=%.0f\n", (_scan_shift_count-1), $realtime);
                end
          endcase
         end // EndIf  _ScanShift_count
        end // EndIf _write_DIAG_file
        if (_write_MASK_file == 1) begin
          if (_MASK_file_header == 0) begin
            if ((_start_pat > -1) && (_end_pat > -1)) begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v_%0d_%0d.mask",
                       _start_pat, _end_pat);
            end
            else if (_start_pat > -1) begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v_%0d.mask",
                       _start_pat);
            end
            else if (_end_pat > -1) begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v__%0d.mask",
                       _end_pat);
            end
            else begin
              $sformat(_tmp_filename, "msrv_soc_uncorewrapper_stuck_serial.v.mask");
            end
            if(_change_out_path) begin 
              $sformat(_tmp_filename, "%0s/%0s", _new_out_path, _tmp_filename);
            end
            _mask_file = $fopen(_tmp_filename);
            if (_mask_file == 0) begin
              $display("ERROR: Couldn't open .mask file %0s, simulation aborted\n", _tmp_filename);
              ->before_finish;
              #0;
              $finish;
            end
            $fwrite(_mask_file, "%s\n%s\n", "type mask", "");
            _MASK_file_header = 1;
          end
        _wrote_fail = 0;
         if (_scan_shift_count != 0) begin 
          case (_bit_count) // Scan Chain Failure 
            0: begin
                    $write($realtime, "ns: Mismatch on chain: edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel1 at shift cycle: %d\n", (_scan_shift_count-1));
                 if (_chain_test_ == 0) begin
                   $fwrite(_mask_file, "%d %s %d\n",
                             _pattern_count, "edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel1", (_scan_shift_count-1));
                   _wrote_fail = 1;
                 end
                 if (_chain_test_ == 1) begin
                   $fwrite(_mask_file, "// %d %s %d\n",
                    _pattern_count,"edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel1", (_scan_shift_count-1));
                   _wrote_fail = 1;
                 end
               end
            1: begin
                    $write($realtime, "ns: Mismatch on chain: edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel2 at shift cycle: %d\n", (_scan_shift_count-1));
                 if (_chain_test_ == 0) begin
                   $fwrite(_mask_file, "%d %s %d\n",
                             _pattern_count, "edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel2", (_scan_shift_count-1));
                   _wrote_fail = 1;
                 end
                 if (_chain_test_ == 1) begin
                   $fwrite(_mask_file, "// %d %s %d\n",
                    _pattern_count,"edt_msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst__edt_block_channel2", (_scan_shift_count-1));
                   _wrote_fail = 1;
                 end
               end
          endcase
         end // _scan_shift_count 
          if (_wrote_fail == 0 )  begin // not Scan Chain Failure
            if (_chain_test_ == 0) begin
              $fwrite(_mask_file, "%d %s\n", _pattern_count,_nam_obus[_bit_count]);
            end
            if (_chain_test_ == 1) begin
              $fwrite(_mask_file, "// %d %s\n", _pattern_count,_nam_obus[_bit_count]);
            end
          end
        end// if MaskFile
      end
    end
    _compare_fail = _compare_fail + 1;
  end
 end // if _do_compare
end

reg[38:0]     mem [0:6882959];
msrv_soc_uncorewrapper msrv_soc_uncorewrapper_inst (
     .ijtag_tck(ijtag_tck), .ijtag_reset(ijtag_reset), 
     .ijtag_ce(ijtag_ce), .ijtag_se(ijtag_se), 
     .ijtag_ue(ijtag_ue), .ijtag_sel(ijtag_sel), 
     .ijtag_si(ijtag_si), .scan_en_w(scan_en_w), 
     .edt_update(edt_update), .test_clock_w(test_clock_w), 
     .msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_in({\msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_in[1] 
     , \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_in[0] }), 
     .ijtag_so(ijtag_so), 
     .msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_out({\msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_out[1] 
     , \msrv_soc_uncorewrapper_pass2_rtl_controller_c1_edt_channels_out[0] }));

initial begin
_in_restart = 0;
while (_in_restart < 2) begin
_in_restart = _in_restart + 1;
_restart_state     = -1;
if ($value$plusargs("RESTART=%d", _restart_state)) begin
  $display(" Found RESTART   %d", _restart_state);
end

if ((_in_restart < 2) || (_restart_state == 1)) begin
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
if (_restart_state == 1) begin
  #0;
  mgcdft_restart_signal = 1'b1;
//  $display("Reading checkpoint msrv_soc_uncorewrapper_stuck_serial.v.dat");
//  $restart("msrv_soc_uncorewrapper_stuck_serial.v.dat");
end

#0;
mgcdft_save_signal = 1'b0;
mgcdft_restart_signal = 1'b0;
_compare_fail = 0;
_pattern_count = 0;
_cycle_count = 0;
_save_cycle_count = 0;
_write_DIAG_file = 0; // change to 1, to generate file
_write_MASK_file = 0; // change to 1, to generate file
_wrote_fail = 0;
_DIAG_file_header = 0;
_diag_file = 0;
_diag_chain_header = 0;
_diag_scan_header = 0;
_fail_pattern_cnt = 0;
_last_fail_pattern = 0;
_MASK_file_header = 0;
_mask_file = 0;
_chain_test_ = 0;
_par_shift_cnt = 0;
_report_bit_cnt = 0;
// Limit # of miscompares before aborting simulation (non-zero)
_miscompare_limit = 0; 
_end_vec_file_ok = 0; 
_scan_shift_count = 0;
_run_testsetup = 1;
_in_testsetup = 1;
_start_pat      = -1;
_end_pat        = -1;
_end_after_setup = -1;
_no_setup       = -1;
_save_state     = -1;
_override_cfg   = 0;
_pat_num        = -1;
_in_range       = 1;
_do_compare     = 1;
_in_chaintest   = 0;

_skipped_patterns = 0;

_end_simulation   = 0;

if ($value$plusargs("STARTPAT=%d", _start_pat)) begin
  if (_start_pat > -1) begin
    $display(" Found Start pattern number %d", _start_pat);
    _in_range = 0;
    _do_compare = 0;
  end
  else begin
    $display(" Ignoring negative Start pattern number   %d", _start_pat);
    _start_pat = -1;
  end
end
if ($value$plusargs("ENDPAT=%d", _end_pat)) begin
  if (_end_pat > -1) begin
    $display(" Found End pattern number   %d", _end_pat);
  end
  else begin
    $display(" Ignoring negative End pattern number   %d", _end_pat);
    _end_pat = -1;
  end
end

if ($value$plusargs("CHAINTEST=%d", _in_chaintest)) begin
  if (_in_chaintest) begin
    $display(" Found ChainTest identifier %d", _in_chaintest);
  end
end

if ($value$plusargs("END_AFTER_SETUP=%d", _end_after_setup)) begin
  $display(" Found End after setup   %d", _end_after_setup);
  if (_end_after_setup > 0) begin
    _end_pat = 0;
    _in_chaintest = 1;
  end
end

if ($value$plusargs("SKIP_SETUP=%d", _no_setup)) begin
  $display(" Found Skip setup   %d", _no_setup);
  if (_no_setup > 0) begin
    if (_start_pat == -1) begin
      _start_pat = 0;
      _in_chaintest = 1;
    end
    _run_testsetup = 0;
    _in_range = 0;
    _do_compare = 0;
  end
end

if ($value$plusargs("SAVE=%d", _save_state)) begin
  $display(" Found SAVE   %d", _save_state);
end

if ($value$plusargs("CONFIG=%0s", _cfg_file_name)) begin
  $display(" Found CONFIG identifier   %0s", _cfg_file_name);
  _override_cfg = 1;
end
else begin
  _cfg_file_name = "msrv_soc_uncorewrapper_stuck_serial.v.cfg";
end

if ((_end_pat != -1) && (_end_pat < _start_pat)) begin
  _start_pat = -1;
  _in_range = 1;
  _do_compare = 1;
  $display("STARTPAT less than ENDPAT, ignoring STARTPAT ");
end
_allow_bad_message_index = 0;
if ($value$plusargs("ALLOW_BAD_MESSAGE_INDEX=%d", _allow_bad_message_index)) begin
  $display(" Found ALLOW_BAD_MESSAGE_INDEX %d", _allow_bad_message_index);
end

// read vector config file
if(_override_cfg) begin 
  _config_file = $fopen(_cfg_file_name, "r");
end
else begin
if(_change_path) begin 
  $sformat(_new_filename,"%0s/msrv_soc_uncorewrapper_stuck_serial.v.cfg",_new_path); 
  _config_file = $fopen(_new_filename, "r");
end
else begin
  _config_file = $fopen("msrv_soc_uncorewrapper_stuck_serial.v.cfg", "r");
end

end

if (_config_file == 0) begin
  $display("ERROR: Couldn't open configuration file, simulation aborted\n");
  ->before_finish;
  #0;
  $finish;
end
_fstat = 0;
if (_start_pat != -1) begin
  if (_no_setup > 0) begin
  $display("BEGIN pattern read loop  Skip test_setup\n");
  end
  else if (_in_chaintest == 0) begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start pattern (%d) End pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start pattern (%d) \n",
_start_pat);
    end
  end
  else begin
    if (_end_pat != -1) begin
    $display("BEGIN pattern read loop  Start chain pattern (%d) End chain pattern (%d)\n",
_start_pat,_end_pat);
    end
    else begin
    $display("BEGIN pattern read loop  Start chain pattern (%d)\n",
_start_pat);
    end
  end
end
else if (_end_pat != -1) begin
  if (_end_after_setup > 0) begin
  $display("BEGIN pattern read loop  End after test_setup\n");
  end
  else if (_in_chaintest == 0) begin
  $display("BEGIN pattern read loop  End pattern (%d)\n", _end_pat);
  end
  else begin
  $display("BEGIN pattern read loop  End chain pattern (%d)\n", _end_pat);
  end
end

// begin pattern read loop
while (!$feof(_config_file) && (!_end_simulation))
begin
         _fstat = $fscanf(_config_file, "%s", _vec_file_name);
         _fstat = $fscanf(_config_file, "%d", _max_index);
   if (_fstat != -1) begin
         _fstat = $fscanf(_config_file, "%d", _vec_pat_count);
         if (_fstat == -1) begin
           _vec_pat_count = -1;
         end
         // skip .vec file if _start_pat greater than this
         if ((_start_pat != -1) && !_in_range && (_vec_pat_count != -1) &&
             !_in_testsetup && !_in_chaintest &&
             ((_pat_num + _vec_pat_count) < _start_pat)) begin
           _max_index = -1;
           if (_chain_test_) begin
             _pattern_count = 0;
             _pat_num = 0;
           end
           _pat_num = _pat_num + _vec_pat_count;
           _skipped_patterns = _skipped_patterns + _vec_pat_count;
           _end_vec_file_ok = 1;
           _chain_test_ = 0;
            $display("Skipping %0s\n", _vec_file_name);
         end
         else begin
          if(_change_path) begin 
            $sformat(_new_filename,"%0s/%0s",_new_path, _vec_file_name); 
            $display("Loading %0s\n", _new_filename ); 
            $readmemb(_new_filename, mem, 0, _max_index);
         end
         else begin
           $display("Loading %0s\n", _vec_file_name);
           $readmemb(_vec_file_name, mem, 0, _max_index);
         end
           _end_vec_file_ok = 0;
         end
   end
   else begin
     _max_index = -1;
     _vec_pat_count = -1;
   end
   _scan_index = 0;
   _repeat_count_nest[0] = 0;
   _repeat_count = 0;
   _repeat_depth = 0;
   _message_index = 0;
   _save_index[0] = 0;
   _found_fail_obus =3'b000;
   for (_index=0; _index <= _max_index; _index = _index+1)
   begin
      vect = mem[_index];
      _exp_obus=3'bXXX;
      _msk_obus=3'b000;
      _MGCDFT_VECTYPE = vect[3:0];
      _pat_type = vect[6:4];
      _tp_num = vect[7];
      //    Range Check
      if ((_start_pat != -1) && ((_start_pat != 0) || (!_in_testsetup)) &&
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
        if (!_chain_test_ && _in_chaintest && !_in_range && !_in_testsetup) begin
          _in_range = 1;
          _do_compare = 1;
        end
        if ((_pat_num == _start_pat) && !_in_range) begin
          _in_range = 1;
          _do_compare = 0;
          if (_in_chaintest) begin
            _pattern_count = (_pat_num - 2);
          end
          else begin
            _pattern_count = (_pat_num - 1);
          end
          if (_pattern_count < 0) begin
            _pattern_count = 0;
          end
        end
        if (_pat_num == (_start_pat + 1)) begin
          _do_compare = 1;
        end
      end

      if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
          ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_index > 0) && (_end_pat != -1) && !_chain_test_ && _in_chaintest &&
          !_run_testsetup) begin
         // simulation complete, exit
         _index = _max_index + 1;
         _end_vec_file_ok = 1;
         _end_simulation = 1;
      end
      if ((_in_range) || (_run_testsetup)) begin
      case (_pat_type)
         3'b000:  begin // end vector
            _index = _max_index + 1;
         end // end vector
         3'b001: ;// skip scan vector, handled by shift vector
         3'b010:  begin // broadside vector
            _found_fail_per_cycle = 0;
            _found_fail_obus =3'b000;
            if (vect[8] == 1'b1) begin
               _pattern_count = _pattern_count + 1;
               _par_shift_cnt = 0;
              if ((!_do_compare) && (_pattern_count >= _start_pat)) begin
                _do_compare = 1;
              end
              if ((_end_pat != -1) && (_pattern_count > _end_pat) && 
                  ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
                // simulation complete, exit
                _index = _max_index + 1;
                _end_vec_file_ok = 1;
                _end_simulation = 1;
                _in_range = 0;
              end
            end
            if (vect[8] === 1'bz) begin
               _pattern_count = 0;
               _par_shift_cnt = 0;
            end
            if(_scan_shift_count) begin
               _scan_shift_count = _scan_shift_count + 1;
            end
            case (_tp_num)
               1'b1: begin // timeplate 1 - gen_tp1
                  _ibus[11] = 1'b0;
                  _ibus[2] = 1'b0;
                  _ibus[10:3] = vect[25:18];
                  _ibus[1:0] = vect[16:15];

                  #10; // 10 ns
                  _exp_obus[2:0] = vect[14:12];
                  _msk_obus[2:0] = vect[11:9];
                  #0;
                  ->compare_exp_sim_obus;
                  if ((_miscompare_limit)&&(_compare_fail>=_miscompare_limit)) begin
                    $display("ERROR: exceeded miscompare limit(%d), exiting simulation",_miscompare_limit);
                    _end_vec_file_ok = 1;
                    if (_DIAG_file_header == 1) begin
                       $fwrite(_diag_file, " failures_end\n");
                       $fwrite(_diag_file, " failure_buffer_limit_reached none\n");
                       if (_diag_scan_header==1) begin
                         $fwrite(_diag_file, "last_cycle_applied %d\n", (_cycle_count-1));
                       end
                       $fwrite(_diag_file, "total_cycles 2695\n");
                       $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
                       $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
                       $fwrite(_diag_file, "failure_file_end\n");
                       $fclose(_diag_file);
                    end
                    ->before_finish;
                    #0;
                    $finish;
                  end

                  #10; // 20 ns
                  _ibus[11] = vect[26];
                  _ibus[2] = vect[17];

                  #10; // 30 ns
                  _ibus[11] = 1'b0;
                  _ibus[2] = 1'b0;

                  #10; // 40 ns
               end // timeplate 1 - gen_tp1
               1'b0: begin // timeplate 2 - gen_tp1_ijtag_ctrl
                  _ibus[11] = 1'b0;
                  _ibus[2] = 1'b0;
                  _ibus[10] = vect[25];
                  _ibus[5:3] = vect[20:18];
                  _ibus[1:0] = vect[16:15];

                  #10; // 10 ns
                  _exp_obus[2:0] = vect[14:12];
                  _msk_obus[2:0] = vect[11:9];
                  #0;
                  ->compare_exp_sim_obus;
                  if ((_miscompare_limit)&&(_compare_fail>=_miscompare_limit)) begin
                    $display("ERROR: exceeded miscompare limit(%d), exiting simulation",_miscompare_limit);
                    _end_vec_file_ok = 1;
                    if (_DIAG_file_header == 1) begin
                       $fwrite(_diag_file, " failures_end\n");
                       $fwrite(_diag_file, " failure_buffer_limit_reached none\n");
                       if (_diag_scan_header==1) begin
                         $fwrite(_diag_file, "last_cycle_applied %d\n", (_cycle_count-1));
                       end
                       $fwrite(_diag_file, "total_cycles 2695\n");
                       $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
                       $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
                       $fwrite(_diag_file, "failure_file_end\n");
                       $fclose(_diag_file);
                    end
                    ->before_finish;
                    #0;
                    $finish;
                  end

                  #10; // 20 ns
                  _ibus[11] = vect[26];
                  _ibus[2] = vect[17];

                  #4; // 24 ns
                  _ibus[7] = vect[22];

                  #6; // 30 ns
                  _ibus[11] = 1'b0;
                  _ibus[2] = 1'b0;

                  #9; // 39 ns
                  _ibus[9:8] = vect[24:23];
                  _ibus[6] = vect[21];

                  #1; // 40 ns
               end // timeplate 2 - gen_tp1_ijtag_ctrl
               default: begin
                  $display("ERROR: corrupt timeplate number\n");
                  ->before_finish;
                  #0;
                  $finish;
               end
            endcase // _tp_num
            _cycle_count = _cycle_count + 1;
            _par_shift_cnt = 0;
         end // broadside vector
         3'b011:  begin // status message vector
            _message_index = vect[38:7];
            case (_message_index)
               0: begin
                  $display("Begin chain test\n");
                 _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                 _chain_test_ = 0;
                  if (_diag_chain_header) begin
                    $fwrite(_diag_file, " last_cycle_applied %d\n", _cycle_count);
                  end
                  _diag_scan_header = 0;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = -1;
                  _pattern_count = 0;
                  $display("End chain test\n");
               end
               2: begin
                  $display("Status update: simulated through pattern %d\n",_pattern_count);
               end
               3: begin
                  _end_vec_file_ok = 1;
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (!_chain_test_) begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if ((_start_pat > -1) || (_end_pat > -1)) begin
                    if (_pat_num > -1) begin
                      if (_chain_test_) begin
                        $display("Simulated chain pattern %d\n",_pat_num);
                      end
                      else begin
                        $display("Simulated pattern %d\n",_pat_num);
                      end
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               5: begin // increment pattern count
                 _pattern_count = _pattern_count + 1;
                 _par_shift_cnt = 0;
                 if ((_end_pat != -1) && (_pattern_count > (_end_pat - 1)) && 
                     ((!_chain_test_)||(_chain_test_ && _in_chaintest))) begin
                   // simulation complete, exit
                    _index = _max_index + 1;
                   _end_vec_file_ok = 1;
                   _end_simulation = 1;
                   _in_range = 0;
                 end
               end
               20: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_inst.sib ");
                  end
               end
               21: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_sri_ctrl_inst.sib ");
                  end
               end
               22: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_edt_inst.sib ");
                  end
               end
               23: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_occ_inst.sib ");
                  end
               end
               24: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_sib_lbist_inst.sib ");
                  end
               end
               25: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[0] ");
                  end
               end
               26: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[1] ");
                  end
               end
               27: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[2] ");
                  end
               end
               28: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[3] ");
                  end
               end
               29: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[4] ");
                  end
               end
               30: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[5] ");
                  end
               end
               31: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[6] ");
                  end
               end
               32: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[7] ");
                  end
               end
               33: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[8] ");
                  end
               end
               34: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[9] ");
                  end
               end
               35: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_tdr_sri_ctrl_inst.tdr[10] ");
                  end
               end
               36: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.ijtag_so_ff ");
                  end
               end
               37: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_edt_sib_i.sib ");
                  end
               end
               38: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_control_registers_i.sib ");
                  end
               end
               39: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_sib_bist_registers_i.sib ");
                  end
               end
               40: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_inst.single_chain_sib_i.sib ");
                  end
               end
               41: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_single_chain_mode_logic_inst.tdr_sib_i.sib ");
                  end
               end
               42: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.bist_setup[0] ");
                  end
               end
               43: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.bist_setup[1] ");
                  end
               end
               44: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.bist_setup[2] ");
                  end
               end
               45: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.bist_clock_disable ");
                  end
               end
               46: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.bist_sync_reset ");
                  end
               end
               47: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.shift_clock_select[0] ");
                  end
               end
               48: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.shift_clock_select[1] ");
                  end
               end
               49: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.lbist_burn_in_reg ");
                  end
               end
               50: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_lbist_inst.lbist_low_power_shift_en_reg ");
                  end
               end
               51: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_tdr_inst.tdr[0] ");
                  end
               end
               52: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr_sib.sib ");
                  end
               end
               53: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr_sib.sib ");
                  end
               end
               54: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_misr_i.sib ");
                  end
               end
               55: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_chain_mask_i.sib ");
                  end
               end
               56: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_mask_shift_reg_i.sib ");
                  end
               end
               57: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_lbist_lp_static_control_i.sib ");
                  end
               end
               58: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_lbist_c1_inst.msrv_soc_uncorewrapper_pass2_rtl_tessent_edt_c1_sib_decompressor_i.sib ");
                  end
               end
               59: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[0] ");
                  end
               end
               60: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[1] ");
                  end
               end
               61: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[2] ");
                  end
               end
               62: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[3] ");
                  end
               end
               63: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[4] ");
                  end
               end
               64: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[5] ");
                  end
               end
               65: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[6] ");
                  end
               end
               66: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[7] ");
                  end
               end
               67: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[8] ");
                  end
               end
               68: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_HCLK_inst.tdr[9] ");
                  end
               end
               69: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[0] ");
                  end
               end
               70: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[1] ");
                  end
               end
               71: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[2] ");
                  end
               end
               72: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[3] ");
                  end
               end
               73: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[4] ");
                  end
               end
               74: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[5] ");
                  end
               end
               75: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[6] ");
                  end
               end
               76: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[7] ");
                  end
               end
               77: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[8] ");
                  end
               end
               78: begin
                  if (_found_fail_obus[2] === 1'b1) begin
                    $display($realtime, "ns: Previous scan out : pin ijtag_so , ICL register = msrv_soc_uncorewrapper_pass2_rtl_tessent_occ_PCLK_inst.tdr[9] ");
                  end
               end
               default: begin
                  $display("ERROR: corrupt message index\n");
                  if (_allow_bad_message_index != 1) begin
                     ->before_finish;
                     #0;
                     $finish;
                  end
               end
            endcase // _message_index
         end
         default: begin
            $display("ERROR: corrupt vector number\n");
            ->before_finish;
            #0;
            $finish;
         end
      endcase
   end // if in_range
      else begin
      case (_pat_type)  // _pat_type = vect[6:4]; 
         3'b011:  begin // status message vector
            _message_index = vect[38:7];
            case (_message_index)
               0: begin
                  _chain_test_ = 1;
                  _diag_chain_header = 0;
               end
               1: begin
                  if (_pat_num > -1) begin
                    $display("Skipped chain pattern %d\n",_pat_num);
                  end
                  _chain_test_ = 0;
                  _pat_num = -1;
                  $display("End chain test\n");
               end
               3: begin 
                  _end_vec_file_ok = 1;
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
               end
               4: begin // start of atpg pattern
                  if (_pat_num > -1) begin
                    if (!_chain_test_) begin
                      _skipped_patterns = _skipped_patterns + 1;
                    end
                  end
                  if (_pat_num > -1) begin
                    if (_chain_test_) begin
                      $display("Skipped chain pattern %d\n",_pat_num);
                    end
                    else begin
                      $display("Skipped pattern %d\n",_pat_num);
                    end
                  end
                  _pat_num = _pat_num + 1;
                  _run_testsetup  = 0;
                  _in_testsetup  = 0;
                  if (_end_after_setup  > 0) begin
                    //simulation complete, exit
                    _index = _max_index + 1;
                    _end_vec_file_ok = 1;
                    _end_simulation = 1;
                    _in_range = 0;
                  end
               end
               default: begin
                  // Skip
               end
            endcase // _message_index
         end
         default: begin
            // Skip
         end
      endcase
      end // else !_in_range
   end // index loop
end // file_cnt loop

if (_save_state == 1) begin
  #1;
  mgcdft_save_signal = 1'b1;
//  $display("Writing checkpoint msrv_soc_uncorewrapper_stuck_serial.v.dat");
//  $save("msrv_soc_uncorewrapper_stuck_serial.v.dat");
  if (_in_restart == 2) begin
    _in_restart = 1;
  end
  #1;
  $stop;
end
end
end  // while _in_restart
 if (_DIAG_file_header == 1) begin
    $fwrite(_diag_file, " failures_end\n");
    $fwrite(_diag_file, " failure_buffer_limit_reached none\n");
    if (_diag_scan_header==1) begin
      $fwrite(_diag_file, "last_cycle_applied %d\n", (_cycle_count-1));
    end
    $fwrite(_diag_file, "total_cycles 2695\n");
    $fwrite(_diag_file, "// failing_patterns=%d simulated_patterns=%d", _fail_pattern_cnt, (_pattern_count+1));
    $fwrite(_diag_file, " simulation_time=", $realtime, ";\n");
    $fwrite(_diag_file, "failure_file_end\n");
    $fclose(_diag_file);
 end


#1;
if (_end_vec_file_ok == 0) begin
  $display("ERROR: Pattern file corrupted, simulation aborted\n");
end
if ((_end_vec_file_ok) && (_compare_fail == 0)) begin
   $display("No error between simulated and expected patterns\n");
end

if (_compare_fail != 0) begin
   $display("Error between simulated and expected patterns\n");
end

#1;
->before_finish;
#0;
$finish;
end
endmodule
