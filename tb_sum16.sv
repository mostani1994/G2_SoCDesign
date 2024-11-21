module tb_fpsum16;
    // Declare testbench signals
    reg clk;
    reg reset;
    reg pushin;  // Start signal
    reg [175:0] A; // Input A
    reg [175:0] B; // Input B
    wire pushout;  // Done signal
    wire [10:0] Z; // Output result Z

    // Instantiate the DUT (Device Under Test)
    sum16 dut1 (
        .clk(clk), 
        .reset(reset), 
        .pushin(pushin), 
        .A(A), 
        .B(B), 
        .pushout(pushout), 
        .Z(Z)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Toggle clock every 10 time units
    end

    // Reset sequence
    initial begin
        reset = 1;
        #30 reset = 0; // De-assert reset after 30 time units
    end

    // Test stimulus
    initial begin
        // Initialize variables
        A = 176'b0;
        B = 176'b0;
        pushin = 0;

        // Start simulation
        #45;
        pushin = 1; A = 176'h0FFFFFFFFFFFFFFF; B = 176'h0FFFFFFFFFFFFFFF; // Apply first test case
      	#20 
        pushin = 1; A = 176'b0; B = 176'h00; // Apply first test case
      	#20 
        pushin = 1; A = 176'h0FFFFFFFFFFFFFFF; B = 176'h0FFFFFFFFFFFFFFF; // Apply first test case
      	#20 
        pushin = 1; A = 176'h0FFFFFFFFFFFFFFF; B = 176'b0; // Apply first test case
      	#20 
        pushin = 1; A = 176'h0FFFFFFFFFFFFFFF; B = 176'h0FFFFFFFFFFFFFFF; // Apply first test case
        #20 
        pushin = 0; A = 176'h0FFFFFFFFFFFFFFF; B = 176'h0FFFFFFFFFFFFFFF; // Apply first test case
        #1000;

        // End simulation
        $finish;
    end

    // VCD file generation
    initial begin
        $dumpfile("fpsum16.vcd");
        $dumpvars(0, tb_fpsum16); // Dump all variables in the testbench
    end

    // Monitor output
    initial begin
      $monitor("Time: %0t | A: %11h | B: %11h | Pushin: %b | Pushout: %b | Z: %h", 
                 $time, A, B, pushin, pushout, Z);
    end
endmodule
