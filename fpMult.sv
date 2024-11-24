module mult (
    input logic [15:0] inp_a,  // 16-bit input a
    input logic [15:0] inp_b,  // 16-bit input b
    input logic clk, rst,      // input clock and reset
    output logic [31:0] prod   // 32-bit output FP multiplication product
);

    // mult is a module that take 2 16-bit inputs and does fixed-point precision multiplication
    logic [15:0] reg_a, reg_b;
    logic [31:0] reg_prod;

    // apparently you can just multiply them and verilog natively handles bit multiplication - great
    // we flop forward in 3 sequential stages
    // stage 1: input flops
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_a <= 16'b0;
            reg_b <= 16'b0;
        end else begin
            reg_a <= inp_a;
            reg_b <= inp_b;
        end
    end

    // stage 2: multiplication logic flop
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_prod <= 32'b0;
        end else begin
            reg_prod <= (reg_a * reg_b);
        end
    end

    // stage 3: product output flop
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            prod <= 32'b0;
        end else begin
            prod <= reg_prod;
        end
    end

endmodule
