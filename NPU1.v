module NPU1(
input wire clk,rst,          //declared according to mentioned in the questions 
input wire [3:0]req,           
output reg [3:0]grant);

reg [1:0]pri;        //priority for assigning the user priority 

always@(*)begin 

grant=4'b0000;    //initially no one is granted access

case(pri)        //case block is used to assign priority

2'b00:begin
      if(req[0])        //checks if user req[0] is active if yes grants access to req[0], if not checks according to order
      grant[0]=4'b0001;
		else if(req[1])
		grant[1]=4'b0010;
		else if(req[2])
		grant[2]=4'b0100;
		else if(req[3])
		grant[3]=4'b1000;
		end
		
2'b01:begin
      if(req[1])        //checks if user req[1] is active if yes grants access to req[1], if not checks according to order
      grant[1]=4'b0010;
		else if(req[2])
		grant[2]=4'b0100;
		else if(req[3])
		grant[3]=4'b1000;
		else if(req[0])
		grant[0]=4'b0001;
      end
		
2'b10:begin
      if(req[2])        //checks if user req[2] is active if yes grants access to req[2], if not checks according to order
      grant[2]=4'b0100;
		else if(req[3])
		grant[3]=4'b1000;
		else if(req[0])
		grant[0]=4'b0001;
		else if(req[1])
		grant[1]=4'b0010;
      end
		
2'b11:begin
      if(req[3])        //checks if user req[3] is active if yes grants access to req[3], if not checks according to order
      grant[3]=4'b1000;
		else if(req[0])
		grant[0]=4'b0001;
		else if(req[1])
		grant[1]=4'b0010;
		else if(req[2])
		grant[2]=4'b0100;		
		end
		
endcase
end

always@(posedge clk or posedge rst)begin  //to update the priority so that the fair access is granted to every user
if(rst)
pri<=2'b00

else begin
if(grant[0])pri<=2'b01;              //updates priority so every users request is checked
else if(grant[1]pri<=2'b10;
else if(grant[2]pri<=2'b11;
else if(grant[3]pri<=2'b00;
end
end
endmodule