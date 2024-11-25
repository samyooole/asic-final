module dist_sort_simple_tb;
    parameter CLK_PERIOD = 10;

    reg clk; 
    reg rst;
    reg [63:0] query;
    reg [63:0] search_0;
    reg in_valid;

    wire out_valid;
    
    // instantiate module

    dist_sort_simple uut (
        .clk(clk),
        .rst(rst),
        .query(query),
        .search_0(search_0),
        .in_valid(in_valid),
        .out_valid(out_valid)
    );

    // clock gen

    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // reset system

     // test sequence
    initial begin
        // Initialize signals
        rst = 1;
        in_valid = 0;
        query = 64'b0;
        search_0 = 64'b0;

        // Release reset
        #(CLK_PERIOD);
        rst = 0;

        // Test case 1: All zeros
        query = 64'h0000000000000000;
        search_0 = 64'h0000000000000000;
        in_valid = 1;
        #(CLK_PERIOD);
        in_valid = 0;

        // Test case 2: Different vectors
        #(CLK_PERIOD * 2);
        query = 64'hddabaaef1c450b1;
        search_0 = 64'h11223344556677;
        in_valid = 1;
        #(CLK_PERIOD);
        in_valid = 0;

        // Add more test cases as needed

        // Finish simulation
        #(CLK_PERIOD * 5);
        $finish;
    end

     

endmodule
