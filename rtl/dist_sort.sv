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

    logic [63:0] query_reg, search_0_reg, search_1_reg, search_2_reg, search_3_reg;
    logic [63:0] search_4_reg, search_5_reg, search_6_reg, search_7_reg;
    logic in_valid_reg;

    logic [2:0] addr_1st_reg, addr_2nd_reg;
    logic out_valid_reg;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            query_reg <= '0;
            search_0_reg <= '0;
            search_1_reg <= '0;
            search_2_reg <= '0;
            search_3_reg <= '0;
            search_4_reg <= '0;
            search_5_reg <= '0;
            search_6_reg <= '0;
            search_7_reg <= '0;
            in_valid_reg <= 1'b0;
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
            in_valid_reg <= in_valid;
        end
    end

    // Register declarations for input signals
    logic [63:0] dist_0, dist_1, dist_2, dist_3, dist_4, dist_5, dist_6, dist_7;
    logic signed [63:0] diff_0, diff_1, diff_2, diff_3, diff_4, diff_5, diff_6, diff_7;
    //logic [2:0] sort_addr_1, sort_addr_2;
    //logic [63:0] data_addr_1, data_addr_2;



    // Main combinational logic
    always_comb @(posedge clk or posedge rst) begin

        if (rst) begin 
            // Default assignments
            addr_1st_reg= 3'b0;
            addr_2nd_reg = 3'b0;
            out_valid_reg= 1'b0;
        

        end else if (in_valid_reg) begin
            // do the distance calculations explicitly

            // Reset accumulators
            dist_0 = '0; dist_1 = '0; dist_2 = '0; dist_3 = '0;
            dist_4 = '0; dist_5 = '0; dist_6 = '0; dist_7 = '0;


            // Calculate distances
            for (int i = 0; i < 16; i++) begin
                diff_0 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_0_reg[i*4 +: 4]});
                diff_1 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_1_reg[i*4 +: 4]});
                diff_2 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_2_reg[i*4 +: 4]});
                diff_3 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_3_reg[i*4 +: 4]});
                diff_4 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_4_reg[i*4 +: 4]});
                diff_5 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_5_reg[i*4 +: 4]});
                diff_6 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_6_reg[i*4 +: 4]});
                diff_7 = $signed({1'b0, query_reg[i*4 +: 4]}) - $signed({1'b0, search_7_reg[i*4 +: 4]});

                dist_0 = dist_0 + (diff_0 * diff_0);
                dist_1 = dist_1 + (diff_1 * diff_1);
                dist_2 = dist_2 + (diff_2 * diff_2);
                dist_3 = dist_3 + (diff_3 * diff_3);
                dist_4 = dist_4 + (diff_4 * diff_4);
                dist_5 = dist_5 + (diff_5 * diff_5);
                dist_6 = dist_6 + (diff_6 * diff_6);
                dist_7 = dist_7 + (diff_7 * diff_7);
            end
                     
            

            //sortinglogic
            logic [63:0] smallest_dist, second_smallest_dist;
            logic [2:0] smallest_addr, second_smallest_addr;

            smallest_dist = dist_0;
            smallest_addr = 3'b000;

            // Find the smallest distance
            if (dist_1 < smallest_dist) begin smallest_dist = dist_1; smallest_addr = 3'b001; end
            if (dist_2 < smallest_dist) begin smallest_dist = dist_2; smallest_addr = 3'b010; end
            if (dist_3 < smallest_dist) begin smallest_dist = dist_3; smallest_addr = 3'b011; end
            if (dist_4 < smallest_dist) begin smallest_dist = dist_4; smallest_addr = 3'b100; end
            if (dist_5 < smallest_dist) begin smallest_dist = dist_5; smallest_addr = 3'b101; end
            if (dist_6 < smallest_dist) begin smallest_dist = dist_6; smallest_addr = 3'b110; end
            if (dist_7 < smallest_dist) begin smallest_dist = dist_7; smallest_addr = 3'b111; end

            // Find the second smallest distance
            second_smallest_dist = (smallest_addr == 3'b000) ? dist_1 : dist_0;
            second_smallest_addr = (smallest_addr == 3'b000) ? 3'b001 : 3'b000;

            for (int j = 0; j < 8; j++) begin
                logic [63:0] current_dist;
                logic [2:0] current_addr;

                case (j)
                    0: begin current_dist = dist_0; current_addr = 3'b000; end
                    1: begin current_dist = dist_1; current_addr = 3'b001; end
                    2: begin current_dist = dist_2; current_addr = 3'b010; end
                    3: begin current_dist = dist_3; current_addr = 3'b011; end
                    4: begin current_dist = dist_4; current_addr = 3'b100; end
                    5: begin current_dist = dist_5; current_addr = 3'b101; end
                    6: begin current_dist = dist_6; current_addr = 3'b110; end
                    7: begin current_dist = dist_7; current_addr = 3'b111; end
                endcase

                if ((current_dist < second_smallest_dist) && (current_addr != smallest_addr)) begin
                    second_smallest_dist = current_dist;
                    second_smallest_addr = current_addr;
                end
            end


            if (smallest_addr == 3'b0 && (second_smallest_addr == 3'b0)) begin second_smallest_addr = 3'b001; end 
            // if everything is equal then we just put it as the first and second addresses

            addr_1st_reg = smallest_addr;
            addr_2nd_reg = second_smallest_addr;
            out_valid_reg = 1'b1;

        end else begin
            // Default assignments
            addr_1st_reg= 3'b0;
            addr_2nd_reg = 3'b0;
            out_valid_reg= 1'b0;
        end

    end

    //Output FF
    

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