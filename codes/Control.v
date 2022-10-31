module Control(Op_i, ALUOp_o, ALUSrc_o, RegWrite_o);
    input [6:0] Op_i;
    output reg ALUSrc_o, RegWrite_o;
    // ALUOp from OpCode[6:5]
    // R format: 01 
    // I format: 00 
    output reg [1:0] ALUOp_o;
    
    always @(Op_i) begin 
        ALUOp_o <= Op_i[6:5];
        RegWrite_o <= 1'b1; // for all supported ops 

        if(~Op_i[5]) begin
            ALUSrc_o <= 1'b1;
        end else begin
            ALUSrc_o <= 1'b0;
        end 
    end
endmodule

