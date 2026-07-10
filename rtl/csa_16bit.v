module csa_16bit (
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire        cin,
    output wire [15:0] sum,
    output wire        cout
);

    wire c4, c8, c12;

    wire [3:0] s0;
    wire [4:0] cr0;
    assign cr0[0] = cin;
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : b0
            full_adder f(.a(a[i]),.b(b[i]),.cin(cr0[i]),
                         .sum(s0[i]),.cout(cr0[i+1]));
        end
    endgenerate
    assign sum[3:0] = s0;
    assign c4 = cr0[4];

    wire [3:0] s1_0, s1_1;
    wire [4:0] cr1_0, cr1_1;
    assign cr1_0[0] = 1'b0;
    assign cr1_1[0] = 1'b1;
    generate
        for (i = 0; i < 4; i = i + 1) begin : b1_0
            full_adder f(.a(a[i+4]),.b(b[i+4]),.cin(cr1_0[i]),
                         .sum(s1_0[i]),.cout(cr1_0[i+1]));
        end
        for (i = 0; i < 4; i = i + 1) begin : b1_1
            full_adder f(.a(a[i+4]),.b(b[i+4]),.cin(cr1_1[i]),
                         .sum(s1_1[i]),.cout(cr1_1[i+1]));
        end
    endgenerate
    assign sum[7:4] = c4 ? s1_1  : s1_0;
    assign c8       = c4 ? cr1_1[4] : cr1_0[4];

    wire [3:0] s2_0, s2_1;
    wire [4:0] cr2_0, cr2_1;
    assign cr2_0[0] = 1'b0;
    assign cr2_1[0] = 1'b1;
    generate
        for (i = 0; i < 4; i = i + 1) begin : b2_0
            full_adder f(.a(a[i+8]),.b(b[i+8]),.cin(cr2_0[i]),
                         .sum(s2_0[i]),.cout(cr2_0[i+1]));
        end
        for (i = 0; i < 4; i = i + 1) begin : b2_1
            full_adder f(.a(a[i+8]),.b(b[i+8]),.cin(cr2_1[i]),
                         .sum(s2_1[i]),.cout(cr2_1[i+1]));
        end
    endgenerate
    assign sum[11:8] = c8 ? s2_1  : s2_0;
    assign c12       = c8 ? cr2_1[4] : cr2_0[4];

    wire [3:0] s3_0, s3_1;
    wire [4:0] cr3_0, cr3_1;
    assign cr3_0[0] = 1'b0;
    assign cr3_1[0] = 1'b1;
    generate
        for (i = 0; i < 4; i = i + 1) begin : b3_0
            full_adder f(.a(a[i+12]),.b(b[i+12]),.cin(cr3_0[i]),
                         .sum(s3_0[i]),.cout(cr3_0[i+1]));
        end
        for (i = 0; i < 4; i = i + 1) begin : b3_1
            full_adder f(.a(a[i+12]),.b(b[i+12]),.cin(cr3_1[i]),
                         .sum(s3_1[i]),.cout(cr3_1[i+1]));
        end
    endgenerate
    assign sum[15:12] = c12 ? s3_1  : s3_0;
    assign cout       = c12 ? cr3_1[4] : cr3_0[4];
endmodule