`timescale 1ns / 1ps
module tb_spst;
    reg clk = 0;
    reg rst_n = 0;
    reg start = 0;
    reg [15:0] A;
    reg [15:0] B;
    wire done;
    wire [31:0] result;

    // instantiate your module (file: SPSTMAC.v)
    SPSTMAC dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .A(A),
        .B(B),
        .done(done),
        .result(result)
    );

    // clock: 10 ns period
    always #5 clk = ~clk;

    initial begin
        // waveform dump for GTKWave (useful in Icarus)
        $dumpfile("tb_spst.vcd");
        $dumpvars(0, tb_spst);

        // reset
        rst_n = 0;
        #12;
        rst_n = 1;
        #10;

        // TEST VECTOR 1
        A = 16'd12; B = 16'd5; // expected result = 60
        #10; start = 1; #10; start = 0;
        wait(done); #10;
        $display("TV1: A=%0d B=%0d result=%0d", A, B, result);

        // short gap
        #30;

        // TEST VECTOR 2
        A = 16'd18; B = 16'd4; // expected result = 72
        #10; start = 1; #10; start = 0;
        wait(done); #10;
        $display("TV2: A=%0d B=%0d result=%0d", A, B, result);

        // short gap
        #30;

        // TEST VECTOR 3
        A = 16'd123; B = 16'd45; // expected result = 5535
        #10; start = 1; #10; start = 0;
        wait(done); #10;
        $display("TV3: A=%0d B=%0d result=%0d", A, B, result);

        #100;
        $finish;
    end
endmodule
