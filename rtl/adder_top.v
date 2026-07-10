module adder_top (
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire        cin,
    output wire [15:0] sum_out,
    output wire        cout_out
);

    wire [7:0]  rca8_sum;
    wire        rca8_cout;

    wire [15:0] rca16_sum;
    wire        rca16_cout;

    wire [7:0]  cla8_sum;
    wire        cla8_cout;

    wire [15:0] cla16_sum;
    wire        cla16_cout;

    wire [7:0]  csa8_sum;
    wire        csa8_cout;

    wire [15:0] csa16_sum;
    wire        csa16_cout;

    rca_8bit  u_rca8  (.a(a[7:0]), .b(b[7:0]), .cin(cin),
                       .sum(rca8_sum),  .cout(rca8_cout));

    rca_16bit u_rca16 (.a(a), .b(b), .cin(cin),
                       .sum(rca16_sum), .cout(rca16_cout));

    cla_8bit  u_cla8  (.a(a[7:0]), .b(b[7:0]), .cin(cin),
                       .sum(cla8_sum),  .cout(cla8_cout));

    cla_16bit u_cla16 (.a(a), .b(b), .cin(cin),
                       .sum(cla16_sum), .cout(cla16_cout));

    csa_8bit  u_csa8  (.a(a[7:0]), .b(b[7:0]), .cin(cin),
                       .sum(csa8_sum),  .cout(csa8_cout));

    csa_16bit u_csa16 (.a(a), .b(b), .cin(cin),
                       .sum(csa16_sum), .cout(csa16_cout));

    assign sum_out  = rca8_sum  | rca16_sum[7:0]  |
                      cla8_sum  | cla16_sum[7:0]  |
                      csa8_sum  | csa16_sum[7:0]  |
                      rca16_sum[15:8] | cla16_sum[15:8] |
                      csa16_sum[15:8];

    assign cout_out = rca8_cout | rca16_cout |
                      cla8_cout | cla16_cout |
                      csa8_cout | csa16_cout;

endmodule