`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/08/2024 04:03:01 PM
// Design Name: 
// Module Name: Time_syn_ctrl_module
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


module Time_syn_ctrl_module(
    input           i_clk               ,
    input           i_rst               ,
    /*----ctrl port----*/
    output          o_time_syn_start    ,
    output          o_select_port       ,
    /*----axis port----*/
    input           i_rx_axis_tvalid    ,
    input  [63:0]   i_rx_axis_tdata     ,
    input           i_rx_axis_tlast     ,
    input  [7 :0]   i_rx_axis_tkeep     ,
    input           i_rx_axis_tuser      
);
//*********************************************parameter*************************************************//
localparam      P_SYN_START     =   64'h00_00_00_00_00_55_66;
localparam      P_SELECT_PORT   =   64'h00_00_00_00_00_55_88;
localparam      P_FRAME_LEN     =   8'd8;
//*********************************************function**************************************************//

//***********************************************FSM*****************************************************//

//***********************************************reg*****************************************************//
reg             ri_rx_axis_tvalid   ;
reg  [63:0]     ri_rx_axis_tdata    ;
reg             ri_rx_axis_tlast    ;
reg  [7 :0]     ri_rx_axis_tkeep    ;
reg             ri_rx_axis_tuser    ;
reg  [63:0]     ro_time_syn_start   ;
reg             ro_select_port      ;
//***********************************************wire****************************************************//

//*********************************************component*************************************************//

//**********************************************assign***************************************************//
assign  o_time_syn_start   = ro_time_syn_start      ;
assign  o_select_port      = ro_select_port         ;
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
        ro_time_syn_start   <= 'd0;       
    else if(ri_rx_axis_tvalid && ri_rx_axis_tdata == P_SYN_START)
        ro_time_syn_start   <= 'd1;         
    else 
        ro_time_syn_start   <= 'd0;            
end

always @(posedge i_clk or posedge i_rst)begin
    if(i_rst)
        ro_select_port   <= 'd0;     
    else if(ri_rx_axis_tvalid && ri_rx_axis_tdata == P_SYN_START)
        ro_select_port   <= 'd0;   
    else if(ri_rx_axis_tvalid && ri_rx_axis_tdata == P_SELECT_PORT)
        ro_select_port   <= 'd1;         
    else 
        ro_select_port   <= ro_select_port;            
end


endmodule
