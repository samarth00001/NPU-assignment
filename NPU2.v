
module NPU2 (
    input  wire   reset,start,clk,             //decalred according to question requirement
    input  wire [3:0] multiplicand_in,
    input  wire [3:0] multiplier_in,          
    output wire [7:0] product,
    output reg  busy,done);                     //busy and done are both telling if the multiplication is under progress or completed

    reg [3:0] M;        //reg used for multipling process       
    reg [3:0] A;       
    reg [3:0] Q;      
    reg C;       
    reg [2:0] count;

   
    wire [4:0] add_result;  //the 5 bit wire after adding                                      
    assign add_result ={1'b0, A} +(Q[0] ? {1'b0, M} : 5'b00000);   //mux output management

    
    wire [8:0] shifted;                    
    assign shifted = {add_result, Q} >> 1;     //shifts the value to right 

  
    assign product = {A, Q};     //the final product combining A and Q

    always @(posedge clk or posedge reset) begin          //setting them to reset value initially
        if (reset) begin
            M     <= 4'b0000;
            A     <= 4'b0000;
            Q     <= 4'b0000;
            C     <= 1'b0;
            count <= 3'd0;
            busy  <= 1'b0;
            done  <= 1'b0;
        end
        else begin
            
            done <= 1'b0;
                                               //checks to start and checks if previous multiplication is running or not
            if (start && !busy) begin
                M     <= multiplicand_in;
                Q     <= multiplier_in;
                A     <= 4'b0000;
                C     <= 1'b0;
                count <= 3'd0;
                busy  <= 1'b1;
            end
            else if (busy) begin       //shifted value gets assigned 
               
                C <= shifted[8];         
                A <= shifted[7:4];
                Q <= shifted[3:0];

                if (count == 3'd3) begin     //after 3 counts the opertion stops as it passes this if statemnet and everthing resets
                   
                    busy  <= 1'b0;
                    done  <= 1'b1;
                    count <= 3'd4;
                end
                else begin
                    count <= count + 1'b1;
 end
 end
 end
 end

endmodule
