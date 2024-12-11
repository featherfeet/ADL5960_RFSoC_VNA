module cocotb_iverilog_dump();
initial begin
    $dumpfile("/Users/biancahanly/ADL5960_RFSoC_VNA/test_code/DSP_RTL_Verif/sim/sim_build/DSP_top_level.fst");
    $dumpvars(0, DSP_top_level);
end
endmodule
