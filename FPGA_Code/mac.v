module MAC_unit(input clk,rst, input [15:0] In1,In2, output reg [15:0] result); 
reg signed [15:0] mult; 
initial begin 
	mult <=0; 
	result <=0;
end
always @(In2) begin 
	if(rst) begin 
		result<=0; 
		mult <=0; 
	end 
	else begin 
		mult <= multiplication(In1,In2);
		result <= signed_addition(result,mult); 
	end
end

function [15:0] signed_addition(input [15:0] a,b);
reg overflow; 
reg carry; 
begin 
	{carry,signed_addition} = a +b; 
	overflow = carry ^ signed_addition[15]; 
	if(overflow) begin 
	if({carry,signed_addition[15]}==2'b01) signed_addition= 16'h7FFF;
	else if( {carry,signed_addition[15]}==2'b10) signed_addition = 16'h8001;
	else signed_addition = 16'h0000;	
end
end
endfunction 

function [15:0] multiplication(input [15:0] a,b); 
reg [31:0] temp; 
reg overflow; 
begin 
	temp = a*b;
	overflow = ^temp[31:24]; 
	if(overflow) begin 
		casex(temp[31:24])
		8'b0xxxxxx1: multiplication = 16'h7FFF; 
		default: multiplication = 16'h8001;
		endcase
	end
	else begin
		casex(temp[10:0])
		11'bxx0xxxxxxxx: multiplication = temp[24:9]; 
		11'b00100000000: multiplication = temp[24:9]; 
		default: multiplication = temp[24:9]+16'h1;
		endcase 
	end
end
endfunction
endmodule

