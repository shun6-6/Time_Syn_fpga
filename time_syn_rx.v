`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2023 09:56:48 AM
// Design Name: 
// Module Name: time_syn_rx
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


module time_syn_rx(
    input           i_clk               ,
    input           i_rst               ,
    /*----ctrl port----*/
    output [63:0]   o_recv_time_stamp   ,
    output          o_recv_ts_valid     ,
    output [63:0]   o_recv_std_time     ,
    output          o_recv_std_valid    ,
    output [63:0]   o_recv_return_ts    ,
    output          o_recv_return_valid ,
    /*----axis port----*/
    input           i_rx_axis_tvalid    ,
    input  [63:0]   i_rx_axis_tdata     ,
    input           i_rx_axis_tlast     ,
    input  [7 :0]   i_rx_axis_tkeep     ,
    input           i_rx_axis_tuser      
);
//*********************************************parameter*************************************************//
localparam      P_TS_PRE        =   64'h00_00_00_00_00_00_66;//102
localparam      P_STD_PRE       =   64'h00_00_00_00_00_00_88;//136
localparam      P_RETURN_PRE    =   64'h00_00_00_00_00_00_55;//85
localparam      P_FRAME_LEN     =   8'd8;
//*********************************************function**************************************************//

//***********************************************FSM*****************************************************//

//***********************************************reg*****************************************************//
reg             ri_rx_axis_tvalid   ;
reg  [63:0]     ri_rx_axis_tdata    ;
reg             ri_rx_axis_tlast    ;
reg  [7 :0]     ri_rx_axis_tkeep    ;
reg             ri_rx_axis_tuser    ;
reg  [63:0]     ro_recv_time_stamp  ;
reg             ro_recv_ts_valid    ;
reg  [63:0]     ro_recv_std_time    ;
reg             ro_recv_std_valid   ;
reg  [63:0]     ro_recv_return_ts   ;
reg             ro_recv_return_valid;
//***********************************************wire****************************************************//

//*********************************************component*************************************************//

//**********************************************assign***************************************************//
assign  o_recv_time_stamp   = ri_rx_axis_tdata      ;
assign  o_recv_ts_valid     = ro_recv_ts_valid      ;
assign  o_recv_std_time     = ri_rx_axis_tdata      ;
assign  o_recv_std_valid    = ro_recv_std_valid     ;
assign  o_recv_return_ts    = ri_rx_axis_tdata      ;
assign  o_recv_return_valid = ro_recv_return_valid  ;
//**********************************************always***************************************************//
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        ri_rx_axis_tvalid <= 'd0;
        ri_rx_axis_tdata  <= 'd0;
        ri_rx_axis_tlast  <= 'd0;
        ri_rx_axis_tkeep  <= 'd0;
        ri_rx_axis_tuser  <= 'd0;
    end
    else begin
        ri_rx_axis_tvalid <= i_rx_axis_tvalid;
        ri_rx_axis_tdata  <= i_rx_axis_tdata ;
        ri_rx_axis_tlast  <= i_rx_axis_tlast ;
        ri_rx_axis_tkeep  <= i_rx_axis_tkeep ;
        ri_rx_axis_tuser  <= i_rx_axis_tuser ;        
    end
end
 
always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_recv_ts_valid   <= 'd0;       
    else if(ri_rx_axis_tvalid && ri_rx_axis_tdata == P_TS_PRE)
        ro_recv_ts_valid   <= 'd1;         
    else 
        ro_recv_ts_valid   <= 'd0;            
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        ro_recv_std_valid <= 'd0;       
    end
    else if(ri_rx_axis_tvalid && ri_rx_axis_tdata == P_STD_PRE)begin
        ro_recv_std_valid <= 'd1;         
    end
    else begin
        ro_recv_std_valid <= 'd0;            
    end
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)begin
        ro_recv_return_valid <= 'd0;       
    end
    else if(ri_rx_axis_tvalid && ri_rx_axis_tdata == P_RETURN_PRE)begin
        ro_recv_return_valid <= 'd1;         
    end
    else begin
        ro_recv_return_valid <= 'd0;            
    end
end


endmodule
