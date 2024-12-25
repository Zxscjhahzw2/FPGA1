// 时钟分频模块
module clock_divider(
    input clk,
    input rst,
    output reg clk_out,
	 output reg clk_out2
);
    reg [24:0] counter;
	 reg[24:0]counter2;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            counter <= 0;
            clk_out <= 0;

        end else if (counter ==  24999999) begin // 
            counter <= 0;
            clk_out <= ~clk_out;
        end else begin  
            counter <= counter + 1;
        end
    end
	 

	     always @(posedge clk or negedge rst) begin
        if (!rst) begin
            counter2 <= 0;
            clk_out2 <= 0;

        end else if (counter2 == 9999) begin // 
            counter2 <= 0;
            clk_out2 <= ~clk_out2;
        end else begin  
            counter2 <= counter2 + 1;
        end
    end
	
//仿真测试代码
//
//    always @(posedge clk or negedge rst) begin
//        if (!rst)
//            clk_out <= 0; // 复位时输出低
//        else
//            clk_out <= ~clk_out; // 输出直接跟随输入时钟
//    end
	 
//	     always @(posedge clk or negedge rst) begin
//        if (!rst) begin
//            counter <= 0;
//           clk_out <= 0;
//
//       end else if (counter == 10) begin // 
//            counter <= 0;
//            clk_out <= ~clk_out;
//        end else begin  
//            counter <= counter + 1;
//       end
//    end
//	 
//	 
//	
//    always @(posedge clk or negedge rst) begin
//        if (!rst)
//            clk_out2 <= 0; // 复位时输出低
//        else
//            clk_out2 <=~clk_out2; // 输出直接跟随输入时钟
//    end

endmodule







