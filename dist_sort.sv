module dist_sort (
input logic clk, rst,
input logic [63:0] query, // 4-bit per element, 16 dimensions for all vectors. this is the query vector
input logic [63:0] search_0, // search space: 8 different vectors. find the 2 closest vectors to the query
input logic [63:0] search_1,
input logic [63:0] search_2,
input logic [63:0] search_3,
input logic [63:0] search_4,
input logic [63:0] search_5,
input logic [63:0] search_6,
input logic [63:0] search_7,
input logic in_valid, // only if in_valid is true @ the rising clock edge do we start the distance calc and sort operation 
output logic [2:0] addr_1st, // 3 bit addresses corresponding to the 2 closest search vectors, so one option each out of 0 - 7
output logic [2:0] addr_2nd,
output logic out_valid // if addresses have been successfully calculated, push out 1
);


// Declare the internal variables we will use

logic [15:0] dist_0, dist_1, dist_2, dist_3, dist_4, dist_5, dist_6, dist_7; 
reg [7:0] i;  // Assuming 8 bits is enough for the loop counter
reg unsigned [4:0] diff_0, diff_1, diff_2, diff_3, diff_4, diff_5, diff_6, diff_7;  // One extra bit for sign


// If in_valid is 0, return out_valid = 0, and addr_1st and addr_2nd will be invalid (how to push out a null in verilog?)
// Main flip flop wraparound
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin // if in reset mode, then we hold until the next cycle
        out_valid <= 0;
        addr_1st <= 3'bxxx;
        addr_2nd <= 3'bxxx;
    end else if (!in_valid) begin // if in_valid is not 1, then also just push out out_valid as 0 and null addresses
        out_valid <= 0;
        addr_1st <= 3'bxxx;
        addr_2nd <= 3'bxxx;
    end else begin
        // Begin distance calculation and sorting logic


        // Calculate Euclidean distance between query and search_i

        // Reset accumulator registers
        dist_0 = 0;
        dist_1 = 0;
        dist_2 = 0;
        dist_3 = 0;
        dist_4 = 0;
        dist_5 = 0;
        dist_6 = 0;
        dist_7 = 0;
        
        for (i = 0; i < 16; i = i + 1) begin
            // Calculate differences
            diff_0 = query[i*4 +: 4] - search_0[i*4 +: 4];
            diff_1 = query[i*4 +: 4] - search_1[i*4 +: 4];
            diff_2 = query[i*4 +: 4] - search_2[i*4 +: 4];
            diff_3 = query[i*4 +: 4] - search_3[i*4 +: 4];
            diff_4 = query[i*4 +: 4] - search_4[i*4 +: 4];
            diff_5 = query[i*4 +: 4] - search_5[i*4 +: 4];
            diff_6 = query[i*4 +: 4] - search_6[i*4 +: 4];
            diff_7 = query[i*4 +: 4] - search_7[i*4 +: 4];
            
            // Square differences by multiplication
            dist_0 = dist_0 + (diff_0 * diff_0);
            dist_1 = dist_1 + (diff_1 * diff_1);
            dist_2 = dist_2 + (diff_2 * diff_2);
            dist_3 = dist_3 + (diff_3 * diff_3);
            dist_4 = dist_4 + (diff_4 * diff_4);
            dist_5 = dist_5 + (diff_5 * diff_5);
            dist_6 = dist_6 + (diff_6 * diff_6);
            dist_7 = dist_7 + (diff_7 * diff_7);
        end

        // Sorting (kinda)

        // simple approach: go through one by one, track the lowest. repeat for 2nd lowest

        // since we break ties with the lower address, we go from lowest to highest address, and only accepting substitutions if they are strictly lower than either

        // our trackers for the two lowest 
        logic [2:0] sort_addr_1;
        logic [2:0] sort_addr_2;
        logic [15:0] data_addr_1;
        logic [15:0] data_addr_2;


        // initialize: to begin with, our lowest will be the first address
        sort_addr_1 = 3'b000;
        data_addr_1 = dist_0; 

        if (dist_1 < data_addr_1) begin
            sort_addr_1 = 3'b001;
            data_addr_1 = dist_1;
        end
        if (dist_2 < data_addr_1) begin
            sort_addr_1 = 3'b010;
            data_addr_1 = dist_2;
        end
        if (dist_3 < data_addr_1) begin
            sort_addr_1 = 3'b011;
            data_addr_1 = dist_3;
        end
        if (dist_4 < data_addr_1) begin
            sort_addr_1 = 3'b100;
            data_addr_1 = dist_4;
        end
        if (dist_5 < data_addr_1) begin
            sort_addr_1 = 3'b101;
            data_addr_1 = dist_5;
        end
        if (dist_6 < data_addr_1) begin
            sort_addr_1 = 3'b110;
            data_addr_1 = dist_6;
        end
        if (dist_7 < data_addr_1) begin
            sort_addr_1 = 3'b111;
            data_addr_1 = dist_7;
        end

        // now find the second smallest
        sort_addr_2 = 3'b000;
        data_addr_2 = (sort_addr_1 == 3'b000) ? dist_1 : dist_0;

        if ((dist_1 < data_addr_2) && (sort_addr_1 != 3'b001)) begin
            sort_addr_2 = 3'b001;
            data_addr_2 = dist_1;
        end
        if ((dist_2 < data_addr_2) && (sort_addr_1 != 3'b010)) begin
            sort_addr_2 = 3'b010;
            data_addr_2 = dist_2;
        end
        if ((dist_3 < data_addr_2) && (sort_addr_1 != 3'b011)) begin
            sort_addr_2 = 3'b011;
            data_addr_2 = dist_3;
        end
        if ((dist_4 < data_addr_2) && (sort_addr_1 != 3'b100)) begin
            sort_addr_2 = 3'b100;
            data_addr_2 = dist_4;
        end
        if ((dist_5 < data_addr_2) && (sort_addr_1 != 3'b101)) begin
            sort_addr_2 = 3'b101;
            data_addr_2 = dist_5;
        end
        if ((dist_6 < data_addr_2) && (sort_addr_1 != 3'b110)) begin
            sort_addr_2 = 3'b110;
            data_addr_2 = dist_6;
        end
        if ((dist_7 < data_addr_2) && (sort_addr_1 != 3'b111)) begin
            sort_addr_2 = 3'b111;
            data_addr_2 = dist_7;
        end

        // Assign the final addresses
        addr_1st <= sort_addr_1;
        addr_2nd <= sort_addr_2;
        out_valid <= 1;

    end
    // TODO: improve length of combinational path in the future, maybe using trees
end



endmodule