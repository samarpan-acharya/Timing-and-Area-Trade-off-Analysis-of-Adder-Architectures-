`timescale 1ns/1ps

module tb_adder_top;

    reg  [15:0] a, b;
    reg          cin;

    wire [7:0]  rca8_sum;  wire rca8_cout;
    wire [15:0] rca16_sum; wire rca16_cout;

    wire [7:0]  cla8_sum;  wire cla8_cout;
    wire [15:0] cla16_sum; wire cla16_cout;

    wire [7:0]  csa8_sum;  wire csa8_cout;
    wire [15:0] csa16_sum; wire csa16_cout;

    integer pass_rca8,  fail_rca8;
    integer pass_rca16, fail_rca16;
    integer pass_cla8,  fail_cla8;
    integer pass_cla16, fail_cla16;
    integer pass_csa8,  fail_csa8;
    integer pass_csa16, fail_csa16;
    integer i;

    reg [8:0]  exp8;
    reg [16:0] exp16;

    rca_8bit  u_rca8  (.a(a[7:0]),.b(b[7:0]),.cin(cin),
                       .sum(rca8_sum),.cout(rca8_cout));
    rca_16bit u_rca16 (.a(a),.b(b),.cin(cin),
                       .sum(rca16_sum),.cout(rca16_cout));
    cla_8bit  u_cla8  (.a(a[7:0]),.b(b[7:0]),.cin(cin),
                       .sum(cla8_sum),.cout(cla8_cout));
    cla_16bit u_cla16 (.a(a),.b(b),.cin(cin),
                       .sum(cla16_sum),.cout(cla16_cout));
    csa_8bit  u_csa8  (.a(a[7:0]),.b(b[7:0]),.cin(cin),
                       .sum(csa8_sum),.cout(csa8_cout));
    csa_16bit u_csa16 (.a(a),.b(b),.cin(cin),
                       .sum(csa16_sum),.cout(csa16_cout));

    task check8;
        input [7:0]  got_sum;
        input        got_cout;
        input [7:0]  a_val, b_val;
        input        cin_val;
        input [127:0] name;
        inout integer pass_c, fail_c;
        begin
            exp8 = {1'b0,a_val} + {1'b0,b_val} + {8'b0,cin_val};
            if ({got_cout,got_sum} === exp8) begin
                pass_c = pass_c + 1;
            end else begin
                $display("FAIL [%0s]: %0d+%0d+%0b got={%0b,%0d} exp={%0b,%0d}",
                         name,a_val,b_val,cin_val,
                         got_cout,got_sum,exp8[8],exp8[7:0]);
                fail_c = fail_c + 1;
            end
        end
    endtask

    task check16;
        input [15:0] got_sum;
        input        got_cout;
        input [15:0] a_val, b_val;
        input        cin_val;
        input [127:0] name;
        inout integer pass_c, fail_c;
        begin
            exp16 = {1'b0,a_val} + {1'b0,b_val} + {16'b0,cin_val};
            if ({got_cout,got_sum} === exp16) begin
                pass_c = pass_c + 1;
            end else begin
                $display("FAIL [%0s]: got={%0b,%0d} exp={%0b,%0d}",
                         name,got_cout,got_sum,exp16[16],exp16[15:0]);
                fail_c = fail_c + 1;
            end
        end
    endtask

    initial begin
        pass_rca8=0; fail_rca8=0;
        pass_rca16=0; fail_rca16=0;
        pass_cla8=0; fail_cla8=0;
        pass_cla16=0; fail_cla16=0;
        pass_csa8=0; fail_csa8=0;
        pass_csa16=0; fail_csa16=0;
        a=0; b=0; cin=0;

        $display("============================================");
        $display("  All Adder Architectures Testbench        ");
        $display("============================================");

        $display("\n--- Boundary Tests ---");

        a=0; b=0; cin=0; #10;
        check8 (rca8_sum, rca8_cout,   a[7:0],b[7:0],cin,"RCA8", pass_rca8, fail_rca8);
        check8 (cla8_sum, cla8_cout,   a[7:0],b[7:0],cin,"CLA8", pass_cla8, fail_cla8);
        check8 (csa8_sum, csa8_cout,   a[7:0],b[7:0],cin,"CSA8", pass_csa8, fail_csa8);
        check16(rca16_sum,rca16_cout,  a,b,cin,"RCA16",pass_rca16,fail_rca16);
        check16(cla16_sum,cla16_cout,  a,b,cin,"CLA16",pass_cla16,fail_cla16);
        check16(csa16_sum,csa16_cout,  a,b,cin,"CSA16",pass_csa16,fail_csa16);

        a=8'hFF; b=8'h01; cin=0; #10;
        check8(rca8_sum,rca8_cout,a[7:0],b[7:0],cin,"RCA8_OVF",pass_rca8,fail_rca8);
        check8(cla8_sum,cla8_cout,a[7:0],b[7:0],cin,"CLA8_OVF",pass_cla8,fail_cla8);
        check8(csa8_sum,csa8_cout,a[7:0],b[7:0],cin,"CSA8_OVF",pass_csa8,fail_csa8);

        a=16'hFFFF; b=16'h0001; cin=0; #10;
        check16(rca16_sum,rca16_cout,a,b,cin,"RCA16_OVF",pass_rca16,fail_rca16);
        check16(cla16_sum,cla16_cout,a,b,cin,"CLA16_OVF",pass_cla16,fail_cla16);
        check16(csa16_sum,csa16_cout,a,b,cin,"CSA16_OVF",pass_csa16,fail_csa16);

        a=8'hAA; b=8'h55; cin=0; #10;
        check8(rca8_sum,rca8_cout,a[7:0],b[7:0],cin,"RCA8_ALT",pass_rca8,fail_rca8);
        check8(cla8_sum,cla8_cout,a[7:0],b[7:0],cin,"CLA8_ALT",pass_cla8,fail_cla8);
        check8(csa8_sum,csa8_cout,a[7:0],b[7:0],cin,"CSA8_ALT",pass_csa8,fail_csa8);

        a=8'hFF; b=8'hFF; cin=1; #10;
        check8(rca8_sum,rca8_cout,a[7:0],b[7:0],cin,"RCA8_CIN",pass_rca8,fail_rca8);
        check8(cla8_sum,cla8_cout,a[7:0],b[7:0],cin,"CLA8_CIN",pass_cla8,fail_cla8);
        check8(csa8_sum,csa8_cout,a[7:0],b[7:0],cin,"CSA8_CIN",pass_csa8,fail_csa8);

        $display("\n--- Random Tests (500 vectors each) ---");
        for (i = 0; i < 500; i = i + 1) begin
            a   = $random;
            b   = $random;
            cin = $random & 1;
            #10;
            check8 (rca8_sum, rca8_cout,  a[7:0],b[7:0],cin,"RCA8_R", pass_rca8, fail_rca8);
            check8 (cla8_sum, cla8_cout,  a[7:0],b[7:0],cin,"CLA8_R", pass_cla8, fail_cla8);
            check8 (csa8_sum, csa8_cout,  a[7:0],b[7:0],cin,"CSA8_R", pass_csa8, fail_csa8);
            check16(rca16_sum,rca16_cout, a,b,cin,"RCA16_R",pass_rca16,fail_rca16);
            check16(cla16_sum,cla16_cout, a,b,cin,"CLA16_R",pass_cla16,fail_cla16);
            check16(csa16_sum,csa16_cout, a,b,cin,"CSA16_R",pass_csa16,fail_csa16);
        end

        $display("\n============================================");
        $display("  Results Summary");
        $display("============================================");
        $display("  RCA  8-bit : PASS=%0d FAIL=%0d", pass_rca8,  fail_rca8);
        $display("  RCA 16-bit : PASS=%0d FAIL=%0d", pass_rca16, fail_rca16);
        $display("  CLA  8-bit : PASS=%0d FAIL=%0d", pass_cla8,  fail_cla8);
        $display("  CLA 16-bit : PASS=%0d FAIL=%0d", pass_cla16, fail_cla16);
        $display("  CSA  8-bit : PASS=%0d FAIL=%0d", pass_csa8,  fail_csa8);
        $display("  CSA 16-bit : PASS=%0d FAIL=%0d", pass_csa16, fail_csa16);
        $display("============================================");

        if (fail_rca8+fail_rca16+fail_cla8+
            fail_cla16+fail_csa8+fail_csa16 == 0)
            $display("  ALL ADDERS PASSED — FUNCTIONALLY CORRECT");
        else
            $display("  FAILURES DETECTED — CHECK RTL");

        $finish;
    end

    initial begin #200000; $display("TIMEOUT"); $finish; end

endmodule