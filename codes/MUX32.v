module MUX32(data1_i, data2_i, select_i, data_o);
input select_i;
input [31:0] data1_i, data2_i;
output reg [31:0] data_o;

always @(select_i or data1_i or data2_i) 
    begin
        if(~select_i)
            data_o <= data1_i;
        else
            data_o <= data2_i;

    end 
endmodule
