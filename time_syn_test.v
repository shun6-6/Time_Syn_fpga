`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2024 07:35:21 PM
// Design Name: 
// Module Name: time_syn_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module time_syn_test(
    input                       i_dclk_p        ,
    input                       i_dclk_n        ,
    input                       i_gt_refclk_p   ,
    input                       i_gt_refclk_n   ,

    output [1 : 0]  o_sfp_disable   ,
    output [1 : 0]  o_chnl_led      ,

    input  [1 : 0]  i_gt_rxp        ,
    input  [1 : 0]  i_gt_rxn        ,
    output [1 : 0]  o_gt_txp        ,
    output [1 : 0]  o_gt_txn        
);

assign o_sfp_disable = 2'b00;

localparam   MIN_LENGTH     = 8'd64      ;
localparam   MAX_LENGTH     = 15'd9600   ;

wire        sys_rst;
wire        dclk;
wire        locked;
//   assign      sys_rst = ~locked && i_sys_rst;
   assign      sys_rst = ~locked;

wire [2 :0] gt_loopback_in_0                    ;
wire        qpllreset_in_0                      ;
wire        tx_clk_out_0                        ;
wire        rx_clk_out_0                        ;
wire        rx_core_clk_0                       ;
wire [2 :0] txoutclksel_in_0                    ;
wire [2 :0] rxoutclksel_in_0                    ;
wire        gtwiz_reset_tx_datapath_0           ;
wire        gtwiz_reset_rx_datapath_0           ;
wire        rxrecclkout_0                       ;
wire        gt_refclk_out                       ;
wire        gtpowergood_out_0                   ;
wire        rx_reset_0                          ;
wire        user_rx_reset_0                     ;
/*----ctrl rx----*/         
wire        ctl_rx_enable_0                     ;
wire        ctl_rx_check_preamble_0             ;
wire        ctl_rx_check_sfd_0                  ;
wire        ctl_rx_force_resync_0               ;
wire        ctl_rx_delete_fcs_0                 ;
wire        ctl_rx_ignore_fcs_0                 ;
wire [14:0] ctl_rx_max_packet_len_0             ;
wire [7 :0] ctl_rx_min_packet_len_0             ;
wire        ctl_rx_process_lfi_0                ;
wire        ctl_rx_test_pattern_0               ;
wire        ctl_rx_data_pattern_select_0        ;
wire        ctl_rx_test_pattern_enable_0        ;
wire        ctl_rx_custom_preamble_enable_0     ;
/*----RX_0 Stats Signals----*/  
wire        stat_rx_framing_err_0           ;
wire        stat_rx_framing_err_valid_0     ;
wire        stat_rx_local_fault_0           ;
wire        stat_rx_block_lock_0            ;
wire        stat_rx_valid_ctrl_code_0       ;
wire        stat_rx_status_0                ;
wire        stat_rx_remote_fault_0          ;
wire [1 :0] stat_rx_bad_fcs_0_0             ;
wire [1 :0] stat_rx_stomped_fcs_0           ;
wire        stat_rx_truncated_0             ;
wire        stat_rx_internal_local_fault_0  ;
wire        stat_rx_received_local_fault_0  ;
wire        stat_rx_hi_ber_0                ;
wire        stat_rx_got_signal_os_0         ;
wire        stat_rx_test_pattern_mismatch_0 ;
wire [3 :0] stat_rx_total_bytes_0           ;
wire [1 :0] stat_rx_total_packets_0         ;
wire [13:0] stat_rx_total_good_bytes        ;
wire        stat_rx_total_good_packets_0    ;
wire        stat_rx_packet_bad_fcs_0        ;
wire        stat_rx_packet_64_bytes_0       ;
wire        stat_rx_packet_65_127_bytes_0   ;
wire        stat_rx_packet_128_255_bytes_0  ;
wire        stat_rx_packet_256_511_bytes_0  ;
wire        stat_rx_packet_512_1023_bytes_0 ;
wire        stat_rx_packet_1024_1518_bytes_0;
wire        stat_rx_packet_1519_1522_bytes_0;
wire        stat_rx_packet_1523_1548_bytes_0;
wire        stat_rx_packet_1549_2047_bytes_0;
wire        stat_rx_packet_2048_4095_bytes_0;
wire        stat_rx_packet_4096_8191_bytes_0;
wire        stat_rx_packet_8192_9215_bytes_0;
wire        stat_rx_packet_small_0          ;
wire        stat_rx_packet_large_0          ;
wire        stat_rx_unicast_0               ;
wire        stat_rx_multicast_0             ;
wire        stat_rx_broadcast_0             ;
wire        stat_rx_oversize_0              ;
wire        stat_rx_toolong_0               ;
wire        stat_rx_undersize_0             ;
wire        stat_rx_fragment_0              ;
wire        stat_rx_vlan_0                  ;
wire        stat_rx_inrangeerr_0            ;
wire        stat_rx_jabber_0                ;
wire        stat_rx_bad_code_0              ;
wire        stat_rx_bad_sfd_0               ;
wire        stat_rx_bad_preamble_0          ;
/*----tx single----*/
wire        tx_reset_0                      ;
wire        user_tx_reset_0                 ;
wire        tx_unfout_0                     ;
wire [55:0] tx_preamblein_0                 ;
wire [55:0] rx_preambleout_0                ;
wire        ctl_tx_enable_0                 ;
wire        ctl_tx_send_rfi_0               ;
wire        ctl_tx_send_lfi_0               ;
wire        ctl_tx_send_idle_0              ;
wire        ctl_tx_fcs_ins_enable_0         ;
wire        ctl_tx_ignore_fcs_0             ;
wire        ctl_tx_test_pattern_0           ;
wire        ctl_tx_test_pattern_enable_0    ;
wire        ctl_tx_test_pattern_select_0    ;
wire        ctl_tx_data_pattern_select_0    ;
wire [57:0] ctl_tx_test_pattern_seed_a_0    ;
wire [57:0] ctl_tx_test_pattern_seed_b_0    ;
wire [3 :0] ctl_tx_ipg_value_0              ;
wire        ctl_tx_custom_preamble_enable_0 ;

wire        stat_tx_local_fault_0            ;
wire [3 :0] stat_tx_total_bytes_0            ;
wire        stat_tx_total_packets_0          ;
wire [13:0] stat_tx_total_good_bytes_0       ;
wire        stat_tx_total_good_packets_0     ;
wire        stat_tx_bad_fcs_0                ;
wire        stat_tx_packet_64_bytes_0        ;
wire        stat_tx_packet_65_127_bytes_0    ;
wire        stat_tx_packet_128_255_bytes_0   ;
wire        stat_tx_packet_256_511_bytes_0   ;
wire        stat_tx_packet_512_1023_bytes_0  ;
wire        stat_tx_packet_1024_1518_bytes_0 ;
wire        stat_tx_packet_1519_1522_bytes_0 ;
wire        stat_tx_packet_1523_1548_bytes_0 ;
wire        stat_tx_packet_1549_2047_bytes_0 ;
wire        stat_tx_packet_2048_4095_bytes_0 ;
wire        stat_tx_packet_4096_8191_bytes_0 ;
wire        stat_tx_packet_8192_9215_bytes_0 ;
wire        stat_tx_packet_small_0           ;
wire        stat_tx_packet_large_0           ;
wire        stat_tx_unicast_0                ;
wire        stat_tx_multicast_0              ;
wire        stat_tx_broadcast_0              ;
wire        stat_tx_vlan_0                   ;
wire        stat_tx_frame_error_0            ;
//axis
wire        rx_axis_tvalid_0    ;
wire [63:0] rx_axis_tdata_0     ;
wire        rx_axis_tlast_0     ;
wire [7 :0] rx_axis_tkeep_0     ;
wire        rx_axis_tuser_0     ;
wire [15:0] w_recv_cnt          ;                

wire        w_tx_start          ;
wire        tx_axis_tready_0    ;
wire        tx_axis_tvalid_0    ;
wire [63:0] tx_axis_tdata_0     ;
wire        tx_axis_tlast_0     ;
wire [7 :0] tx_axis_tkeep_0     ;
wire        tx_axis_tuser_0     ;
wire        sync_stat_rx_status_0;

//sfp1
wire [2 :0] gt_loopback_in_1                    ;
wire        qpllreset_in_1                      ;
wire        tx_clk_out_1                        ;
wire        rx_clk_out_1                        ;
wire        rx_core_clk_1                       ;
wire [2 :0] txoutclksel_in_1                    ;
wire [2 :0] rxoutclksel_in_1                    ;
wire        gtwiz_reset_tx_datapath_1           ;
wire        gtwiz_reset_rx_datapath_1           ;
wire        rxrecclkout_1                       ;
wire        gtpowergood_out_1                   ;
wire        rx_reset_1                          ;
wire        user_rx_reset_1                     ;
/*----ctrl rx----*/         
wire        ctl_rx_enable_1                     ;
wire        ctl_rx_check_preamble_1             ;
wire        ctl_rx_check_sfd_1                  ;
wire        ctl_rx_force_resync_1               ;
wire        ctl_rx_delete_fcs_1                 ;
wire        ctl_rx_ignore_fcs_1                 ;
wire [14:0] ctl_rx_max_packet_len_1             ;
wire [7 :0] ctl_rx_min_packet_len_1             ;
wire        ctl_rx_process_lfi_1                ;
wire        ctl_rx_test_pattern_1               ;
wire        ctl_rx_data_pattern_select_1        ;
wire        ctl_rx_test_pattern_enable_1        ;
wire        ctl_rx_custom_preamble_enable_1     ;
/*----RX_0 Stats Signals----*/  
wire        stat_rx_framing_err_1           ;
wire        stat_rx_framing_err_valid_1     ;
wire        stat_rx_local_fault_1           ;
wire        stat_rx_block_lock_1            ;
wire        stat_rx_valid_ctrl_code_1       ;
wire        stat_rx_status_1                ;
wire        stat_rx_remote_fault_1          ;
wire [1 :0] stat_rx_bad_fcs_1               ;
wire [1 :0] stat_rx_stomped_fcs_1           ;
wire        stat_rx_truncated_1             ;
wire        stat_rx_internal_local_fault_1  ;
wire        stat_rx_received_local_fault_1  ;
wire        stat_rx_hi_ber_1                ;
wire        stat_rx_got_signal_os_1         ;
wire        stat_rx_test_pattern_mismatch_1 ;
wire [3 :0] stat_rx_total_bytes_1           ;
wire [1 :0] stat_rx_total_packets_1         ;
wire [13:0] stat_rx_total_good_bytes_1      ;
wire        stat_rx_total_good_packets_1    ;
wire        stat_rx_packet_bad_fcs_1        ;
wire        stat_rx_packet_64_bytes_1       ;
wire        stat_rx_packet_65_127_bytes_1   ;
wire        stat_rx_packet_128_255_bytes_1  ;
wire        stat_rx_packet_256_511_bytes_1  ;
wire        stat_rx_packet_512_1023_bytes_1 ;
wire        stat_rx_packet_1024_1518_bytes_1;
wire        stat_rx_packet_1519_1522_bytes_1;
wire        stat_rx_packet_1523_1548_bytes_1;
wire        stat_rx_packet_1549_2047_bytes_1;
wire        stat_rx_packet_2048_4095_bytes_1;
wire        stat_rx_packet_4096_8191_bytes_1;
wire        stat_rx_packet_8192_9215_bytes_1;
wire        stat_rx_packet_small_1          ;
wire        stat_rx_packet_large_1          ;
wire        stat_rx_unicast_1               ;
wire        stat_rx_multicast_1             ;
wire        stat_rx_broadcast_1             ;
wire        stat_rx_oversize_1              ;
wire        stat_rx_toolong_1               ;
wire        stat_rx_undersize_1             ;
wire        stat_rx_fragment_1              ;
wire        stat_rx_vlan_1                  ;
wire        stat_rx_inrangeerr_1            ;
wire        stat_rx_jabber_1                ;
wire        stat_rx_bad_code_1              ;
wire        stat_rx_bad_sfd_1               ;
wire        stat_rx_bad_preamble_1          ;
/*----tx single----*/
wire        tx_reset_1                      ;
wire        user_tx_reset_1                 ;
wire        tx_unfout_1                     ;
wire [55:0] tx_preamblein_1                 ;
wire [55:0] rx_preambleout_1                ;
wire        ctl_tx_enable_1                 ;
wire        ctl_tx_send_rfi_1               ;
wire        ctl_tx_send_lfi_1               ;
wire        ctl_tx_send_idle_1              ;
wire        ctl_tx_fcs_ins_enable_1         ;
wire        ctl_tx_ignore_fcs_1             ;
wire        ctl_tx_test_pattern_1           ;
wire        ctl_tx_test_pattern_enable_1    ;
wire        ctl_tx_test_pattern_select_1    ;
wire        ctl_tx_data_pattern_select_1    ;
wire [57:0] ctl_tx_test_pattern_seed_a_1    ;
wire [57:0] ctl_tx_test_pattern_seed_b_1    ;
wire [3 :0] ctl_tx_ipg_value_1              ;
wire        ctl_tx_custom_preamble_enable_1 ;

wire        stat_tx_local_fault_1            ;
wire [3 :0] stat_tx_total_bytes_1            ;
wire        stat_tx_total_packets_1          ;
wire [13:0] stat_tx_total_good_bytes_1       ;
wire        stat_tx_total_good_packets_1     ;
wire        stat_tx_bad_fcs_1                ;
wire        stat_tx_packet_64_bytes_1        ;
wire        stat_tx_packet_65_127_bytes_1    ;
wire        stat_tx_packet_128_255_bytes_1   ;
wire        stat_tx_packet_256_511_bytes_1   ;
wire        stat_tx_packet_512_1023_bytes_1  ;
wire        stat_tx_packet_1024_1518_bytes_1 ;
wire        stat_tx_packet_1519_1522_bytes_1 ;
wire        stat_tx_packet_1523_1548_bytes_1 ;
wire        stat_tx_packet_1549_2047_bytes_1 ;
wire        stat_tx_packet_2048_4095_bytes_1 ;
wire        stat_tx_packet_4096_8191_bytes_1 ;
wire        stat_tx_packet_8192_9215_bytes_1 ;
wire        stat_tx_packet_small_1           ;
wire        stat_tx_packet_large_1           ;
wire        stat_tx_unicast_1                ;
wire        stat_tx_multicast_1              ;
wire        stat_tx_broadcast_1              ;
wire        stat_tx_vlan_1                   ;
wire        stat_tx_frame_error_1            ;

//sfp1
wire        rx_axis_tvalid_1        ;
wire [63:0] rx_axis_tdata_1         ;
wire        rx_axis_tlast_1         ;
wire [7 :0] rx_axis_tkeep_1         ;
wire        rx_axis_tuser_1         ;
wire [15:0] w_recv_cnt_1            ;  

wire        tx_axis_tready_1        ;
wire        tx_axis_tvalid_1        ;
wire [63:0] tx_axis_tdata_1         ;
wire        tx_axis_tlast_1         ;
wire [7 :0] tx_axis_tkeep_1         ;
wire        tx_axis_tuser_1         ;
wire        sync_stat_rx_status_1   ;


assign o_chnl_led                       = {stat_rx_status_0,stat_rx_status_1};

assign gt_loopback_in_0                 = 3'b000        ;
assign rx_core_clk_0                    = tx_clk_out_0  ; 
assign txoutclksel_in_0                 = 3'b101        ;
assign rxoutclksel_in_0                 = 3'b101        ;
assign gtwiz_reset_tx_datapath_0        = 1'b0          ;
assign gtwiz_reset_rx_datapath_0        = 1'b0          ;
assign rx_reset_0                       = 1'b0          ;
assign qpllreset_in_0                   = 1'b0          ;
/*----ctrl rx----*/ 
assign ctl_rx_enable_0                  = 1'b1          ;
assign ctl_rx_check_preamble_0          = 1'b1          ;
assign ctl_rx_check_sfd_0               = 1'b1          ;
assign ctl_rx_force_resync_0            = 1'b0          ;
assign ctl_rx_delete_fcs_0              = 1'b1          ;
assign ctl_rx_ignore_fcs_0              = 1'b0          ;
assign ctl_rx_max_packet_len_0          = MAX_LENGTH    ;
assign ctl_rx_min_packet_len_0          = MIN_LENGTH    ;
assign ctl_rx_process_lfi_0             = 1'b0          ;
assign ctl_rx_test_pattern_0            = 1'b0          ;
assign ctl_rx_test_pattern_enable_0     = 1'b0          ;
assign ctl_rx_data_pattern_select_0     = 1'b0          ;
assign ctl_rx_custom_preamble_enable_0  = 1'b0          ;
/*----tx single----*/
assign tx_preamblein_0                  = 55'h55_55_55_55_55_55_55;
assign tx_reset_0                       = 1'b0          ;
assign ctl_tx_enable_0                  = 1'b1          ;
assign ctl_tx_send_rfi_0                = 1'b0          ;
assign ctl_tx_send_lfi_0                = 1'b0          ;
assign ctl_tx_send_idle_0               = 1'b0          ;
assign ctl_tx_fcs_ins_enable_0          = 1'b1          ;
assign ctl_tx_ignore_fcs_0              = 1'b0          ;
assign ctl_tx_test_pattern_0            = 'd0           ;
assign ctl_tx_test_pattern_enable_0     = 'd0           ;
assign ctl_tx_test_pattern_select_0     = 'd0           ;
assign ctl_tx_data_pattern_select_0     = 'd0           ;
assign ctl_tx_test_pattern_seed_a_0     = 'd0           ;
assign ctl_tx_test_pattern_seed_b_0     = 'd0           ;
assign ctl_tx_ipg_value_0               = 4'd12         ;
assign ctl_tx_custom_preamble_enable_0  = 1'b0          ;

/*======================= sfp1 =========================*/
assign gt_loopback_in_1                 = 3'b000        ;
assign rx_core_clk_1                    = tx_clk_out_0  ; 
assign txoutclksel_in_1                 = 3'b101        ;
assign rxoutclksel_in_1                 = 3'b101        ;
assign gtwiz_reset_tx_datapath_1        = 1'b0          ;
assign gtwiz_reset_rx_datapath_1        = 1'b0          ;
assign rx_reset_1                       = 1'b0          ;
assign qpllreset_in_1                   = 1'b0          ;
/*----ctrl rx----*/ 
assign ctl_rx_enable_1                  = 1'b1          ;
assign ctl_rx_check_preamble_1          = 1'b1          ;
assign ctl_rx_check_sfd_1               = 1'b1          ;
assign ctl_rx_force_resync_1            = 1'b0          ;
assign ctl_rx_delete_fcs_1              = 1'b1          ;
assign ctl_rx_ignore_fcs_1              = 1'b0          ;
assign ctl_rx_max_packet_len_1          = MAX_LENGTH    ;
assign ctl_rx_min_packet_len_1          = MIN_LENGTH    ;
assign ctl_rx_process_lfi_1             = 1'b0          ;
assign ctl_rx_test_pattern_1            = 1'b0          ;
assign ctl_rx_test_pattern_enable_1     = 1'b0          ;
assign ctl_rx_data_pattern_select_1     = 1'b0          ;
assign ctl_rx_custom_preamble_enable_1  = 1'b0          ;
/*----tx single----*/
assign tx_preamblein_1                  = 55'h55_55_55_55_55_55_55;
assign tx_reset_1                       = 1'b0          ;
assign ctl_tx_enable_1                  = 1'b1          ;
assign ctl_tx_send_rfi_1                = 1'b0          ;
assign ctl_tx_send_lfi_1                = 1'b0          ;
assign ctl_tx_send_idle_1               = 1'b0          ;
assign ctl_tx_fcs_ins_enable_1          = 1'b1          ;
assign ctl_tx_ignore_fcs_1              = 1'b0          ;
assign ctl_tx_test_pattern_1            = 'd0           ;
assign ctl_tx_test_pattern_enable_1     = 'd0           ;
assign ctl_tx_test_pattern_select_1     = 'd0           ;
assign ctl_tx_data_pattern_select_1     = 'd0           ;
assign ctl_tx_test_pattern_seed_a_1     = 'd0           ;
assign ctl_tx_test_pattern_seed_b_1     = 'd0           ;
assign ctl_tx_ipg_value_1               = 4'd12         ;
assign ctl_tx_custom_preamble_enable_1  = 1'b0          ;

clk_wiz_100mhz clk_wiz_100mhz_u0
(
    .clk_out1   (dclk       ),     // output clk_out1
    .locked     (locked     ),       // output locked
    .clk_in1_p  (i_dclk_p   ),    // input clk_in1_p
    .clk_in1_n  (i_dclk_n   )    // input clk_in1_n
 );

xxv_ethernet_0 xxv_ethernet_0_u0 (
  .gt_txp_out                       (o_gt_txp                           ),      // output wire [0 : 0] gt_txp_out
  .gt_txn_out                       (o_gt_txn                           ),      // output wire [0 : 0] gt_txn_out
  .gt_rxp_in                        (i_gt_rxp                           ),      // input wire [0 : 0] gt_rxp_in
  .gt_rxn_in                        (i_gt_rxn                           ),      // input wire [0 : 0] gt_rxn_in
  .rx_core_clk_0                    (rx_core_clk_0                      ),      // input wire rx_core_clk_0
  .txoutclksel_in_0                 (txoutclksel_in_0                   ),      // input wire [2 : 0] txoutclksel_in_0
  .rxoutclksel_in_0                 (rxoutclksel_in_0                   ),      // input wire [2 : 0] rxoutclksel_in_0
  .gtwiz_reset_tx_datapath_0        (gtwiz_reset_tx_datapath_0          ),      // input wire gtwiz_reset_tx_datapath_0
  .gtwiz_reset_rx_datapath_0        (gtwiz_reset_rx_datapath_0          ),      // input wire gtwiz_reset_rx_datapath_0
  .rxrecclkout_0                    (rxrecclkout_0                      ),      // output wire rxrecclkout_0
  .sys_reset                        (sys_rst                            ),      // input wire sys_reset
  .dclk                             (dclk                               ),      // input wire dclk
  .tx_clk_out_0                     (tx_clk_out_0                       ),      // output wire tx_clk_out_0
  .rx_clk_out_0                     (rx_clk_out_0                       ),      // output wire rx_clk_out_0
  .gt_refclk_p                      (i_gt_refclk_p                      ),      // input wire gt_refclk_p
  .gt_refclk_n                      (i_gt_refclk_n                      ),      // input wire gt_refclk_n
  .gt_refclk_out                    (gt_refclk_out                      ),      // output wire gt_refclk_out
  .gtpowergood_out_0                (gtpowergood_out_0                  ),      // output wire gtpowergood_out_0
  .rx_reset_0                       (rx_reset_0                         ),      // input wire rx_reset_0
  .user_rx_reset_0                  (user_rx_reset_0                    ),      // output wire user_rx_reset_0
    
  .rx_axis_tvalid_0                 (rx_axis_tvalid_0                   ),      // output wire rx_axis_tvalid_0
  .rx_axis_tdata_0                  (rx_axis_tdata_0                    ),      // output wire [63 : 0] rx_axis_tdata_0
  .rx_axis_tlast_0                  (rx_axis_tlast_0                    ),      // output wire rx_axis_tlast_0
  .rx_axis_tkeep_0                  (rx_axis_tkeep_0                    ),      // output wire [7 : 0] rx_axis_tkeep_0
  .rx_axis_tuser_0                  (rx_axis_tuser_0                    ),      // output wire rx_axis_tuser_0
    
  .ctl_rx_enable_0                  (ctl_rx_enable_0                    ),      // input wire ctl_rx_enable_0
  .ctl_rx_check_preamble_0          (ctl_rx_check_preamble_0            ),      // input wire ctl_rx_check_preamble_0
  .ctl_rx_check_sfd_0               (ctl_rx_check_sfd_0                 ),      // input wire ctl_rx_check_sfd_0
  .ctl_rx_force_resync_0            (ctl_rx_force_resync_0              ),      // input wire ctl_rx_force_resync_0
  .ctl_rx_delete_fcs_0              (ctl_rx_delete_fcs_0                ),      // input wire ctl_rx_delete_fcs_0
  .ctl_rx_ignore_fcs_0              (ctl_rx_ignore_fcs_0                ),      // input wire ctl_rx_ignore_fcs_0
  .ctl_rx_max_packet_len_0          (ctl_rx_max_packet_len_0            ),      // input wire [14 : 0] ctl_rx_max_packet_len_0
  .ctl_rx_min_packet_len_0          (ctl_rx_min_packet_len_0            ),      // input wire [7 : 0] ctl_rx_min_packet_len_0
  .ctl_rx_process_lfi_0             (ctl_rx_process_lfi_0               ),      // input wire ctl_rx_process_lfi_0
  .ctl_rx_test_pattern_0            (ctl_rx_test_pattern_0              ),      // input wire ctl_rx_test_pattern_0
  .ctl_rx_data_pattern_select_0     (ctl_rx_data_pattern_select_0       ),      // input wire ctl_rx_data_pattern_select_0
  .ctl_rx_test_pattern_enable_0     (ctl_rx_test_pattern_enable_0       ),      // input wire ctl_rx_test_pattern_enable_0
  .ctl_rx_custom_preamble_enable_0  (ctl_rx_custom_preamble_enable_0    ),      // input wire ctl_rx_custom_preamble_enable_0
    
  .stat_rx_framing_err_0            (stat_rx_framing_err_0              ),      // output wire stat_rx_framing_err_0
  .stat_rx_framing_err_valid_0      (stat_rx_framing_err_valid_0        ),      // output wire stat_rx_framing_err_valid_0
  .stat_rx_local_fault_0            (stat_rx_local_fault_0              ),      // output wire stat_rx_local_fault_0
  .stat_rx_block_lock_0             (stat_rx_block_lock_0               ),      // output wire stat_rx_block_lock_0
  .stat_rx_valid_ctrl_code_0        (stat_rx_valid_ctrl_code_0          ),      // output wire stat_rx_valid_ctrl_code_0
  .stat_rx_status_0                 (stat_rx_status_0                   ),      // output wire stat_rx_status_0
  .stat_rx_remote_fault_0           (stat_rx_remote_fault_0             ),      // output wire stat_rx_remote_fault_0
  .stat_rx_bad_fcs_0                (stat_rx_bad_fcs_0                  ),      // output wire [1 : 0] stat_rx_bad_fcs_0_0
  .stat_rx_stomped_fcs_0            (stat_rx_stomped_fcs_0              ),      // output wire [1 : 0] stat_rx_stomped_fcs_0
  .stat_rx_truncated_0              (stat_rx_truncated_0                ),      // output wire stat_rx_truncated_0
  .stat_rx_internal_local_fault_0   (stat_rx_internal_local_fault_0     ),      // output wire stat_rx_internal_local_fault_0
  .stat_rx_received_local_fault_0   (stat_rx_received_local_fault_0     ),      // output wire stat_rx_received_local_fault_0
  .stat_rx_hi_ber_0                 (stat_rx_hi_ber_0                   ),      // output wire stat_rx_hi_ber_0
  .stat_rx_got_signal_os_0          (stat_rx_got_signal_os_0            ),      // output wire stat_rx_got_signal_os_0
  .stat_rx_test_pattern_mismatch_0  (stat_rx_test_pattern_mismatch_0    ),      // output wire stat_rx_test_pattern_mismatch_0
  .stat_rx_total_bytes_0            (stat_rx_total_bytes_0              ),      // output wire [3 : 0] stat_rx_total_bytes_0
  .stat_rx_total_packets_0          (stat_rx_total_packets_0            ),      // output wire [1 : 0] stat_rx_total_packets_0
  .stat_rx_total_good_bytes_0       (stat_rx_total_good_bytes_0         ),      // output wire [13 : 0] stat_rx_total_good_bytes_0
  .stat_rx_total_good_packets_0     (stat_rx_total_good_packets_0       ),      // output wire stat_rx_total_good_packets_0
  .stat_rx_packet_bad_fcs_0         (stat_rx_packet_bad_fcs_0           ),      // output wire stat_rx_packet_bad_fcs_0
  .stat_rx_packet_64_bytes_0        (stat_rx_packet_64_bytes_0          ),      // output wire stat_rx_packet_64_bytes_0
  .stat_rx_packet_65_127_bytes_0    (stat_rx_packet_65_127_bytes_0      ),      // output wire stat_rx_packet_65_127_bytes_0
  .stat_rx_packet_128_255_bytes_0   (stat_rx_packet_128_255_bytes_0     ),      // output wire stat_rx_packet_128_255_bytes_0
  .stat_rx_packet_256_511_bytes_0   (stat_rx_packet_256_511_bytes_0     ),      // output wire stat_rx_packet_256_511_bytes_0
  .stat_rx_packet_512_1023_bytes_0  (stat_rx_packet_512_1023_bytes_0    ),      // output wire stat_rx_packet_512_1023_bytes_0
  .stat_rx_packet_1024_1518_bytes_0 (stat_rx_packet_1024_1518_bytes_0   ),      // output wire stat_rx_packet_1024_1518_bytes_0
  .stat_rx_packet_1519_1522_bytes_0 (stat_rx_packet_1519_1522_bytes_0   ),      // output wire stat_rx_packet_1519_1522_bytes_0
  .stat_rx_packet_1523_1548_bytes_0 (stat_rx_packet_1523_1548_bytes_0   ),      // output wire stat_rx_packet_1523_1548_bytes_0
  .stat_rx_packet_1549_2047_bytes_0 (stat_rx_packet_1549_2047_bytes_0   ),      // output wire stat_rx_packet_1549_2047_bytes_0
  .stat_rx_packet_2048_4095_bytes_0 (stat_rx_packet_2048_4095_bytes_0   ),      // output wire stat_rx_packet_2048_4095_bytes_0
  .stat_rx_packet_4096_8191_bytes_0 (stat_rx_packet_4096_8191_bytes_0   ),      // output wire stat_rx_packet_4096_8191_bytes_0
  .stat_rx_packet_8192_9215_bytes_0 (stat_rx_packet_8192_9215_bytes_0   ),      // output wire stat_rx_packet_8192_9215_bytes_0
  .stat_rx_packet_small_0           (stat_rx_packet_small_0             ),      // output wire stat_rx_packet_small_0
  .stat_rx_packet_large_0           (stat_rx_packet_large_0             ),      // output wire stat_rx_packet_large_0
  .stat_rx_unicast_0                (stat_rx_unicast_0                  ),      // output wire stat_rx_unicast_0
  .stat_rx_multicast_0              (stat_rx_multicast_0                ),      // output wire stat_rx_multicast_0
  .stat_rx_broadcast_0              (stat_rx_broadcast_0                ),      // output wire stat_rx_broadcast_0
  .stat_rx_oversize_0               (stat_rx_oversize_0                 ),      // output wire stat_rx_oversize_0
  .stat_rx_toolong_0                (stat_rx_toolong_0                  ),      // output wire stat_rx_toolong_0
  .stat_rx_undersize_0              (stat_rx_undersize_0                ),      // output wire stat_rx_undersize_0
  .stat_rx_fragment_0               (stat_rx_fragment_0                 ),      // output wire stat_rx_fragment_0
  .stat_rx_vlan_0                   (stat_rx_vlan_0                     ),      // output wire stat_rx_vlan_0
  .stat_rx_inrangeerr_0             (stat_rx_inrangeerr_0               ),      // output wire stat_rx_inrangeerr_0
  .stat_rx_jabber_0                 (stat_rx_jabber_0                   ),      // output wire stat_rx_jabber_0
  .stat_rx_bad_code_0               (stat_rx_bad_code_0                 ),      // output wire stat_rx_bad_code_0
  .stat_rx_bad_sfd_0                (stat_rx_bad_sfd_0                  ),      // output wire stat_rx_bad_sfd_0
  .stat_rx_bad_preamble_0           (stat_rx_bad_preamble_0             ),      // output wire stat_rx_bad_preamble_0
  
  .tx_reset_0                       (tx_reset_0         ),                      // input wire tx_reset_0
  .user_tx_reset_0                  (user_tx_reset_0    ),                      // output wire user_tx_reset_0
  .tx_axis_tready_0                 (tx_axis_tready_0   ),                      // output wire tx_axis_tready_0
  .tx_axis_tvalid_0                 (0   ),                      // input wire tx_axis_tvalid_0
  .tx_axis_tdata_0                  (0   ),                      // input wire [63 : 0] tx_axis_tdata_0
  .tx_axis_tlast_0                  (0   ),                      // input wire tx_axis_tlast_0
  .tx_axis_tkeep_0                  (0   ),                      // input wire [7 : 0] tx_axis_tkeep_0
  .tx_axis_tuser_0                  (0   ),                      // input wire tx_axis_tuser_0
  .tx_unfout_0                      (tx_unfout_0        ),                      // output wire tx_unfout_0
  .tx_preamblein_0                  (tx_preamblein_0    ),                      // input wire [55 : 0] tx_preamblein_0
  .rx_preambleout_0                 (rx_preambleout_0   ),                      // output wire [55 : 0] rx_preambleout_0
  
  .stat_tx_local_fault_0            (stat_tx_local_fault_0            ), // output wire stat_tx_local_fault_0
  .stat_tx_total_bytes_0            (stat_tx_total_bytes_0            ), // output wire [3 : 0] stat_tx_total_bytes_0_0
  .stat_tx_total_packets_0          (stat_tx_total_packets_0          ), // output wire stat_tx_total_packets_0
  .stat_tx_total_good_bytes_0       (stat_tx_total_good_bytes_0       ), // output wire [13 : 0] stat_tx_total_good_bytes_0
  .stat_tx_total_good_packets_0     (stat_tx_total_good_packets_0     ), // output wire stat_tx_total_good_packets_0
  .stat_tx_bad_fcs_0                (stat_tx_bad_fcs_0                ), // output wire stat_tx_bad_fcs_0
  .stat_tx_packet_64_bytes_0        (stat_tx_packet_64_bytes_0        ), // output wire stat_tx_packet_64_bytes_0
  .stat_tx_packet_65_127_bytes_0    (stat_tx_packet_65_127_bytes_0    ), // output wire stat_tx_packet_65_127_bytes_0
  .stat_tx_packet_128_255_bytes_0   (stat_tx_packet_128_255_bytes_0   ), // output wire stat_tx_packet_128_255_bytes_0
  .stat_tx_packet_256_511_bytes_0   (stat_tx_packet_256_511_bytes_0   ), // output wire stat_tx_packet_256_511_bytes_0
  .stat_tx_packet_512_1023_bytes_0  (stat_tx_packet_512_1023_bytes_0  ), // output wire stat_tx_packet_512_1023_bytes_0
  .stat_tx_packet_1024_1518_bytes_0 (stat_tx_packet_1024_1518_bytes_0 ), // output wire stat_tx_packet_1024_1518_bytes_0
  .stat_tx_packet_1519_1522_bytes_0 (stat_tx_packet_1519_1522_bytes_0 ), // output wire stat_tx_packet_1519_1522_bytes_0
  .stat_tx_packet_1523_1548_bytes_0 (stat_tx_packet_1523_1548_bytes_0 ), // output wire stat_tx_packet_1523_1548_bytes_0
  .stat_tx_packet_1549_2047_bytes_0 (stat_tx_packet_1549_2047_bytes_0 ), // output wire stat_tx_packet_1549_2047_bytes_0
  .stat_tx_packet_2048_4095_bytes_0 (stat_tx_packet_2048_4095_bytes_0 ), // output wire stat_tx_packet_2048_4095_bytes_0
  .stat_tx_packet_4096_8191_bytes_0 (stat_tx_packet_4096_8191_bytes_0 ), // output wire stat_tx_packet_4096_8191_bytes_0
  .stat_tx_packet_8192_9215_bytes_0 (stat_tx_packet_8192_9215_bytes_0 ), // output wire stat_tx_packet_8192_9215_bytes_0
  .stat_tx_packet_small_0           (stat_tx_packet_small_0           ), // output wire stat_tx_packet_small_0
  .stat_tx_packet_large_0           (stat_tx_packet_large_0           ), // output wire stat_tx_packet_large_0
  .stat_tx_unicast_0                (stat_tx_unicast_0                ), // output wire stat_tx_unicast_0
  .stat_tx_multicast_0              (stat_tx_multicast_0              ), // output wire stat_tx_multicast_0
  .stat_tx_broadcast_0              (stat_tx_broadcast_0              ), // output wire stat_tx_broadcast_0
  .stat_tx_vlan_0                   (stat_tx_vlan_0                   ), // output wire stat_tx_vlan_00
  .stat_tx_frame_error_0            (stat_tx_frame_error_0            ), // output wire stat_tx_frame_error_0
  
  .ctl_tx_enable_0                  (ctl_tx_enable_0                ),          // input wire ctl_tx_enable_0
  .ctl_tx_send_rfi_0                (ctl_tx_send_rfi_0              ),          // input wire ctl_tx_send_rfi_0
  .ctl_tx_send_lfi_0                (ctl_tx_send_lfi_0              ),          // input wire ctl_tx_send_lfi_0
  .ctl_tx_send_idle_0               (ctl_tx_send_idle_0             ),          // input wire ctl_tx_send_idle_0
  .ctl_tx_fcs_ins_enable_0          (ctl_tx_fcs_ins_enable_0        ),          // input wire ctl_tx_fcs_ins_enable_0
  .ctl_tx_ignore_fcs_0              (ctl_tx_ignore_fcs_0            ),          // input wire ctl_tx_ignore_fcs_0
  .ctl_tx_test_pattern_0            (ctl_tx_test_pattern_0          ),          // input wire ctl_tx_test_pattern_0
  .ctl_tx_test_pattern_enable_0     (ctl_tx_test_pattern_enable_0   ),          // input wire ctl_tx_test_pattern_enable_0
  .ctl_tx_test_pattern_select_0     (ctl_tx_test_pattern_select_0   ),          // input wire ctl_tx_test_pattern_select_0
  .ctl_tx_data_pattern_select_0     (ctl_tx_data_pattern_select_0   ),          // input wire ctl_tx_data_pattern_select_0
  .ctl_tx_test_pattern_seed_a_0     (ctl_tx_test_pattern_seed_a_0   ),          // input wire [57 : 0] ctl_tx_test_pattern_seed_a_0
  .ctl_tx_test_pattern_seed_b_0     (ctl_tx_test_pattern_seed_b_0   ),          // input wire [57 : 0] ctl_tx_test_pattern_seed_b_0
  .ctl_tx_ipg_value_0               (ctl_tx_ipg_value_0             ),          // input wire [3 : 0] ctl_tx_ipg_value_0
  .ctl_tx_custom_preamble_enable_0  (ctl_tx_custom_preamble_enable_0),          // input wire ctl_tx_custom_preamble_enable_0
  .gt_loopback_in_0                 (gt_loopback_in_0),                         // input wire [2 : 0] gt_loopback_in_0
  
  .qpllreset_in_0                   (qpllreset_in_0),                            // input wire qpllreset_in_0
    /*======================================================*/
    /*======================= sfp1 =========================*/
    /*======================================================*/
    .rx_core_clk_1                    (rx_core_clk_1                      ), 
    .txoutclksel_in_1                 (txoutclksel_in_1                   ), 
    .rxoutclksel_in_1                 (rxoutclksel_in_1                   ), 
    .gtwiz_reset_tx_datapath_1        (gtwiz_reset_tx_datapath_1          ), 
    .gtwiz_reset_rx_datapath_1        (gtwiz_reset_rx_datapath_1          ), 
    .rxrecclkout_1                    (rxrecclkout_1                      ), 
    .tx_clk_out_1                     (tx_clk_out_1                       ), 
    .rx_clk_out_1                     (rx_clk_out_1                       ), 
    .gtpowergood_out_1                (gtpowergood_out_1                  ), 
    
    .rx_reset_1                       (rx_reset_1                         ), 
    .user_rx_reset_1                  (user_rx_reset_1                    ), 
    .rx_axis_tvalid_1                 (rx_axis_tvalid_1                   ), 
    .rx_axis_tdata_1                  (rx_axis_tdata_1                    ), 
    .rx_axis_tlast_1                  (rx_axis_tlast_1                    ), 
    .rx_axis_tkeep_1                  (rx_axis_tkeep_1                    ), 
    .rx_axis_tuser_1                  (rx_axis_tuser_1                    ), 
    
    .ctl_rx_enable_1                  (ctl_rx_enable_1                    ), 
    .ctl_rx_check_preamble_1          (ctl_rx_check_preamble_1            ), 
    .ctl_rx_check_sfd_1               (ctl_rx_check_sfd_1                 ), 
    .ctl_rx_force_resync_1            (ctl_rx_force_resync_1              ), 
    .ctl_rx_delete_fcs_1              (ctl_rx_delete_fcs_1                ), 
    .ctl_rx_ignore_fcs_1              (ctl_rx_ignore_fcs_1                ), 
    .ctl_rx_max_packet_len_1          (ctl_rx_max_packet_len_1            ), 
    .ctl_rx_min_packet_len_1          (ctl_rx_min_packet_len_1            ), 
    .ctl_rx_process_lfi_1             (ctl_rx_process_lfi_1               ), 
    .ctl_rx_test_pattern_1            (ctl_rx_test_pattern_1              ), 
    .ctl_rx_data_pattern_select_1     (ctl_rx_data_pattern_select_1       ), 
    .ctl_rx_test_pattern_enable_1     (ctl_rx_test_pattern_enable_1       ), 
    .ctl_rx_custom_preamble_enable_1  (ctl_rx_custom_preamble_enable_1    ), 
    
    .stat_rx_framing_err_1            (stat_rx_framing_err_1              ), 
    .stat_rx_framing_err_valid_1      (stat_rx_framing_err_valid_1        ), 
    .stat_rx_local_fault_1            (stat_rx_local_fault_1              ), 
    .stat_rx_block_lock_1             (stat_rx_block_lock_1               ), 
    .stat_rx_valid_ctrl_code_1        (stat_rx_valid_ctrl_code_1          ), 
    .stat_rx_status_1                 (stat_rx_status_1                   ), 
    .stat_rx_remote_fault_1           (stat_rx_remote_fault_1             ), 
    .stat_rx_bad_fcs_1                (stat_rx_bad_fcs_1                  ), 
    .stat_rx_stomped_fcs_1            (stat_rx_stomped_fcs_1              ), 
    .stat_rx_truncated_1              (stat_rx_truncated_1                ), 
    .stat_rx_internal_local_fault_1   (stat_rx_internal_local_fault_1     ), 
    .stat_rx_received_local_fault_1   (stat_rx_received_local_fault_1     ), 
    .stat_rx_hi_ber_1                 (stat_rx_hi_ber_1                   ), 
    .stat_rx_got_signal_os_1          (stat_rx_got_signal_os_1            ), 
    .stat_rx_test_pattern_mismatch_1  (stat_rx_test_pattern_mismatch_1    ), 
    .stat_rx_total_bytes_1            (stat_rx_total_bytes_1              ), 
    .stat_rx_total_packets_1          (stat_rx_total_packets_1            ), 
    .stat_rx_total_good_bytes_1       (stat_rx_total_good_bytes_1         ), 
    .stat_rx_total_good_packets_1     (stat_rx_total_good_packets_1       ), 
    .stat_rx_packet_bad_fcs_1         (stat_rx_packet_bad_fcs_1           ), 
    .stat_rx_packet_64_bytes_1        (stat_rx_packet_64_bytes_1          ), 
    .stat_rx_packet_65_127_bytes_1    (stat_rx_packet_65_127_bytes_1      ), 
    .stat_rx_packet_128_255_bytes_1   (stat_rx_packet_128_255_bytes_1     ), 
    .stat_rx_packet_256_511_bytes_1   (stat_rx_packet_256_511_bytes_1     ), 
    .stat_rx_packet_512_1023_bytes_1  (stat_rx_packet_512_1023_bytes_1    ), 
    .stat_rx_packet_1024_1518_bytes_1 (stat_rx_packet_1024_1518_bytes_1   ), 
    .stat_rx_packet_1519_1522_bytes_1 (stat_rx_packet_1519_1522_bytes_1   ), 
    .stat_rx_packet_1523_1548_bytes_1 (stat_rx_packet_1523_1548_bytes_1   ), 
    .stat_rx_packet_1549_2047_bytes_1 (stat_rx_packet_1549_2047_bytes_1   ), 
    .stat_rx_packet_2048_4095_bytes_1 (stat_rx_packet_2048_4095_bytes_1   ), 
    .stat_rx_packet_4096_8191_bytes_1 (stat_rx_packet_4096_8191_bytes_1   ), 
    .stat_rx_packet_8192_9215_bytes_1 (stat_rx_packet_8192_9215_bytes_1   ), 
    .stat_rx_packet_small_1           (stat_rx_packet_small_1             ), 
    .stat_rx_packet_large_1           (stat_rx_packet_large_1             ), 
    .stat_rx_unicast_1                (stat_rx_unicast_1                  ), 
    .stat_rx_multicast_1              (stat_rx_multicast_1                ), 
    .stat_rx_broadcast_1              (stat_rx_broadcast_1                ), 
    .stat_rx_oversize_1               (stat_rx_oversize_1                 ), 
    .stat_rx_toolong_1                (stat_rx_toolong_1                  ), 
    .stat_rx_undersize_1              (stat_rx_undersize_1                ), 
    .stat_rx_fragment_1               (stat_rx_fragment_1                 ), 
    .stat_rx_vlan_1                   (stat_rx_vlan_1                     ), 
    .stat_rx_inrangeerr_1             (stat_rx_inrangeerr_1               ), 
    .stat_rx_jabber_1                 (stat_rx_jabber_1                   ), 
    .stat_rx_bad_code_1               (stat_rx_bad_code_1                 ), 
    .stat_rx_bad_sfd_1                (stat_rx_bad_sfd_1                  ), 
    .stat_rx_bad_preamble_1           (stat_rx_bad_preamble_1             ), 
    
    .tx_reset_1                       (tx_reset_1                         ), 
    .user_tx_reset_1                  (user_tx_reset_1                    ), 
    .tx_axis_tready_1                 (tx_axis_tready_1                   ), 
    .tx_axis_tvalid_1                 (0                   ), 
    .tx_axis_tdata_1                  (0                   ), 
    .tx_axis_tlast_1                  (0                   ), 
    .tx_axis_tkeep_1                  (0                   ), 
    .tx_axis_tuser_1                  (0                   ),    
    .tx_unfout_1                      (tx_unfout_1                        ), 
    .tx_preamblein_1                  (tx_preamblein_1                    ), 
    .rx_preambleout_1                 (rx_preambleout_1                   ), 
    
    .stat_tx_local_fault_1            (stat_tx_local_fault_1              ), 
    .stat_tx_total_bytes_1            (stat_tx_total_bytes_1              ), 
    .stat_tx_total_packets_1          (stat_tx_total_packets_1            ), 
    .stat_tx_total_good_bytes_1       (stat_tx_total_good_bytes_1         ), 
    .stat_tx_total_good_packets_1     (stat_tx_total_good_packets_1       ), 
    .stat_tx_bad_fcs_1                (stat_tx_bad_fcs_1                  ), 
    .stat_tx_packet_64_bytes_1        (stat_tx_packet_64_bytes_1          ), 
    .stat_tx_packet_65_127_bytes_1    (stat_tx_packet_65_127_bytes_1      ), 
    .stat_tx_packet_128_255_bytes_1   (stat_tx_packet_128_255_bytes_1     ), 
    .stat_tx_packet_256_511_bytes_1   (stat_tx_packet_256_511_bytes_1     ), 
    .stat_tx_packet_512_1023_bytes_1  (stat_tx_packet_512_1023_bytes_1    ), 
    .stat_tx_packet_1024_1518_bytes_1 (stat_tx_packet_1024_1518_bytes_1   ), 
    .stat_tx_packet_1519_1522_bytes_1 (stat_tx_packet_1519_1522_bytes_1   ), 
    .stat_tx_packet_1523_1548_bytes_1 (stat_tx_packet_1523_1548_bytes_1   ), 
    .stat_tx_packet_1549_2047_bytes_1 (stat_tx_packet_1549_2047_bytes_1   ), 
    .stat_tx_packet_2048_4095_bytes_1 (stat_tx_packet_2048_4095_bytes_1   ), 
    .stat_tx_packet_4096_8191_bytes_1 (stat_tx_packet_4096_8191_bytes_1   ), 
    .stat_tx_packet_8192_9215_bytes_1 (stat_tx_packet_8192_9215_bytes_1   ), 
    .stat_tx_packet_small_1           (stat_tx_packet_small_1             ), 
    .stat_tx_packet_large_1           (stat_tx_packet_large_1             ), 
    .stat_tx_unicast_1                (stat_tx_unicast_1                  ), 
    .stat_tx_multicast_1              (stat_tx_multicast_1                ), 
    .stat_tx_broadcast_1              (stat_tx_broadcast_1                ), 
    .stat_tx_vlan_1                   (stat_tx_vlan_1                     ), 
    .stat_tx_frame_error_1            (stat_tx_frame_error_1              ), 
    
    .ctl_tx_enable_1                  (ctl_tx_enable_1                    ), 
    .ctl_tx_send_rfi_1                (ctl_tx_send_rfi_1                  ), 
    .ctl_tx_send_lfi_1                (ctl_tx_send_lfi_1                  ), 
    .ctl_tx_send_idle_1               (ctl_tx_send_idle_1                 ), 
    .ctl_tx_fcs_ins_enable_1          (ctl_tx_fcs_ins_enable_1            ), 
    .ctl_tx_ignore_fcs_1              (ctl_tx_ignore_fcs_1                ), 
    .ctl_tx_test_pattern_1            (ctl_tx_test_pattern_1              ), 
    .ctl_tx_test_pattern_enable_1     (ctl_tx_test_pattern_enable_1       ), 
    .ctl_tx_test_pattern_select_1     (ctl_tx_test_pattern_select_1       ), 
    .ctl_tx_data_pattern_select_1     (ctl_tx_data_pattern_select_1       ), 
    .ctl_tx_test_pattern_seed_a_1     (ctl_tx_test_pattern_seed_a_1       ), 
    .ctl_tx_test_pattern_seed_b_1     (ctl_tx_test_pattern_seed_b_1       ), 
    .ctl_tx_ipg_value_1               (ctl_tx_ipg_value_1                 ), 
    .ctl_tx_custom_preamble_enable_1  (ctl_tx_custom_preamble_enable_1    ), 
    .gt_loopback_in_1                 (gt_loopback_in_1                   )
);


endmodule
