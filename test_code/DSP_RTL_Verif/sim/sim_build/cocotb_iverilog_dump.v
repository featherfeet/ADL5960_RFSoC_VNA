module cocotb_iverilog_dump();
initial begin
    $dumpfile("/home/alyssa/6.s965/final_project/sim/sim_build/compute_coeff_averaging.fst");
    $dumpvars(0, compute_coeff_averaging);
end
endmodule
