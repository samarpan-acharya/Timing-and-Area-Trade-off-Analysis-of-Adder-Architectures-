module cla_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire        cin,
    output wire [7:0] sum,
    output wire        cout
);
    wire [7:0] P; 
    wire [7:0] G; 

    assign P = a ^ b;
    assign G = a & b;

    wire [8:0] C;
    assign C[0] = cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0])
                       | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1])
                       | (P[3] & P[2] & P[1] & G[0])
                       | (P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[5] = G[4] | (P[4] & G[3]) | (P[4] & P[3] & G[2])
                       | (P[4] & P[3] & P[2] & G[1])
                       | (P[4] & P[3] & P[2] & P[1] & G[0])
                       | (P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[6] = G[5] | (P[5] & G[4]) | (P[5] & P[4] & G[3])
                       | (P[5] & P[4] & P[3] & G[2])
                       | (P[5] & P[4] & P[3] & P[2] & G[1])
                       | (P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                       | (P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[7] = G[6] | (P[6] & G[5]) | (P[6] & P[5] & G[4])
                       | (P[6] & P[5] & P[4] & G[3])
                       | (P[6] & P[5] & P[4] & P[3] & G[2])
                       | (P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                       | (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                       | (P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);
    assign C[8] = G[7] | (P[7] & G[6]) | (P[7] & P[6] & G[5])
                       | (P[7] & P[6] & P[5] & G[4])
                       | (P[7] & P[6] & P[5] & P[4] & G[3])
                       | (P[7] & P[6] & P[5] & P[4] & P[3] & G[2])
                       | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & G[1])
                       | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & G[0])
                       | (P[7] & P[6] & P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C[0]);

    assign sum  = P ^ C[7:0];
    assign cout = C[8];
endmodule