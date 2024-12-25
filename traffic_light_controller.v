// 顶层模块
module traffic_light_controller(
     input clk,
    input rst,
    output [3:0] A_lights,
    output [3:0] B_lights,
    //output [6:0] Acountdown,
	 //output [6:0] Bcountdown,
	 //output [3:0] Astate,//用于传给数码管A路当前状态
	 //output [3:0] Bstate,//用于传输数码管B路当前状态
	 output wire[7:0] duanma,//用来表示数码管共阳段码
	 output wire[5:0] shumaguan_choose//用来选择第几个数码管,0表示启用第几个数码管
//	 output wire[6:0] Acountdown,//用于仿真观查计时时间能否正确传给数码管
//	 output wire[3:0]Astate//用于仿真观察A路状态是否正确还给数码管
//	 output wire[6:0] test//用来看仿真中Acountdown/10是否正确
);
    wire clk_1hz;
	 wire clk2;//数码管刷新频率
	wire [6:0]Acountdown;
	wire [6:0] Bcountdown;
	wire [3:0] Astate;//用于传给数码管A路当前状态
	wire [3:0] Bstate;//用于传输数码管B路当前状态
    clock_divider clk_div(
        .clk(clk),
        .rst(rst),
        .clk_out(clk_1hz),
		  .clk_out2(clk2)
    );

    traffic_light_fsm fsm(
        .clk(clk_1hz),
        .rst(rst),
        .A_lights(A_lights),
        .B_lights(B_lights),
		  .Astate(Astate),
		  .Bstate(Bstate),
        .Acountdown(Acountdown),
		  .Bcountdown(Bcountdown)
    );
	 
	 shumaguan(
	 .clk(clk2),
	 .rst(rst),
	 .Acountdown(Acountdown),
	 .Bcountdown(Bcountdown),
	 .Astate(Astate),
	 .Bstate(Bstate),
	 .duanma(duanma),
	 .shumaguan_choose(shumaguan_choose)
//	 .test(tset)
	 );
	 
endmodule
























