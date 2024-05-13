module test(
	input clk,
	input reset,
	input EN,
	output[6:0] decodeout0,
	output[6:0] decodeout1,
	output[6:0] decodeout2,
	output[6:0] decodeout3,
	output[6:0] decodeout4,
	output[6:0] decodeout5
);
wire[7:0] qout_s;
wire[7:0] qout_m;
wire[7:0] qout_h;

clock a(
	.clk(clk),
	.reset(reset),
	.EN(EN),
	.qout_s(qout_s),
	.qout_m(qout_m),
	.qout_h(qout_h)	
);

decode4_7 e(
	.decodeout(decodeout0),
	.indec(qout_h[7:4])
);
decode4_7 f(
	.decodeout(decodeout1),
	.indec(qout_h[3:0])
);
decode4_7 g(
	.decodeout(decodeout2),
	.indec(qout_m[7:4])
);
decode4_7 h(
	.decodeout(decodeout3),
	.indec(qout_m[3:0])
);
decode4_7 i(
	.decodeout(decodeout4),
	.indec(qout_s[7:4])
);
decode4_7 j(
	.decodeout(decodeout5),
	.indec(qout_s[3:0])
);

endmodule


module clock(
	input clk,
	input reset,
	input EN,
	output[7:0] qout_s,
	output[7:0] qout_m,
	output[7:0] qout_h
);
wire cout_s;
wire cout_m;
wire clk_1s;

divide_1hz a(
	.clk(clk),
	.reset(reset),
	.clk_1s(clk_1s)
);

count60 b(
	.qout(qout_s),
	.cout(cout_s),
	.reset(reset),
	.EN(EN),
	.clk(clk_1s)
);

count60 c(
	.qout(qout_m),
	.cout(cout_m),
	.reset(reset),
	.EN(EN),
	.clk(cout_s)
);

count24 d(
	.qout(qout_h),
	.reset(reset),
	.EN(EN),
	.clk(cout_m)
);

endmodule

module divide_1hz(
	input clk,
	input reset,
	output reg clk_1s
);
	reg [25:0]cnt1;
	always @(posedge clk or negedge reset)
	begin
		if(!reset) cnt1<=8'd0;
		else if(cnt1==26'd24999999)
			cnt1<=8'd0;
		else
			cnt1<=cnt1+8'd1;
	end
	always @(posedge clk or negedge reset)
	begin
		if(!reset) clk_1s<=8'd0;
		else if(cnt1==26'd24999999)
			clk_1s<=~clk_1s;
		else
			clk_1s<=clk_1s;
	end
endmodule
	
module decode4_7(decodeout,indec);
output[6:0] decodeout ;
input[3:0] indec;
reg[6:0] decodeout;
always @(indec)
	begin
		case(indec)
		4'd0:decodeout=7'b1000000;
		4'd1:decodeout=7'b1111001;
		4'd2:decodeout=7'b0100100;
		4'd3:decodeout=7'b0110000;
		4'd4:decodeout=7'b0011001;
		4'd5:decodeout=7'b0010010;
		4'd6:decodeout=7'b0000010;
		4'd7:decodeout=7'b1111000;
		4'd8:decodeout=7'b0000000;
		4'd9:decodeout=7'b0010000;
		default: decodeout=7'bx;
	   endcase
	end
endmodule

module count60(qout,cout,reset,clk,EN);
output[7:0] qout;
output[1:0] cout;
input clk,reset,EN;
reg[7:0] qout;
reg[1:0] cout;
always @(posedge clk or negedge reset)
	begin
		if(!reset) qout<=4'd0;
		else if(EN)
		begin
			qout<=qout;
		end
		else
		begin
			if(qout[3:0]==4'd9)
				begin
				qout[3:0]<=4'd0;
				if(qout[7:4]==4'd5)
				begin
					cout <= 4'd1;
					qout[7:4]<=4'd0;
				end
				else
					qout[7:4]<=qout[7:4]+4'd1;
				end
			else
				begin
				qout[3:0]<=qout[3:0]+4'd1;
				cout <= 4'd0;
				end
		end
	end
endmodule

module count24(qout,reset,clk,EN);
output[7:0] qout;
input clk,reset,EN;
reg[7:0] qout;
always @(posedge clk)
	begin
		if(!reset) qout<=1'b0;
		else if(EN)
		begin
			qout<=qout;
		end
		else 
			begin
				if(qout[3:0]==4'd9)
					begin
					qout[3:0]<=4'd0;
					qout[7:4]<=qout[7:4]+4'd1;
					end
				else
					qout[3:0]<=qout[3:0]+4'd1;
				if(qout[3:0]==4'd3)
					begin
						if(qout[7:4]==4'd2)
						begin
						qout[7:4]<=4'd0;
						qout[3:0]<=4'd0;
						end
					end
			end
	end
endmodule
