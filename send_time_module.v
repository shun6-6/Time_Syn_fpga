`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2024 04:16:10 PM
// Design Name: 
// Module Name: send_time_module
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


module send_time_module(
    input           i_clk               ,
    input           i_rst               ,

    input  [63:0]   i_local_time        ,
    input           i_stat_rx_status    ,

    input           i_tx_axis_tready    ,
    output          o_tx_axis_tvalid    ,
    output [63:0]   o_tx_axis_tdata     ,
    output          o_tx_axis_tlast     ,
    output [7 :0]   o_tx_axis_tkeep     ,
    output          o_tx_axis_tuser       
);

localparam  P_FRAME_LEN = 200;

wire    w_tx_en;
assign  w_tx_en = i_tx_axis_tready & o_tx_axis_tvalid;

reg             ro_tx_axis_tvalid;
reg     [63:0]  ro_tx_axis_tdata ;
reg             ro_tx_axis_tlast ;
reg     [15:0]  r_send_cnt;  

assign  o_tx_axis_tvalid = ro_tx_axis_tvalid;
assign  o_tx_axis_tdata  = ro_tx_axis_tdata ;
assign  o_tx_axis_tlast  = ro_tx_axis_tlast ;
assign  o_tx_axis_tkeep  = 8'hff;
assign  o_tx_axis_tuser  = 'd0;

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        r_send_cnt <= 'd0;
    else if(r_send_cnt == P_FRAME_LEN - 1)
        r_send_cnt <= 'd0;
    else if(w_tx_en)
        r_send_cnt <= r_send_cnt + 1;
    else
        r_send_cnt <= r_send_cnt;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_tx_axis_tvalid <= 'd0;
    else if(i_stat_rx_status)
        ro_tx_axis_tvalid <= 'd1;
    else
        ro_tx_axis_tvalid <= ro_tx_axis_tvalid;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_tx_axis_tdata <= 'd0;
    else
        ro_tx_axis_tdata <= i_local_time;
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_tx_axis_tlast <= 'd0;
    else if(r_send_cnt == P_FRAME_LEN - 2)
        ro_tx_axis_tlast <= 'd1;
    else
        ro_tx_axis_tlast <= 'd0;
end

endmodule
