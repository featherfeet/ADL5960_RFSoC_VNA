module cocotb_iverilog_dump();
initial begin
    $dumpfile("/home/alyssa/6.s965/final_project/sim/sim_build/cordic.fst");
    $dumpvars(0, cordic);
end
endmodule
