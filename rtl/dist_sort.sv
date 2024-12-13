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

    // Input FF
    logic [63:0] query_reg;
    logic [63:0] search_reg[7:0];
    logic in_valid_reg;

    logic [2:0] addr_1st_reg, addr_2nd_reg;
    logic out_valid_reg;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            query_reg <= '0;
            search_reg[0] <= '0;
            search_reg[1] <= '0;
            search_reg[2] <= '0;
            search_reg[3] <= '0;
            search_reg[4] <= '0;
            search_reg[5] <= '0;
            search_reg[6] <= '0;
            search_reg[7] <= '0;
            in_valid_reg <= 1'b0;
        end else begin
            query_reg <= query;
            search_reg[0] <= search_0;
            search_reg[1] <= search_1;
            search_reg[2] <= search_2;
            search_reg[3] <= search_3;
            search_reg[4] <= search_4;
            search_reg[5] <= search_5;
            search_reg[6] <= search_6;
            search_reg[7] <= search_7;
            in_valid_reg <= in_valid;
        end
    end

    // Distance calculations
    logic [63:0] dist[7:0];
    logic signed [63:0] diff;

    always_comb begin
        for (int i = 0; i < 8; i++) begin
            dist[i] = '0;
            for (int j = 0; j < 16; j++) begin
                diff = $signed({1'b0, query_reg[j*4 +: 4]}) - $signed({1'b0, search_reg[i][j*4 +: 4]});
                dist[i] += diff * diff;
            end
        end
    end

    // Find first and second smallest distances
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            addr_1st_reg <= 3'b0;
            addr_2nd_reg <= 3'b0;
            out_valid_reg <= 1'b0;
        end else if (in_valid_reg) begin
            logic [63:0] data_addr_1, data_addr_2;
            addr_1st_reg = 3'b0;
            addr_2nd_reg = 3'b0;
            data_addr_1 = dist[0];
            data_addr_2 = {64{1'b1}}; // Initialize to max value

            // Find first smallest
            for (int i = 1; i < 8; i++) begin
                if (dist[i] < data_addr_1) begin
                    addr_1st_reg = i[2:0];
                    data_addr_1 = dist[i];
                end
            end

            // Find second smallest
            for (int i = 0; i < 8; i++) begin
                if (i != addr_1st_reg && dist[i] < data_addr_2) begin
                    addr_2nd_reg = i[2:0];
                    data_addr_2 = dist[i];
                end
            end

            out_valid_reg = 1'b1;
        end else begin
            addr_1st_reg <= 3'b0;
            addr_2nd_reg <= 3'b0;
            out_valid_reg <= 1'b0;
        end
    end

    // Output FF
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            addr_1st <= 3'b0;
            addr_2nd <= 3'b0;
            out_valid <= 1'b0;
        end else begin
            addr_1st <= addr_1st_reg;
            addr_2nd <= addr_2nd_reg;
            out_valid <= out_valid_reg;
        end
    end

endmodule
