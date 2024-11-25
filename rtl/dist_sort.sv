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

    // Internal signals
    logic [127:0] dist_0, dist_1, dist_2, dist_3, dist_4, dist_5, dist_6, dist_7;
    logic signed [63:0] diff_0, diff_1, diff_2, diff_3, diff_4, diff_5, diff_6, diff_7;
    logic [2:0] sort_addr_1, sort_addr_2;
    logic [63:0] data_addr_1, data_addr_2;



    // Main combinational logic
    always_ff @(posedge clk or posedge rst) begin
        
        /*
        if (rst) begin
            //
        end else begin
            $display("Clock tick, in_valid: %b", in_valid);
        end

        */
        
        
        // Default assignments
        addr_1st= 3'b0;
        addr_2nd = 3'b0;
        out_valid= 1'b0;
        
        if (in_valid) begin
            // do the distance calculations explicitly


            // Reset accumulators
            dist_0 = '0; dist_1 = '0; dist_2 = '0; dist_3 = '0;
            dist_4 = '0; dist_5 = '0; dist_6 = '0; dist_7 = '0;



            // Calculate distances
            for (int i = 0; i < 16; i++) begin
                diff_0 = $signed( query[i*4 +: 4]) - $signed( search_0[i*4 +: 4]);
                diff_1 = $signed( query[i*4 +: 4]) - $signed( search_1[i*4 +: 4]);
                diff_2 = $signed( query[i*4 +: 4]) - $signed( search_2[i*4 +: 4]);
                diff_3 = $signed( query[i*4 +: 4]) - $signed( search_3[i*4 +: 4]);
                diff_4 = $signed( query[i*4 +: 4]) - $signed( search_4[i*4 +: 4]);
                diff_5 = $signed( query[i*4 +: 4]) - $signed( search_5[i*4 +: 4]);
                diff_6 = $signed( query[i*4 +: 4]) - $signed( search_6[i*4 +: 4]);
                diff_7 = $signed( query[i*4 +: 4]) - $signed( search_7[i*4 +: 4]);

                dist_0 = dist_0 + (diff_0 * diff_0);
                dist_1 = dist_1 + (diff_1 * diff_1);
                dist_2 = dist_2 + (diff_2 * diff_2);
                dist_3 = dist_3 + (diff_3 * diff_3);
                dist_4 = dist_4 + (diff_4 * diff_4);
                dist_5 = dist_5 + (diff_5 * diff_5);
                dist_6 = dist_6 + (diff_6 * diff_6);
                dist_7 = dist_7 + (diff_7 * diff_7);
            end
                     
            // Find first smallest distance


            sort_addr_1 = 3'b0;
            data_addr_1 = dist_0;
            
            if (dist_1 < data_addr_1) begin sort_addr_1 = 3'b001; data_addr_1 = dist_1; end
            if (dist_2 < data_addr_1) begin sort_addr_1 = 3'b010; data_addr_1 = dist_2; end
            if (dist_3 < data_addr_1) begin sort_addr_1 = 3'b011; data_addr_1 = dist_3; end
            if (dist_4 < data_addr_1) begin sort_addr_1 = 3'b100; data_addr_1 = dist_4; end
            if (dist_5 < data_addr_1) begin sort_addr_1 = 3'b101; data_addr_1 = dist_5; end
            if (dist_6 < data_addr_1) begin sort_addr_1 = 3'b110; data_addr_1 = dist_6; end
            if (dist_7 < data_addr_1) begin sort_addr_1 = 3'b111; data_addr_1 = dist_7; end

            // Find second smallest distance
            sort_addr_2 = 3'b0;
            data_addr_2 = (sort_addr_1 == 3'b0) ? dist_1 : dist_0;

            if ((dist_1 < data_addr_2) && (sort_addr_1 != 3'b001)) begin sort_addr_2 = 3'b001; data_addr_2 = dist_1; end
            if ((dist_2 < data_addr_2) && (sort_addr_1 != 3'b010)) begin sort_addr_2 = 3'b010; data_addr_2 = dist_2; end
            if ((dist_3 < data_addr_2) && (sort_addr_1 != 3'b011)) begin sort_addr_2 = 3'b011; data_addr_2 = dist_3; end
            if ((dist_4 < data_addr_2) && (sort_addr_1 != 3'b100)) begin sort_addr_2 = 3'b100; data_addr_2 = dist_4; end
            if ((dist_5 < data_addr_2) && (sort_addr_1 != 3'b101)) begin sort_addr_2 = 3'b101; data_addr_2 = dist_5; end
            if ((dist_6 < data_addr_2) && (sort_addr_1 != 3'b110)) begin sort_addr_2 = 3'b110; data_addr_2 = dist_6; end
            if ((dist_7 < data_addr_2) && (sort_addr_1 != 3'b111)) begin sort_addr_2 = 3'b111; data_addr_2 = dist_7; end



            addr_1st = sort_addr_1;
            addr_2nd = sort_addr_2;
            out_valid = 1'b1;
        end
    end

endmodule