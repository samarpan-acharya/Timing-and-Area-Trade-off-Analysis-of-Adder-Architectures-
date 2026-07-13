`timescale 1ns / 1ps

module tb_csa_16bit;

reg [15:0] a, b;
reg cin;

wire [15:0] sum;
wire cout;

reg [16:0] expected;

integer i;

csa_16bit dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin

    a = 0; b = 0; cin = 0;

    #10;

    a = 16'h0000; b = 16'h0000; cin = 0; #10;
    a = 16'h0001; b = 16'h0001; cin = 0; #10;
    a = 16'hFFFF; b = 16'h0001; cin = 0; #10;
    a = 16'hAAAA; b = 16'h5555; cin = 0; #10;
    a = 16'h0FFF; b = 16'h0001; cin = 1; #10;
    a = 16'h8000; b = 16'h8000; cin = 0; #10;
    a = 16'h7FFF; b = 16'h0001; cin = 0; #10;

    for(i=0;i<20;i=i+1) begin
        a = $random;
        b = $random;
        cin = $random;
        #10;

        expected = a + b + cin;

        if({cout,sum} !== expected)
            $display("FAIL : a=%h b=%h cin=%b expected=%h got=%b_%h",
                     a,b,cin,expected,cout,sum);
        else
            $display("PASS : a=%h b=%h cin=%b result=%h",
                     a,b,cin,{cout,sum});
    end

    $finish;

end

endmodule