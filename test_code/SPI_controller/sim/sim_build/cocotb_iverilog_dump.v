module cocotb_iverilog_dump();
initial begin
    $dumpfile("/Users/biancahanly/Documents/_MIT_/Classes/_24Fall_/6.S965/Project/sim/sim_build/spi_control.fst");
    $dumpvars(0, spi_control);
end
endmodule
