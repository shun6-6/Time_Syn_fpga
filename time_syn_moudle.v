`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2023 10:29:34 AM
// Design Name: 
// Module Name: time_syn_moudle
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


module time_syn_moudle#(
    parameter       P_MASTER_TIME_PORT   = 0,
    parameter       P_SLAVER_TIME_PORT   = 1
)(
    input           i_clk               ,
    input           i_rst               ,
    /*----ctrl port----*/
    input           i_stat_rx_status    ,
    input           i_time_syn_start    ,
    input           i_select_std_port   ,//选取该节点作为标准时间节点
    output [63:0]   o_local_time        ,
    output [63:0]   o_time_offest       ,
    /*----axis port----*/
    input           i_tx_axis_tready    ,
    output          o_tx_axis_tvalid    ,
    output [63:0]   o_tx_axis_tdata     ,
    output          o_tx_axis_tlast     ,
    output [7 :0]   o_tx_axis_tkeep     ,
    output          o_tx_axis_tuser     ,
    input           i_rx_axis_tvalid    ,
    input  [63:0]   i_rx_axis_tdata     ,
    input           i_rx_axis_tlast     ,
    input  [7 :0]   i_rx_axis_tkeep     ,
    input           i_rx_axis_tuser        
);
//*********************************************parameter*************************************************//
localparam      P_S_IDLE        =   0   ,   //空闲状态
                P_S_WAIT_S_TS   =   1   ,   //主设备等待从设备时间戳
                P_S_RETURN_TS   =   2   ,   //主设备接收到从设备时间戳后立即发回从设备
                P_S_SEND_M_STD  =   3   ;   //主设备发送标准时间

localparam      P_S_SEND_S_TS   =   4   ,   //从设备向主设备发送时间戳
                P_S_WAIT_M_TS   =   5   ,   //从设备等待主设备返回的时间戳
                P_S_CMPT_OFFEST =   6   ,   //从设备计算时间偏移
                P_S_WAIT_STD    =   7   ,   //从设备等待主设备的标准时间
                P_S_CMPT_STD    =   8   ,   //从设备接收到标准时间后根据时间偏移矫正本地时间
                P_S_SYN_END     =   9   ;   //一次时间同步结束
localparam      P_FRAME_LEN     =   8'd8;
localparam      P_PROCESS       =   4;
localparam      P_TIME_OUT      =   300;
//*********************************************function**************************************************//

//***********************************************FSM*****************************************************//
reg  [7 :0]     r_cur_s_state       ;
reg  [7 :0]     r_nxt_s_state       ;
reg  [7 :0]     r_cur_m_state       ;
reg  [7 :0]     r_nxt_m_state       ;
reg  [15:0]     r_state_s_cnt       ;
reg  [15:0]     r_state_m_cnt       ;
//***********************************************reg*****************************************************//
reg             ri_stat_rx_status   ;
reg             ri_time_syn_start   ;
reg             ri_time_syn_start_1d;
reg             ri_select_std_port  ;

reg             r_send_ts_valid     ;
reg  [63:0]     r_local_time        ;
reg             r_send_std_valid    ;
reg             r_return_valid      ;
reg  [63:0]     r_return_ts         ;
reg             r_cmpt_std_end      ;
reg  [63:0]     r_time_offest       ;
reg             r_wait_time_out     ;
//***********************************************wire****************************************************//
wire [63:0]     w_recv_time_stamp   ;//接收到的从设备时间戳
wire            w_recv_ts_valid     ;
wire [63:0]     w_recv_std_time     ;//接收到的标准时间
wire            w_recv_std_valid    ;
wire [63:0]     w_recv_return_ts    ;
wire            w_recv_return_valid ;
wire            w_time_syn_pos      ;
//*********************************************component*************************************************//
ila_fsm your_instance_name (
	.clk    (i_clk              ), // input wire clk
	.probe0 (r_cur_s_state      ), // input wire [7:0]  probe0  
	.probe1 (r_cur_m_state      ), // input wire [7:0]  probe1 
	.probe2 (r_send_ts_valid    ), // input wire [0:0]  probe2 
	.probe3 (r_local_time       ), // input wire [63:0]  probe3 
	.probe4 (r_send_std_valid   ), // input wire [0:0]  probe4 
	.probe5 (r_return_valid     ), // input wire [0:0]  probe5 
	.probe6 (r_return_ts        ), // input wire [63:0]  probe6 
	.probe7 (r_cmpt_std_end     ), // input wire [0:0]  probe7 
	.probe8 (r_time_offest      ), // input wire [63:0]  probe8 
	.probe9 (w_recv_time_stamp  ), // input wire [63:0]  probe9 
	.probe10(w_recv_ts_valid    ), // input wire [0:0]  probe10 
	.probe11(w_recv_std_time    ), // input wire [63:0]  probe11 
	.probe12(w_recv_std_valid   ), // input wire [0:0]  probe12 
	.probe13(w_recv_return_ts   ), // input wire [63:0]  probe13 
	.probe14(w_recv_return_valid),  // input wire [0:0]  probe14
    .probe15(ri_select_std_port ),
    .probe16(r_state_m_cnt )
);


time_syn_rx time_syn_rx_u0(
    .i_clk               (i_clk                 ),
    .i_rst               (i_rst                 ),

    .o_recv_time_stamp   (w_recv_time_stamp     ),
    .o_recv_ts_valid     (w_recv_ts_valid       ),
    .o_recv_std_time     (w_recv_std_time       ),
    .o_recv_std_valid    (w_recv_std_valid      ),
    .o_recv_return_ts    (w_recv_return_ts      ),
    .o_recv_return_valid (w_recv_return_valid   ),

    .i_rx_axis_tvalid    (i_rx_axis_tvalid      ),
    .i_rx_axis_tdata     (i_rx_axis_tdata       ),
    .i_rx_axis_tlast     (i_rx_axis_tlast       ),
    .i_rx_axis_tkeep     (i_rx_axis_tkeep       ),
    .i_rx_axis_tuser     (i_rx_axis_tuser       ) 
);

time_syn_tx time_syn_tx_u0(
    .i_clk               (i_clk                 ),
    .i_rst               (i_rst                 ),

    .i_send_ts_valid     (r_send_ts_valid       ),
    .i_local_time        (r_local_time          ),
    .i_send_std_valid    (r_send_std_valid      ),
    .i_std_time          (r_local_time          ),
    .i_return_valid      (r_return_valid        ),
    .i_return_ts         (r_return_ts           ),

    .i_tx_axis_tready    (i_tx_axis_tready      ),
    .o_tx_axis_tvalid    (o_tx_axis_tvalid      ),
    .o_tx_axis_tdata     (o_tx_axis_tdata       ),
    .o_tx_axis_tlast     (o_tx_axis_tlast       ),
    .o_tx_axis_tkeep     (o_tx_axis_tkeep       ),
    .o_tx_axis_tuser     (o_tx_axis_tuser       ) 
);
//**********************************************assign***************************************************//
assign o_local_time = r_local_time;
assign o_time_offest = r_time_offest;
assign w_time_syn_pos = ri_time_syn_start && !ri_time_syn_start_1d;
//**********************************************always***************************************************//
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        ri_stat_rx_status <= 'd0;
        ri_time_syn_start <= 'd0;
        ri_time_syn_start_1d <= 'd0;
    end
    else begin
        ri_stat_rx_status <= i_stat_rx_status;
        ri_time_syn_start <= i_time_syn_start;
        ri_time_syn_start_1d <= ri_time_syn_start;
    end
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ri_select_std_port <= 'd0;
    else if(r_cur_m_state != P_S_RETURN_TS)//在该状态下需要使用主节点信息，不可以改变
        ri_select_std_port <= i_select_std_port;
    else
        ri_select_std_port <= ri_select_std_port;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_local_time <= 'd0;
    else if(ri_select_std_port)//若是规定的主时间节点，则维护本地时钟即可
        r_local_time <= r_local_time + 1;
    else if(w_recv_std_valid && r_cur_s_state == P_S_WAIT_STD)//若不是规定的主时间节点，则需要根据接收到的主时钟进行矫正
        r_local_time <= w_recv_std_time + r_time_offest + 2;//还有俩个时钟周期的补偿，因为标准时间进来之后打了俩拍
    else
        r_local_time <= r_local_time + 1;
end

/*===========================FSM_M===============================*/
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_cur_m_state <= P_S_IDLE;
    else
        r_cur_m_state <= r_nxt_m_state;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_state_m_cnt <= 'd0;
    else if(r_cur_m_state != r_nxt_m_state)
        r_state_m_cnt <= 'd0;
    else
        r_state_m_cnt <= r_state_m_cnt + 1;
end

always @(*)begin
    case(r_cur_m_state)
        P_S_IDLE       : begin
            if(P_MASTER_TIME_PORT && ri_stat_rx_status)
                r_nxt_m_state = P_S_WAIT_S_TS;
            else
                r_nxt_m_state = P_S_IDLE;
        end
        P_S_WAIT_S_TS  : begin
            if(w_recv_ts_valid)
                r_nxt_m_state = P_S_RETURN_TS;
            else
                r_nxt_m_state = P_S_WAIT_S_TS;
        end
        P_S_RETURN_TS  : begin
            if(r_state_m_cnt >= P_TIME_OUT)
                r_nxt_m_state = P_S_WAIT_S_TS;
            else if(r_state_m_cnt >= P_FRAME_LEN && ((r_cmpt_std_end && !ri_select_std_port) || ri_select_std_port))//发送8拍数据
                r_nxt_m_state = P_S_SEND_M_STD;
            else
                r_nxt_m_state = P_S_RETURN_TS;
        end
        P_S_SEND_M_STD : begin
            if(r_state_m_cnt == P_FRAME_LEN)
                r_nxt_m_state = P_S_WAIT_S_TS;
            else
                r_nxt_m_state = P_S_SEND_M_STD;
        end
        default        : r_nxt_m_state = P_S_IDLE;
    endcase
end

always  @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        r_return_valid <= 'd0;
    end
    else if(r_cur_m_state == P_S_RETURN_TS && r_state_m_cnt <= P_FRAME_LEN)begin
        r_return_valid <= 'd1;
    end
    else begin
        r_return_valid <= 'd0;
    end
end

always  @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        r_return_ts <= 'd0;
    end
    else if(r_cur_m_state == P_S_WAIT_S_TS && r_nxt_m_state == P_S_RETURN_TS)begin
        r_return_ts <= w_recv_time_stamp;
    end
    else begin
        r_return_ts <= r_return_ts;
    end
end

always  @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_send_std_valid <= 'd0;
    else if(r_cur_m_state == P_S_SEND_M_STD)
        r_send_std_valid <= 'd1;
    else
        r_send_std_valid <= 'd0;
end
/*===========================FSM_S===============================*/
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_cur_s_state <= P_S_IDLE;
    else
        r_cur_s_state <= r_nxt_s_state;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_state_s_cnt <= 'd0;
    else if(r_cur_s_state != r_nxt_s_state)
        r_state_s_cnt <= 'd0;
    else
        r_state_s_cnt <= r_state_s_cnt + 1;
end

always @(*)begin
    case(r_cur_s_state)
        P_S_IDLE        :begin
            if(P_SLAVER_TIME_PORT && ri_stat_rx_status && ri_time_syn_start_1d)
                r_nxt_s_state = P_S_SEND_S_TS;
            else
                r_nxt_s_state = P_S_IDLE;
        end
        P_S_SEND_S_TS   :begin
            if(r_state_s_cnt == P_FRAME_LEN)
                r_nxt_s_state = P_S_WAIT_M_TS;
            else
                r_nxt_s_state = P_S_SEND_S_TS;
        end
        P_S_WAIT_M_TS   :begin
            if(r_wait_time_out)//防止等待超时
                r_nxt_s_state = P_S_SEND_S_TS;
            else if(w_recv_return_valid)
                r_nxt_s_state = P_S_CMPT_OFFEST;
            else
                r_nxt_s_state = P_S_WAIT_M_TS;
        end
        P_S_CMPT_OFFEST : r_nxt_s_state = P_S_WAIT_STD;
        P_S_WAIT_STD    :begin
            if(r_wait_time_out)//防止等待超时
                r_nxt_s_state = P_S_SEND_S_TS;
            else if(w_recv_std_valid)
                r_nxt_s_state = P_S_CMPT_STD;
            else
                r_nxt_s_state = P_S_WAIT_STD;
        end
        P_S_CMPT_STD    : r_nxt_s_state = P_S_SYN_END;
        P_S_SYN_END     : r_nxt_s_state = P_S_IDLE;
        default         : r_nxt_s_state = P_S_IDLE;
    endcase
end
//计算时间偏移
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_time_offest <= 'd0;
    else if(r_cur_s_state == P_S_WAIT_M_TS && w_recv_return_valid)
        r_time_offest <= (r_local_time - w_recv_return_ts - P_PROCESS) >> 1;
    else
        r_time_offest <= r_time_offest;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_send_ts_valid <= 'd0;
    else if(r_cur_s_state == P_S_SEND_S_TS)
        r_send_ts_valid <= 'd1;
    else
        r_send_ts_valid <= 'd0;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_cmpt_std_end <= 'd0;
    else if(r_cur_s_state == P_S_CMPT_STD)
        r_cmpt_std_end <= 'd1;
    else
        r_cmpt_std_end <= 'd0;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_wait_time_out <= 'd0;
    else if((r_cur_s_state != P_S_WAIT_M_TS) && (r_cur_s_state != P_S_WAIT_STD))
        r_wait_time_out <= 'd0;
    else if(r_state_s_cnt == P_TIME_OUT)
        r_wait_time_out <= 'd1;
    else
        r_wait_time_out <= r_wait_time_out;
end

endmodule
