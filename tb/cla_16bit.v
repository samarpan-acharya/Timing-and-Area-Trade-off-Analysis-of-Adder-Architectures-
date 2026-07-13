module cla_16bit (
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire        cin,
    output wire [15:0] sum,
    output wire        cout
);
    wire carry_mid;

    cla_8bit lower (
        .a   (a[7:0]),
        .b   (b[7:0]),
        .cin (cin),
        .sum (sum[7:0]),
        .cout(carry_mid)
    );

    cla_8bit upper (
        .a   (a[15:8]),
        .b   (b[15:8]),
        .cin (carry_mid),
        .sum (sum[15:8]),
        .cout(cout)
    );
endmodule