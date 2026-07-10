# Timing-and-Area-Trade-off-Analysis-of-Adder-Architectures-
Implementation and comparative analysis of Ripple Carry, Carry Lookahead, and Carry Select adders using synthesizable Verilog RTL with logic synthesis and Static Timing Analysis (STA).
## Architecture

```text
                          16-Bit Carry Select Adder (CSA) Topology
                        ===========================================

                          [A_in(15:8)]            [B_in(15:8)]
                               |                       |
            +------------------+-----------------------+------------------+
            |                                                             |
            v                                                             v
  +-------------------+                                         +-------------------+
  |  8-Bit RCA Pair   |                                         |  8-Bit RCA Pair   |
  |  (Assuming C=0)   |                                         |  (Assuming C=1)   |
  +-------------------+                                         +-------------------+
    |               |                                             |               |
    v [Sum_c0(7:0)] v [C_out_c0]                                  v [Sum_c1(7:0)] v [C_out_c1]
    |               |                                             |               |
    |               +-------------------+   +---------------------+               |
    |                                   |   |                                     |
    |                                   v   v                                     |
    |                               +-----------+                                 |
    |                               |  2:1 MUX  |                                 |
    |                               +-----------+                                 |
    |                                     |                                       |
    |                                     v [C_out_upper]                         |
    v                                     |                                       v
+-------+                             +-------+                               +-------+
|  2:1  |                             |  2:1  |                               |  2:1  |
|  MUX  |                             |  MUX  |                               |  MUX  |
+-------+                             +-------+                               +-------+
    ^                                     ^                                       ^
    |_____________________   _____________|_______________________________________|
                          |  |
                          |  | [C_out_lower]
                        +------+
                        | 8-Bit| <-- [A_in(7:0)]
                        | RCA  | <-- [B_in(7:0)]
                        +------+
                           |
                           v [Sum_out(7:0)]
                           |
                           +----------------------[C_in]

  ===================================================================================
  Primary Ports:
    - A_in [15:0], B_in [15:0] : 16-bit operand inputs
    - C_in                     : Carry input to the lower 8-bit block
    - Sum_out [15:0]           : 16-bit synchronized addition result
    - C_out                    : Final scalar overflow carry out
  ===================================================================================
