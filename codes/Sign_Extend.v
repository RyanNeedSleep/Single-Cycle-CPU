module Sign_Extend(data_i, data_o);
    input wire [11:0] data_i;
    output reg [31:0] data_o;
   
    always @(data_i) begin
        data_o <= {{20{data_i[11]}}, data_i};
    end
endmodule