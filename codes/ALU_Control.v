module ALU_Control(funct_i, ALUOp_i, ALUCtrl_o);
    input [9:0] funct_i;
    input [1:0] ALUOp_i;
    wire [5:0] sig;
    output reg [2:0] ALUCtrl_o;
    
    

    assign sig = {funct_i[8], funct_i[3], funct_i[2:0], ALUOp_i[0]};

    always @(sig) begin
        case(sig)
            6'b001111: ALUCtrl_o = 3'b000; // and
            6'b001001: ALUCtrl_o = 3'b110; // xor
            6'b000011: ALUCtrl_o = 3'b101; // sll           
            6'b000001: ALUCtrl_o = 3'b001; // add
            6'b100001: ALUCtrl_o = 3'b111; // sub 
            6'b010001: ALUCtrl_o = 3'b011; // mul
            6'b101010: ALUCtrl_o = 3'b100; // srai             
            default: ALUCtrl_o = 3'b010; // addi
        endcase
    end 
endmodule