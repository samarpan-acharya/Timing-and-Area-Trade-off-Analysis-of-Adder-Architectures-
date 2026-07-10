module csa_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire        cin,
    output wire [7:0] sum,
    output wire        cout
);

    wire [3:0] sum_low;
    wire        cout_low;

    wire [4:0] carry_low;
    assign carry_low[0] = cin;

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : fa_low
            full_adder fa_inst (
                .a   (a[i]),
                .b   (b[i]),
                .cin (carry_low[i]),
                .sum (sum_low[i]),
                .cout(carry_low[i+1])
            );
        end
    endgenerate

    assign cout_low = carry_low[4];

    wire [3:0] sum_high_0;
    wire        cout_high_0;
    wire [4:0] carry_high_0;
    assign carry_high_0[0] = 1'b0;

    generate
        for (i = 0; i < 4; i = i + 1) begin : fa_high_0
            full_adder fa_inst (
                .a   (a[i+4]),
                .b   (b[i+4]),
                .cin (carry_high_0[i]),
                .sum (sum_high_0[i]),
                .cout(carry_high_0[i+1])
            );
        end
    endgenerate

    assign cout_high_0 = carry_high_0[4];

    wire [3:0] sum_high_1;
    wire        cout_high_1;
    wire [4:0] carry_high_1;
    assign carry_high_1[0] = 1'b1;

    generate
        for (i = 0; i < 4; i = i + 1) begin : fa_high_1
            full_adder fa_inst (
                .a   (a[i+4]),
                .b   (b[i+4]),
                .cin (carry_high_1[i]),
                .sum (sum_high_1[i]),
                .cout(carry_high_1[i+1])
            );
        end
    endgenerate

    assign cout_high_1 = carry_high_1[4];

    assign sum[3:0]  = sum_low;
    assign sum[7:4]  = cout_low ? sum_high_1  : sum_high_0;
    assign cout      = cout_low ? cout_high_1 : cout_high_0;
endmodule