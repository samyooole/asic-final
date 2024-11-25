module dist_sort_simple (
    input logic clk, rst,
    input logic [63:0] query,     // 4-bit per element, 16 dimensions for all vectors
    input logic [63:0] search_0,  // search space: 8 different vectors
    input logic in_valid,         // start distance calc and sort operation
    output logic out_valid        // indicates valid output
);


// Register declarations for input signals
logic [63:0] query_reg;
logic [63:0] search_0_reg;

// Internal signals
logic [31:0] dist_0;
logic signed [31:0] diff_0; // the # of bits you allocate here is pretty crucial because we were seeing a lot of overflow earlier
logic out_valid_comb;

// Input registration
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        query_reg <= 64'b0;
        search_0_reg <= 64'b0;
    end else begin
        query_reg <= query;
        search_0_reg <= search_0;
    end
end

// Main combinational logic
always_comb begin
    // Default assignments
    out_valid_comb = 1'b0;
    
    if (in_valid) begin
        // do the distance calculations explicitly

        // Reset accumulators
        dist_0 = '0;
        // Calculate distances
        for (int i = 0; i < 16; i++) begin

            diff_0 = $signed(query_reg[i*4 +: 4]) - $signed(search_0_reg[i*4 +: 4]);

            dist_0 = dist_0 + (diff_0 * diff_0);
            
        end

        $display(dist_0);

        

        out_valid_comb = 1'b1;

    end

end

// Output registration
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        out_valid <= 1'b0;
    end else begin
        out_valid <= out_valid_comb;
    end
end

endmodule