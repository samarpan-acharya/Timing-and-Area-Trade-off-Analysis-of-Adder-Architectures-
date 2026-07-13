`timescale 1ns / 1ps

module tb_cla_8bit;

reg [7:0] a, b;
reg cin;

wire [7:0] sum;
wire cout;

reg [8:0] expected;

integer i;

cla_8bit dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin

    a = 0; b = 0; cin = 0;

    #10;

    a = 8'h00; b = 8'h00; cin = 0; #10;
    a = 8'h01; b = 8'h01; cin = 0; #10;
    a = 8'hFF; b = 8'h01; cin = 0; #10;
    a = 8'hAA; b = 8'h55; cin = 0; #10;
    a = 8'h0F; b = 8'h01; cin = 1; #10;
    a = 8'h80; b = 8'h80; cin = 0; #10;
    a = 8'h7F; b = 8'h01; cin = 0; #10;

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