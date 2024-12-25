module traffic_light_fsm(
    input clk,
    input rst,
    output reg [3:0] A_lights,//高到低位分别为左拐，绿灯，黄灯，红灯
    output reg [3:0] B_lights,
	 output reg	[3:0] Astate,//用来传输A路灯状态给数码管
	 output reg [3:0] Bstate,//用来传输b路灯状态给数码管
    output reg [6:0] Acountdown, // 定义为 reg 类型
	 output reg [6:0] Bcountdown

);
    reg [3:0] statea;
	 reg [3:0] stateb;
    reg [6:0] timera;
	 reg [6:0] timerb;

					

	localparam S0 = 4'd0, S1 = 4'd1, S2 = 4'd2, S3 = 4'd3,
               S4 = 4'd4,S5=4'd5;
					
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            statea <= S0;                       
				stateb<=S0;
            timera <= 7'd0;
				timerb<=7'd0;
        end else begin

            if (timera == 0) begin
                case (statea)
                    S0: begin Astate<=S1;statea <= S1; timera <= 7'd15; end//包含了A中s5，s6，s7，s0（A的红灯状态）
                    S1: begin Astate<=S2;statea <= S2; timera <= 7'd5; end//A左拐
                    S2: begin Astate<=S3;statea <= S3; timera <= 7'd40; end//A黄灯
                    S3: begin Astate<=S4;statea <= S4; timera<= 7'd5; end//A绿灯
                    S4: begin Astate<=S0;statea <= S0; timera <= 7'd55; end//A黄灯
                endcase 
				end	else begin
            timera <= timera - 1; // 仅在 `timera > 0` 时递减
        end
	
				if(timerb==0)begin
					 case(stateb)
						  S0: begin Bstate<=S1;stateb <= S1; timerb <= 7'd65; end//B黄灯
                    S1: begin Bstate<=S2;stateb <= S2; timerb <= 7'd15; end//B红灯
                    S2: begin Bstate<=S3;stateb <= S3; timerb <= 7'd5; end//B左拐
                    S3: begin Bstate<=S4;stateb <= S4; timerb <= 7'd30; end///B黄灯
                    S4: begin Bstate<=S0;stateb <= S0; timerb <= 7'd5; end//B绿灯
					 endcase 
            end else begin
            timerb <= timerb - 1; // 仅在 `timerb > 0` 时递减
        end
		end  
    end

    always @(posedge clk or negedge rst) begin
        if (!rst)begin
            Acountdown <= 7'd0;
				Bcountdown<=7'd0;
				end
        else begin
            Acountdown <= timera; // 同步更新 Acountdown
				Bcountdown <= timerb;
				end
    end

    always @(*) begin
        case (statea)
            S0: begin A_lights = 4'b0001; end // 
            S1: begin A_lights = 4'b1000; end // 
            S2: begin A_lights = 4'b0010; end // 
            S3: begin A_lights = 4'b0100; end //
            S4: begin A_lights = 4'b0010; end //
            default: begin A_lights = 4'b0000; end
        endcase
		  case(stateb)
				S0: begin B_lights = 4'b0010; end // 
            S1: begin B_lights = 4'b0001; end // 
            S2: begin B_lights = 4'b1000; end // 
            S3: begin B_lights = 4'b0010; end //
            S4: begin B_lights = 4'b0100; end //
            default: begin B_lights = 4'b0000; end
        endcase
    end
endmodule
