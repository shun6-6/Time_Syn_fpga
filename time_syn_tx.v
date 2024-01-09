`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2023 09:56:48 AM
// Design Name: 
// Module Name: time_syn_tx
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


module time_syn_tx(
    input           i_clk               ,
    input           i_rst               ,
    /*----ctrl port----*/
    input           i_send_ts_valid     ,
    input  [63:0]   i_local_time        ,
    input           i_send_std_valid    ,
    input  [63:0]   i_std_time          ,
    input           i_return_valid      ,
    input  [63:0]   i_return_ts         ,
    /*----axis port----*/
    input           i_tx_axis_tready    ,
    output          o_tx_axis_tvalid    ,
    output [63:0]   o_tx_axis_tdata     ,
    output          o_tx_axis_tlast     ,
    output [7 :0]   o_tx_axis_tkeep     ,
    output          o_tx_axis_tuser            
);
//*********************************************parameter*************************************************//
localparam      P_TS_PRE        =   64'h00_00_00_00_00_00_66;//102
localparam      P_STD_PRE       =   64'h00_00_00_00_00_00_88;//136
localparam      P_RETURN_PRE    =   64'h00_00_00_00_00_00_55;//85
localparam      P_FRAME_LEN     =   8'd8;
//*********************************************function**************************************************//

//***********************************************FSM*****************************************************//

//***********************************************reg*****************************************************//
reg             ri_send_ts_valid    ;
reg  [63:0]     ri_local_time       ;
reg             ri_send_std_valid   ;
reg  [63:0]     ri_std_time         ;
reg             ri_return_valid     ;
reg  [63:0]     ri_return_ts        ;

reg             ro_tx_axis_tvalid   ;
reg  [63:0]     ro_tx_axis_tdata    ;
reg             ro_tx_axis_tlast    ;
reg  [7 :0]     ro_tx_axis_tkeep    ;
reg             ro_tx_axis_tuser    ;

reg  [15:0]     r_send_cnt          ;
//***********************************************wire****************************************************//
wire            w_tx_en             ;
//*********************************************component*************************************************//

//**********************************************assign***************************************************//
assign  o_tx_axis_tvalid    =   ro_tx_axis_tvalid   ;
assign  o_tx_axis_tdata     =   ro_tx_axis_tdata    ;
assign  o_tx_axis_tlast     =   ro_tx_axis_tlast    ;
assign  o_tx_axis_tkeep     =   8'hff;
assign  o_tx_axis_tuser     =   'd0  ;
assign  w_tx_en             =   o_tx_axis_tvalid & i_tx_axis_tready;
//**********************************************always***************************************************//
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        ri_send_ts_valid  <= 'd0;
        ri_local_time     <= 'd0;
        ri_send_std_valid <= 'd0;
        ri_std_time       <= 'd0;
        ri_return_valid   <= 'd0;
        ri_return_ts      <= 'd0;
    end
    else begin
        ri_send_ts_valid  <= i_send_ts_valid ;
        ri_local_time     <= i_local_time    ;
        ri_send_std_valid <= i_send_std_valid;
        ri_std_time       <= i_std_time      ;
        ri_return_valid   <= i_return_valid  ;
        ri_return_ts      <= i_return_ts     ;
    end
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_send_cnt <= 'd0;
    else if(r_send_cnt == P_FRAME_LEN - 1)
        r_send_cnt <= 'd0;
    else if(w_tx_en)
        r_send_cnt <= r_send_cnt + 'd1;
    else
        r_send_cnt <= r_send_cnt;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_tx_axis_tvalid <= 'd0;
    else if(r_send_cnt == P_FRAME_LEN - 1)
        ro_tx_axis_tvalid <= 'd0;
    else if(ri_send_ts_valid || ri_send_std_valid || ri_return_valid)//三种情况下需要拉高valid
        ro_tx_axis_tvalid <= 'd1;
    else
        ro_tx_axis_tvalid <= ro_tx_axis_tvalid;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_tx_axis_tdata <= 'd0;
    else if(ri_send_ts_valid && !ro_tx_axis_tvalid)
        ro_tx_axis_tdata <= P_TS_PRE;
    else if(ri_return_valid && !ro_tx_axis_tvalid)
        ro_tx_axis_tdata <= P_RETURN_PRE;
    else if(ri_send_std_valid && !ro_tx_axis_tvalid)
        ro_tx_axis_tdata <= P_STD_PRE;
    else if(w_tx_en && ri_send_ts_valid)
        ro_tx_axis_tdata <= ri_local_time + 2;
    else if(w_tx_en && ri_return_valid)
        ro_tx_axis_tdata <= ri_return_ts;
    else if(w_tx_en && ri_send_std_valid)
        ro_tx_axis_tdata <= ri_std_time + 2;
    else
        ro_tx_axis_tdata <= ro_tx_axis_tdata;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_tx_axis_tlast <= 'd0;
    else if(r_send_cnt == P_FRAME_LEN - 2)
        ro_tx_axis_tlast <= 'd1;
    else
        ro_tx_axis_tlast <= 'd0;
end

// always @(posedge i_clk or posedge i_rst)begin
//     if(i_rst)
        
//     else if()

//     else
        
// end

// always @(posedge i_clk or posedge i_rst)begin
//     if(i_rst)
        
//     else if()

//     else
        
// end

endmodule
