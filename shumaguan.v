//unsigned char code distab[16]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8, 0x80,0x90,0x88,0x83,0xc6,0xa1,0x86,0x8e}；共阳无小数点数码管段码
/*
0 ->c0
1  ->f9
2   ->a4
3 ->  b0
4 ->   99
5    -> 92
6  ->  82
7  -> f8
8   -> 80 
9  ->90
red   ->r->0x0F
green_->g->0x10
yellow-> y->0x11
left->l->0x47
*/
module shumaguan(
input clk,
input rst,
input [6:0]Acountdown,//Alu时间显示
input [6:0]Bcountdown,//Blu时间显示
input wire[3:0] Astate,//用来接收Alu传来的状态
input wire[3:0] Bstate,//用来接收B路传来状态
output reg[7:0] duanma,//用来表示数码管共阳段码
output reg[5:0] shumaguan_choose//用来选择第几个数码管,0表示启用第几个数码管
//output reg[6:0] test//用来看Acountdown/10是否正确
);

reg[7:0] array[0:9];



    localparam S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3,
               S4 = 4'd4;
always@(posedge clk or negedge rst)begin

	if(!rst)begin
	array[0]<=8'hc0;	
		array[1]<=8'hf9;
		array[2]<=8'ha4;
		array[3]<=8'hb0;
		array[4]<=8'h99;
		array[5]<=8'h92;
		array[6]<=8'h82;
		array[7]<=8'hf8;
		array[8]<=8'h80;
		array[9]<=8'h90;	
		shumaguan_choose<=6'b111111;
   end else begin
		case(shumaguan_choose)
			6'b111111:begin	
				case(Astate)
							S0: begin duanma<=8'h0f;shumaguan_choose <= 6'b111110;  end // A显示r
							S1: begin duanma<=8'h47;shumaguan_choose <= 6'b111110;  end // A显示L
							S2: begin duanma<=8'h11;shumaguan_choose <= 6'b111110;  end // y，r
							S3: begin duanma<=8'h10;shumaguan_choose <= 6'b111110;  end // g，r
							S4: begin duanma<=8'h11;shumaguan_choose <= 16'b111110;  end // y,r
				endcase
			end
		
		
		6'b111110:begin

			duanma<=array[Acountdown/10];shumaguan_choose <= 6'b111101;
			
			
		  end	
		
		6'b111101:begin

			duanma<=array[Acountdown%10]; shumaguan_choose <= 6'b111011;
			

		  end
		
		6'b111011:begin
			case(Bstate)
						S0: begin duanma<=8'h11;shumaguan_choose <= 6'b110111; end // A显示r,b显示y
						S1: begin duanma<=8'h0f;shumaguan_choose <= 6'b110111; end // A显示L，b显示r
						S2: begin duanma<=8'h47;shumaguan_choose <= 6'b110111; end // y，l
						S3: begin duanma<=8'h11;shumaguan_choose <= 6'b110111; end // g，Y
						S4: begin duanma<=8'h10;shumaguan_choose <= 6'b110111; end // y,G

			endcase
		  end
		6'b110111:begin

			duanma<=array[Bcountdown/10]; shumaguan_choose <= 6'b101111;
		 end
		
		6'b101111:begin

			duanma<=array[Bcountdown%10]; shumaguan_choose <= 6'b011111;
			end
		6'b011111:begin
			shumaguan_choose <= 6'b111111;
		end
		endcase
	 end
end


endmodule





//reg [19:0] clk_div; // 用于时钟分频，控制数码管刷新
//reg clk_out; // 分频后的时钟输出
// initial begin
//array[0]=8'hc0;	
//array[1]=8'hf9;
//array[2]=8'ha4;
//array[3]=8'hb0;
//array[4]=8'h99;
//array[5]=8'h92;
//array[6]=8'h82;
//array[7]=8'hf8;
//array[8]=8'h80;
//array[9]=8'h90;	
//shumaguan_choose=6'b111110;
//end

// 时钟分频逻辑
//always @(posedge clk) begin
//    clk_div <= clk_div + 1;
//    if (clk_div == 20'd99999) begin
//        clk_out <= ~clk_out;
//        clk_div <= 0;
//    end
//end

//    parameter [7:0] array [9:0] = {8'hc0, 8'hf9, 8'ha4, 8'hb0, 8'h99, 
//                                         8'h92, 8'h82, 8'hf8, 8'h80, 8'h90};













