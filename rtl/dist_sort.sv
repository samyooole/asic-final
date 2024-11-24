module dist_sort (
    input logic clk, rst,
    input logic [63:0] query,     // 4-bit per element, 16 dimensions for all vectors
    input logic [63:0] search_0,  // search space: 8 different vectors
    input logic [63:0] search_1,
    input logic [63:0] search_2,
    input logic [63:0] search_3,
    input logic [63:0] search_4,
    input logic [63:0] search_5,
    input logic [63:0] search_6,
    input logic [63:0] search_7,
    input logic in_valid,         // start distance calc and sort operation
    output logic [2:0] addr_1st,  // 3 bit addresses for 2 closest vectors
    output logic [2:0] addr_2nd,
    output logic out_valid        // indicates valid output
);

    // Register declarations for input signals
    logic [63:0] query_reg;
    logic [63:0] search_0_reg, search_1_reg, search_2_reg, search_3_reg;
    logic [63:0] search_4_reg, search_5_reg, search_6_reg, search_7_reg;

    // Internal signals
    logic [15:0] dist_0, dist_1, dist_2, dist_3, dist_4, dist_5, dist_6, dist_7;
    logic [2:0] sort_addr_1, sort_addr_2;
    logic [15:0] data_addr_1, data_addr_2;
    logic [2:0] addr_1st_comb;
    logic [2:0] addr_2nd_comb;
    logic out_valid_comb;

    // Input registration
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            query_reg <= 64'b0;
            search_0_reg <= 64'b0;
            search_1_reg <= 64'b0;
            search_2_reg <= 64'b0;
            search_3_reg <= 64'b0;
            search_4_reg <= 64'b0;
            search_5_reg <= 64'b0;
            search_6_reg <= 64'b0;
            search_7_reg <= 64'b0;
        end else begin
            query_reg <= query;
            search_0_reg <= search_0;
            search_1_reg <= search_1;
            search_2_reg <= search_2;
            search_3_reg <= search_3;
            search_4_reg <= search_4;
            search_5_reg <= search_5;
            search_6_reg <= search_6;
            search_7_reg <= search_7;
        end
    end

    // Main combinational logic
    always_comb begin
        // Default assignments
        addr_1st_comb = 3'b1;
        addr_2nd_comb = 3'b1;
        out_valid_comb = 1'b1;
        
        if (!in_valid) begin
            // Keep default values
        end else begin
            // do the distance calculations explicitly

            dist_0 = (query_reg[3:0] - search_0_reg[3:0]) * (query_reg[3:0] - search_0_reg[3:0]) + 
                     (query_reg[7:4] - search_0_reg[7:4]) * (query_reg[7:4] - search_0_reg[7:4]) + 
                     (query_reg[11:8] - search_0_reg[11:8]) * (query_reg[11:8] - search_0_reg[11:8]) + 
                     (query_reg[15:12] - search_0_reg[15:12]) * (query_reg[15:12] - search_0_reg[15:12]) + 
                     (query_reg[19:16] - search_0_reg[19:16]) * (query_reg[19:16] - search_0_reg[19:16]) + 
                     (query_reg[23:20] - search_0_reg[23:20]) * (query_reg[23:20] - search_0_reg[23:20]) + 
                     (query_reg[27:24] - search_0_reg[27:24]) * (query_reg[27:24] - search_0_reg[27:24]) + 
                     (query_reg[31:28] - search_0_reg[31:28]) * (query_reg[31:28] - search_0_reg[31:28]) + 
                     (query_reg[35:32] - search_0_reg[35:32]) * (query_reg[35:32] - search_0_reg[35:32]) + 
                     (query_reg[39:36] - search_0_reg[39:36]) * (query_reg[39:36] - search_0_reg[39:36]) + 
                     (query_reg[43:40] - search_0_reg[43:40]) * (query_reg[43:40] - search_0_reg[43:40]) + 
                     (query_reg[47:44] - search_0_reg[47:44]) * (query_reg[47:44] - search_0_reg[47:44]) + 
                     (query_reg[51:48] - search_0_reg[51:48]) * (query_reg[51:48] - search_0_reg[51:48]) + 
                     (query_reg[55:52] - search_0_reg[55:52]) * (query_reg[55:52] - search_0_reg[55:52]) + 
                     (query_reg[59:56] - search_0_reg[59:56]) * (query_reg[59:56] - search_0_reg[59:56]) + 
                     (query_reg[63:60] - search_0_reg[63:60]) * (query_reg[63:60] - search_0_reg[63:60]);

            dist_1 = (query_reg[3:0] - search_1_reg[3:0]) * (query_reg[3:0] - search_1_reg[3:0]) + 
                        (query_reg[7:4] - search_1_reg[7:4]) * (query_reg[7:4] - search_1_reg[7:4]) + 
                        (query_reg[11:8] - search_1_reg[11:8]) * (query_reg[11:8] - search_1_reg[11:8]) + 
                        (query_reg[15:12] - search_1_reg[15:12]) * (query_reg[15:12] - search_1_reg[15:12]) + 
                        (query_reg[19:16] - search_1_reg[19:16]) * (query_reg[19:16] - search_1_reg[19:16]) + 
                        (query_reg[23:20] - search_1_reg[23:20]) * (query_reg[23:20] - search_1_reg[23:20]) + 
                        (query_reg[27:24] - search_1_reg[27:24]) * (query_reg[27:24] - search_1_reg[27:24]) + 
                        (query_reg[31:28] - search_1_reg[31:28]) * (query_reg[31:28] - search_1_reg[31:28]) + 
                        (query_reg[35:32] - search_1_reg[35:32]) * (query_reg[35:32] - search_1_reg[35:32]) + 
                        (query_reg[39:36] - search_1_reg[39:36]) * (query_reg[39:36] - search_1_reg[39:36]) + 
                        (query_reg[43:40] - search_1_reg[43:40]) * (query_reg[43:40] - search_1_reg[43:40]) + 
                        (query_reg[47:44] - search_1_reg[47:44]) * (query_reg[47:44] - search_1_reg[47:44]) + 
                        (query_reg[51:48] - search_1_reg[51:48]) * (query_reg[51:48] - search_1_reg[51:48]) + 
                        (query_reg[55:52] - search_1_reg[55:52]) * (query_reg[55:52] - search_1_reg[55:52]) + 
                        (query_reg[59:56] - search_1_reg[59:56]) * (query_reg[59:56] - search_1_reg[59:56]) + 
                        (query_reg[63:60] - search_1_reg[63:60]) * (query_reg[63:60] - search_1_reg[63:60]);
                     
            
            dist_2 = (query_reg[3:0] - search_2_reg[3:0]) * (query_reg[3:0] - search_2_reg[3:0]) + 
                     (query_reg[7:4] - search_2_reg[7:4]) * (query_reg[7:4] - search_2_reg[7:4]) + 
                     (query_reg[11:8] - search_2_reg[11:8]) * (query_reg[11:8] - search_2_reg[11:8]) + 
                     (query_reg[15:12] - search_2_reg[15:12]) * (query_reg[15:12] - search_2_reg[15:12]) + 
                     (query_reg[19:16] - search_2_reg[19:16]) * (query_reg[19:16] - search_2_reg[19:16]) + 
                     (query_reg[23:20] - search_2_reg[23:20]) * (query_reg[23:20] - search_2_reg[23:20]) + 
                     (query_reg[27:24] - search_2_reg[27:24]) * (query_reg[27:24] - search_2_reg[27:24]) + 
                     (query_reg[31:28] - search_2_reg[31:28]) * (query_reg[31:28] - search_2_reg[31:28]) + 
                     (query_reg[35:32] - search_2_reg[35:32]) * (query_reg[35:32] - search_2_reg[35:32]) + 
                     (query_reg[39:36] - search_2_reg[39:36]) * (query_reg[39:36] - search_2_reg[39:36]) + 
                     (query_reg[43:40] - search_2_reg[43:40]) * (query_reg[43:40] - search_2_reg[43:40]) + 
                     (query_reg[47:44] - search_2_reg[47:44]) * (query_reg[47:44] - search_2_reg[47:44]) + 
                     (query_reg[51:48] - search_2_reg[51:48]) * (query_reg[51:48] - search_2_reg[51:48]) + 
                     (query_reg[55:52] - search_2_reg[55:52]) * (query_reg[55:52] - search_2_reg[55:52]) + 
                     (query_reg[59:56] - search_2_reg[59:56]) * (query_reg[59:56] - search_2_reg[59:56]) + 
                     (query_reg[63:60] - search_2_reg[63:60]) * (query_reg[63:60] - search_2_reg[63:60]);

            dist_3 = (query_reg[3:0] - search_3_reg[3:0]) * (query_reg[3:0] - search_3_reg[3:0]) + 
                     (query_reg[7:4] - search_3_reg[7:4]) * (query_reg[7:4] - search_3_reg[7:4]) + 
                     (query_reg[11:8] - search_3_reg[11:8]) * (query_reg[11:8] - search_3_reg[11:8]) + 
                     (query_reg[15:12] - search_3_reg[15:12]) * (query_reg[15:12] - search_3_reg[15:12]) + 
                     (query_reg[19:16] - search_3_reg[19:16]) * (query_reg[19:16] - search_3_reg[19:16]) + 
                     (query_reg[23:20] - search_3_reg[23:20]) * (query_reg[23:20] - search_3_reg[23:20]) + 
                     (query_reg[27:24] - search_3_reg[27:24]) * (query_reg[27:24] - search_3_reg[27:24]) + 
                     (query_reg[31:28] - search_3_reg[31:28]) * (query_reg[31:28] - search_3_reg[31:28]) + 
                     (query_reg[35:32] - search_3_reg[35:32]) * (query_reg[35:32] - search_3_reg[35:32]) + 
                     (query_reg[39:36] - search_3_reg[39:36]) * (query_reg[39:36] - search_3_reg[39:36]) + 
                     (query_reg[43:40] - search_3_reg[43:40]) * (query_reg[43:40] - search_3_reg[43:40]) + 
                     (query_reg[47:44] - search_3_reg[47:44]) * (query_reg[47:44] - search_3_reg[47:44]) + 
                     (query_reg[51:48] - search_3_reg[51:48]) * (query_reg[51:48] - search_3_reg[51:48]) + 
                     (query_reg[55:52] - search_3_reg[55:52]) * (query_reg[55:52] - search_3_reg[55:52]) + 
                     (query_reg[59:56] - search_3_reg[59:56]) * (query_reg[59:56] - search_3_reg[59:56]) + 
                     (query_reg[63:60] - search_3_reg[63:60]) * (query_reg[63:60] - search_3_reg[63:60]);

            dist_4 = (query_reg[3:0] - search_4_reg[3:0]) * (query_reg[3:0] - search_4_reg[3:0]) + 
                     (query_reg[7:4] - search_4_reg[7:4]) * (query_reg[7:4] - search_4_reg[7:4]) + 
                     (query_reg[11:8] - search_4_reg[11:8]) * (query_reg[11:8] - search_4_reg[11:8]) + 
                     (query_reg[15:12] - search_4_reg[15:12]) * (query_reg[15:12] - search_4_reg[15:12]) + 
                     (query_reg[19:16] - search_4_reg[19:16]) * (query_reg[19:16] - search_4_reg[19:16]) + 
                     (query_reg[23:20] - search_4_reg[23:20]) * (query_reg[23:20] - search_4_reg[23:20]) + 
                     (query_reg[27:24] - search_4_reg[27:24]) * (query_reg[27:24] - search_4_reg[27:24]) + 
                     (query_reg[31:28] - search_4_reg[31:28]) * (query_reg[31:28] - search_4_reg[31:28]) + 
                     (query_reg[35:32] - search_4_reg[35:32]) * (query_reg[35:32] - search_4_reg[35:32]) + 
                     (query_reg[39:36] - search_4_reg[39:36]) * (query_reg[39:36] - search_4_reg[39:36]) + 
                     (query_reg[43:40] - search_4_reg[43:40]) * (query_reg[43:40] - search_4_reg[43:40]) + 
                     (query_reg[47:44] - search_4_reg[47:44]) * (query_reg[47:44] - search_4_reg[47:44]) + 
                     (query_reg[51:48] - search_4_reg[51:48]) * (query_reg[51:48] - search_4_reg[51:48]) + 
                     (query_reg[55:52] - search_4_reg[55:52]) * (query_reg[55:52] - search_4_reg[55:52]) + 
                     (query_reg[59:56] - search_4_reg[59:56]) * (query_reg[59:56] - search_4_reg[59:56]) + 
                     (query_reg[63:60] - search_4_reg[63:60]) * (query_reg[63:60] - search_4_reg[63:60]);

            dist_5 = (query_reg[3:0] - search_5_reg[3:0]) * (query_reg[3:0] - search_5_reg[3:0]) + 
                     (query_reg[7:4] - search_5_reg[7:4]) * (query_reg[7:4] - search_5_reg[7:4]) + 
                     (query_reg[11:8] - search_5_reg[11:8]) * (query_reg[11:8] - search_5_reg[11:8]) + 
                     (query_reg[15:12] - search_5_reg[15:12]) * (query_reg[15:12] - search_5_reg[15:12]) + 
                     (query_reg[19:16] - search_5_reg[19:16]) * (query_reg[19:16] - search_5_reg[19:16]) + 
                     (query_reg[23:20] - search_5_reg[23:20]) * (query_reg[23:20] - search_5_reg[23:20]) + 
                     (query_reg[27:24] - search_5_reg[27:24]) * (query_reg[27:24] - search_5_reg[27:24]) + 
                     (query_reg[31:28] - search_5_reg[31:28]) * (query_reg[31:28] - search_5_reg[31:28]) + 
                     (query_reg[35:32] - search_5_reg[35:32]) * (query_reg[35:32] - search_5_reg[35:32]) + 
                     (query_reg[39:36] - search_5_reg[39:36]) * (query_reg[39:36] - search_5_reg[39:36]) + 
                     (query_reg[43:40] - search_5_reg[43:40]) * (query_reg[43:40] - search_5_reg[43:40]) + 
                     (query_reg[47:44] - search_5_reg[47:44]) * (query_reg[47:44] - search_5_reg[47:44]) + 
                     (query_reg[51:48] - search_5_reg[51:48]) * (query_reg[51:48] - search_5_reg[51:48]) + 
                     (query_reg[55:52] - search_5_reg[55:52]) * (query_reg[55:52] - search_5_reg[55:52]) + 
                     (query_reg[59:56] - search_5_reg[59:56]) * (query_reg[59:56] - search_5_reg[59:56]) + 
                     (query_reg[63:60] - search_5_reg[63:60]) * (query_reg[63:60] - search_5_reg[63:60]);

            dist_6 = (query_reg[3:0] - search_6_reg[3:0]) * (query_reg[3:0] - search_6_reg[3:0]) + 
                     (query_reg[7:4] - search_6_reg[7:4]) * (query_reg[7:4] - search_6_reg[7:4]) + 
                     (query_reg[11:8] - search_6_reg[11:8]) * (query_reg[11:8] - search_6_reg[11:8]) + 
                     (query_reg[15:12] - search_6_reg[15:12]) * (query_reg[15:12] - search_6_reg[15:12]) + 
                     (query_reg[19:16] - search_6_reg[19:16]) * (query_reg[19:16] - search_6_reg[19:16]) + 
                     (query_reg[23:20] - search_6_reg[23:20]) * (query_reg[23:20] - search_6_reg[23:20]) + 
                     (query_reg[27:24] - search_6_reg[27:24]) * (query_reg[27:24] - search_6_reg[27:24]) + 
                     (query_reg[31:28] - search_6_reg[31:28]) * (query_reg[31:28] - search_6_reg[31:28]) + 
                     (query_reg[35:32] - search_6_reg[35:32]) * (query_reg[35:32] - search_6_reg[35:32]) + 
                     (query_reg[39:36] - search_6_reg[39:36]) * (query_reg[39:36] - search_6_reg[39:36]) + 
                     (query_reg[43:40] - search_6_reg[43:40]) * (query_reg[43:40] - search_6_reg[43:40]) + 
                     (query_reg[47:44] - search_6_reg[47:44]) * (query_reg[47:44] - search_6_reg[47:44]) + 
                     (query_reg[51:48] - search_6_reg[51:48]) * (query_reg[51:48] - search_6_reg[51:48]) + 
                     (query_reg[55:52] - search_6_reg[55:52]) * (query_reg[55:52] - search_6_reg[55:52]) + 
                     (query_reg[59:56] - search_6_reg[59:56]) * (query_reg[59:56] - search_6_reg[59:56]) + 
                     (query_reg[63:60] - search_6_reg[63:60]) * (query_reg[63:60] - search_6_reg[63:60]);

            dist_7 = (query_reg[3:0] - search_7_reg[3:0]) * (query_reg[3:0] - search_7_reg[3:0]) + 
                     (query_reg[7:4] - search_7_reg[7:4]) * (query_reg[7:4] - search_7_reg[7:4]) + 
                     (query_reg[11:8] - search_7_reg[11:8]) * (query_reg[11:8] - search_7_reg[11:8]) + 
                     (query_reg[15:12] - search_7_reg[15:12]) * (query_reg[15:12] - search_7_reg[15:12]) + 
                     (query_reg[19:16] - search_7_reg[19:16]) * (query_reg[19:16] - search_7_reg[19:16]) + 
                     (query_reg[23:20] - search_7_reg[23:20]) * (query_reg[23:20] - search_7_reg[23:20]) + 
                     (query_reg[27:24] - search_7_reg[27:24]) * (query_reg[27:24] - search_7_reg[27:24]) + 
                     (query_reg[31:28] - search_7_reg[31:28]) * (query_reg[31:28] - search_7_reg[31:28]) + 
                     (query_reg[35:32] - search_7_reg[35:32]) * (query_reg[35:32] - search_7_reg[35:32]) + 
                     (query_reg[39:36] - search_7_reg[39:36]) * (query_reg[39:36] - search_7_reg[39:36]) + 
                     (query_reg[43:40] - search_7_reg[43:40]) * (query_reg[43:40] - search_7_reg[43:40]) + 
                     (query_reg[47:44] - search_7_reg[47:44]) * (query_reg[47:44] - search_7_reg[47:44]) + 
                     (query_reg[51:48] - search_7_reg[51:48]) * (query_reg[51:48] - search_7_reg[51:48]) + 
                     (query_reg[55:52] - search_7_reg[55:52]) * (query_reg[55:52] - search_7_reg[55:52]) + 
                     (query_reg[59:56] - search_7_reg[59:56]) * (query_reg[59:56] - search_7_reg[59:56]) + 
                     (query_reg[63:60] - search_7_reg[63:60]) * (query_reg[63:60] - search_7_reg[63:60]);
                     
            // Find first smallest distance



            sort_addr_1 = 3'b000;
            data_addr_1 = dist_0;
            
            if (dist_1 < data_addr_1) begin sort_addr_1 = 3'b001; data_addr_1 = dist_1; end
            if (dist_2 < data_addr_1) begin sort_addr_1 = 3'b010; data_addr_1 = dist_2; end
            if (dist_3 < data_addr_1) begin sort_addr_1 = 3'b011; data_addr_1 = dist_3; end
            if (dist_4 < data_addr_1) begin sort_addr_1 = 3'b100; data_addr_1 = dist_4; end
            if (dist_5 < data_addr_1) begin sort_addr_1 = 3'b101; data_addr_1 = dist_5; end
            if (dist_6 < data_addr_1) begin sort_addr_1 = 3'b110; data_addr_1 = dist_6; end
            if (dist_7 < data_addr_1) begin sort_addr_1 = 3'b111; data_addr_1 = dist_7; end

            // Find second smallest distance
            sort_addr_2 = 3'b000;
            data_addr_2 = (sort_addr_1 == 3'b000) ? dist_1 : dist_0;

            if ((dist_1 < data_addr_2) && (sort_addr_1 != 3'b001)) begin sort_addr_2 = 3'b001; data_addr_2 = dist_1; end
            if ((dist_2 < data_addr_2) && (sort_addr_1 != 3'b010)) begin sort_addr_2 = 3'b010; data_addr_2 = dist_2; end
            if ((dist_3 < data_addr_2) && (sort_addr_1 != 3'b011)) begin sort_addr_2 = 3'b011; data_addr_2 = dist_3; end
            if ((dist_4 < data_addr_2) && (sort_addr_1 != 3'b100)) begin sort_addr_2 = 3'b100; data_addr_2 = dist_4; end
            if ((dist_5 < data_addr_2) && (sort_addr_1 != 3'b101)) begin sort_addr_2 = 3'b101; data_addr_2 = dist_5; end
            if ((dist_6 < data_addr_2) && (sort_addr_1 != 3'b110)) begin sort_addr_2 = 3'b110; data_addr_2 = dist_6; end
            if ((dist_7 < data_addr_2) && (sort_addr_1 != 3'b111)) begin sort_addr_2 = 3'b111; data_addr_2 = dist_7; end



            addr_1st_comb = sort_addr_1;
            addr_2nd_comb = sort_addr_2;
            out_valid_comb = 1'b1;
        end
    end

    // Output registration
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            addr_1st <= 3'b0;
            addr_2nd <= 3'b0;
            out_valid <= 1'b0;
        end else begin
            addr_1st <= addr_1st_comb;
            addr_2nd <= addr_2nd_comb;
            out_valid <= out_valid_comb;
        end
    end

endmodule