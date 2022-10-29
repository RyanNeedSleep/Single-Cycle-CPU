module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;


// My Attempt
wire [31:0] PCstep; 
assign PCstep = 32'h00000004;

wire [31:0] currentPC; 
wire [31:0] nextPC;
wire [31:0] inst;
wire [31:0] RD, RS1, RS2;
wire [1:0] ALUOp; 
wire ALUSrc, RegWrite;
wire [31:0] ALUout, B, mux0;
wire [2:0] ALUCtrl;
wire [4:0] rd_addr, rs1_addr, rs2_addr;
wire [11:0] immediate;
wire [9:0] func73;


assign immediate = inst[31:20];
assign rs1_addr = inst[19:15];
assign rs2_addr = inst[24:20];
assign rd_addr = inst[11:7];
assign func73 = {inst[31:25], inst[14:12]};


Control Control(
    .Op_i       (inst[6:0]),
    .ALUOp_o    (ALUOp),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite)
);



Adder Add_PC(
    .data1_in   (currentPC),
    .data2_in   (PCstep),
    .data_o     (nextPC)
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (nextPC),
    .pc_o       (currentPC)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (currentPC), 
    .instr_o    (inst)
);

Registers Registers(
    .clk_i      (clk_i),
    .RS1addr_i   (rs1_addr),
    .RS2addr_i   (rs2_addr),
    .RDaddr_i   (rd_addr), 
    .RDdata_i   (ALUout),
    .RegWrite_i (RegWrite), 
    .RS1data_o   (RS1), 
    .RS2data_o   (RS2) 
);


MUX32 MUX_ALUSrc(
    .data1_i    (RS2),
    .data2_i    (mux0),
    .select_i   (ALUSrc),
    .data_o     (B)
);




Sign_Extend Sign_Extend(
    .data_i     (immediate),
    .data_o     (mux0)
);
  

ALU ALU(
    .data1_i    (RS1),
    .data2_i    (B),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (ALUout),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct_i    (func73),
    .ALUOp_i    (ALUOp),
    .ALUCtrl_o  (ALUCtrl)   
);

endmodule

