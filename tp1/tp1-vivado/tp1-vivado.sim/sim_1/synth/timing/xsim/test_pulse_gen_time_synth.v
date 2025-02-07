// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
// Date        : Thu Jan 30 17:36:11 2025
// Host        : secil3.siame.univ-tlse3.fr running 64-bit Fedora Linux 40 (Forty)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               /nfs/home/m1info2/Documents/vhdl/tp1/tp1-vivado/tp1-vivado.sim/sim_1/synth/timing/xsim/test_pulse_gen_time_synth.v
// Design      : pulse_gen
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* MAX_CPT = "8" *) 
(* NotValidForBitStream *)
module pulse_gen
   (RST,
    MCLK,
    P);
  input RST;
  input MCLK;
  output P;

  wire MCLK;
  wire MCLK_IBUF;
  wire MCLK_IBUF_BUFG;
  wire P;
  wire P_OBUF;
  wire P_i_1_n_0;
  wire P_i_2_n_0;
  wire RST;
  wire RST_IBUF;
  wire [2:0]cpt;
  wire \ppulse.cpt[0]_i_1_n_0 ;
  wire \ppulse.cpt[1]_i_1_n_0 ;
  wire \ppulse.cpt[2]_i_1_n_0 ;

initial begin
 $sdf_annotate("test_pulse_gen_time_synth.sdf",,,,"tool_control");
end
  BUFG MCLK_IBUF_BUFG_inst
       (.I(MCLK_IBUF),
        .O(MCLK_IBUF_BUFG));
  IBUF MCLK_IBUF_inst
       (.I(MCLK),
        .O(MCLK_IBUF));
  OBUF P_OBUF_inst
       (.I(P_OBUF),
        .O(P));
  LUT1 #(
    .INIT(2'h1)) 
    P_i_1
       (.I0(RST_IBUF),
        .O(P_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    P_i_2
       (.I0(cpt[2]),
        .I1(cpt[0]),
        .I2(cpt[1]),
        .O(P_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    P_reg
       (.C(MCLK_IBUF_BUFG),
        .CE(1'b1),
        .D(P_i_2_n_0),
        .Q(P_OBUF),
        .R(P_i_1_n_0));
  IBUF RST_IBUF_inst
       (.I(RST),
        .O(RST_IBUF));
  LUT2 #(
    .INIT(4'h2)) 
    \ppulse.cpt[0]_i_1 
       (.I0(RST_IBUF),
        .I1(cpt[0]),
        .O(\ppulse.cpt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h28)) 
    \ppulse.cpt[1]_i_1 
       (.I0(RST_IBUF),
        .I1(cpt[1]),
        .I2(cpt[0]),
        .O(\ppulse.cpt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h2A80)) 
    \ppulse.cpt[2]_i_1 
       (.I0(RST_IBUF),
        .I1(cpt[1]),
        .I2(cpt[0]),
        .I3(cpt[2]),
        .O(\ppulse.cpt[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ppulse.cpt_reg[0] 
       (.C(MCLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\ppulse.cpt[0]_i_1_n_0 ),
        .Q(cpt[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ppulse.cpt_reg[1] 
       (.C(MCLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\ppulse.cpt[1]_i_1_n_0 ),
        .Q(cpt[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \ppulse.cpt_reg[2] 
       (.C(MCLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\ppulse.cpt[2]_i_1_n_0 ),
        .Q(cpt[2]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
