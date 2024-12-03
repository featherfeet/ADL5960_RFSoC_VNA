vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_17
vlib questa_lib/msim/zynq_ultra_ps_e_vip_v1_0_17
vlib questa_lib/msim/lib_pkg_v1_0_4
vlib questa_lib/msim/fifo_generator_v13_2_10
vlib questa_lib/msim/lib_fifo_v1_0_19
vlib questa_lib/msim/lib_srl_fifo_v1_0_4
vlib questa_lib/msim/lib_cdc_v1_0_3
vlib questa_lib/msim/axi_datamover_v5_1_33
vlib questa_lib/msim/axi_sg_v4_1_18
vlib questa_lib/msim/axi_dma_v7_1_32
vlib questa_lib/msim/proc_sys_reset_v5_0_15
vlib questa_lib/msim/generic_baseblocks_v2_1_2
vlib questa_lib/msim/axi_register_slice_v2_1_31
vlib questa_lib/msim/axi_data_fifo_v2_1_30
vlib questa_lib/msim/axi_crossbar_v2_1_32
vlib questa_lib/msim/xlconstant_v1_1_9
vlib questa_lib/msim/smartconnect_v1_0
vlib questa_lib/msim/axi_protocol_converter_v2_1_31
vlib questa_lib/msim/axi_clock_converter_v2_1_30
vlib questa_lib/msim/blk_mem_gen_v8_4_8
vlib questa_lib/msim/axi_dwidth_converter_v2_1_31

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 questa_lib/msim/axi_vip_v1_1_17
vmap zynq_ultra_ps_e_vip_v1_0_17 questa_lib/msim/zynq_ultra_ps_e_vip_v1_0_17
vmap lib_pkg_v1_0_4 questa_lib/msim/lib_pkg_v1_0_4
vmap fifo_generator_v13_2_10 questa_lib/msim/fifo_generator_v13_2_10
vmap lib_fifo_v1_0_19 questa_lib/msim/lib_fifo_v1_0_19
vmap lib_srl_fifo_v1_0_4 questa_lib/msim/lib_srl_fifo_v1_0_4
vmap lib_cdc_v1_0_3 questa_lib/msim/lib_cdc_v1_0_3
vmap axi_datamover_v5_1_33 questa_lib/msim/axi_datamover_v5_1_33
vmap axi_sg_v4_1_18 questa_lib/msim/axi_sg_v4_1_18
vmap axi_dma_v7_1_32 questa_lib/msim/axi_dma_v7_1_32
vmap proc_sys_reset_v5_0_15 questa_lib/msim/proc_sys_reset_v5_0_15
vmap generic_baseblocks_v2_1_2 questa_lib/msim/generic_baseblocks_v2_1_2
vmap axi_register_slice_v2_1_31 questa_lib/msim/axi_register_slice_v2_1_31
vmap axi_data_fifo_v2_1_30 questa_lib/msim/axi_data_fifo_v2_1_30
vmap axi_crossbar_v2_1_32 questa_lib/msim/axi_crossbar_v2_1_32
vmap xlconstant_v1_1_9 questa_lib/msim/xlconstant_v1_1_9
vmap smartconnect_v1_0 questa_lib/msim/smartconnect_v1_0
vmap axi_protocol_converter_v2_1_31 questa_lib/msim/axi_protocol_converter_v2_1_31
vmap axi_clock_converter_v2_1_30 questa_lib/msim/axi_clock_converter_v2_1_30
vmap blk_mem_gen_v8_4_8 questa_lib/msim/blk_mem_gen_v8_4_8
vmap axi_dwidth_converter_v2_1_31 questa_lib/msim/axi_dwidth_converter_v2_1_31

vlog -work xilinx_vip -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/tools/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_block.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_por_fsm_top.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_bgt_fsm.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_device_rom.sv" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_por_fsm.sv" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_por_fsm_disabled.sv" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_tile_config.sv" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_constants_config.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_drp_arbiter.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_drp_arbiter_adc.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_register_decode.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_address_decoder.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_axi_lite_ipif.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_counter_f.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_pselect_f.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_slave_attachment.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_rf_wrapper.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_drp_control_top.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_drp_control.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_drp_access_ctrl.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_irq_req_ack.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_irq_sync.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0bufg_gt_ctrl.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_overvol_irq.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_powerup_state_irq.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_mt_sysref_count.sv" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_mt_mrk_count.sv" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_mt_data_align.sv" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_mt_fifo_ctrl.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_rst_cnt.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0_clk_detection.v" \
"../../../bd/design_1/ip/design_1_usp_rf_data_converter_0_0/synth/design_1_usp_rf_data_converter_0_0.v" \

vlog -work axi_infrastructure_v1_1_0 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_17 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work lib_pkg_v1_0_4 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/8c68/hdl/lib_pkg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_10 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/1443/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_10 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/1443/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_10 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/1443/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_19 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/0a12/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_4 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/1e5a/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work lib_cdc_v1_0_3 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_33 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/bf20/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_18 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/6f54/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_32 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/8830/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/design_1/ip/design_1_axi_dma_0_0/sim/design_1_axi_dma_0_0.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \

vcom -work proc_sys_reset_v5_0_15 -64 -93  \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3a26/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/design_1/ip/design_1_rst_ps8_0_99M_0/sim/design_1_rst_ps8_0_99M_0.vhd" \
"../../../bd/design_1/ip/design_1_rst_clk_wiz_0_147M_0/sim/design_1_rst_clk_wiz_0_147M_0.vhd" \

vlog -work generic_baseblocks_v2_1_2 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_31 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/92b2/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_30 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/9692/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_32 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/e9d8/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xbar_1/sim/design_1_xbar_1.v" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/sim/bd_6f02.v" \

vlog -work xlconstant_v1_1_9 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_0/sim/bd_6f02_one_0.v" \

vcom -work xil_defaultlib -64 -93  \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_1/sim/bd_6f02_psr0_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_2/sim/bd_6f02_psr_aclk_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_3/sim/bd_6f02_psr_aclk1_0.vhd" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_4/sim/bd_6f02_arsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_5/sim/bd_6f02_rsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_6/sim/bd_6f02_awsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_7/sim/bd_6f02_wsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_8/sim/bd_6f02_bsw_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/98d8/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_9/sim/bd_6f02_s00mmu_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_10/sim/bd_6f02_s00tr_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a950/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_11/sim/bd_6f02_s00sic_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_12/sim/bd_6f02_s00a2s_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_13/sim/bd_6f02_sawn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_14/sim/bd_6f02_swn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_15/sim/bd_6f02_sbn_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_16/sim/bd_6f02_m00s2a_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_17/sim/bd_6f02_m00awn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_18/sim/bd_6f02_m00wn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_19/sim/bd_6f02_m00bn_0.sv" \

vlog -work smartconnect_v1_0 -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/1f04/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  -sv -L axi_vip_v1_1_17 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/bd_0/ip/ip_20/sim/bd_6f02_m00e_0.sv" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_1/sim/design_1_axi_smc_1.v" \
"../../../bd/design_1/ipshared/b4b8/hdl/adc_combiner.v" \
"../../../bd/design_1/ip/design_1_adc_combiner_0_0/sim/design_1_adc_combiner_0_0.v" \
"../../../bd/design_1/ipshared/b460/hdl/spi_adl_slave_lite_v1_0_S00_AXI.v" \
"../../../bd/design_1/ipshared/b460/hdl/spi_adl.v" \
"../../../bd/design_1/ip/design_1_spi_adl_0_0/sim/design_1_spi_adl_0_0.v" \
"../../../bd/design_1/ip/design_1_spi_control_w_0_0/sim/design_1_spi_control_w_0_0.v" \
"../../../bd/design_1/ip/design_1_spi_adl_1_0/sim/design_1_spi_adl_1_0.v" \
"../../../bd/design_1/ip/design_1_spi_control_w_1_0/sim/design_1_spi_control_w_1_0.v" \
"../../../bd/design_1/ipshared/7b63/hdl/spi_lmx_slave_lite_v1_0_S00_AXI.v" \
"../../../bd/design_1/ipshared/7b63/hdl/spi_lmx.v" \
"../../../bd/design_1/ip/design_1_spi_lmx_0_0/sim/design_1_spi_lmx_0_0.v" \
"../../../bd/design_1/ip/design_1_spi_lmx_control_w_0_0/sim/design_1_spi_lmx_control_w_0_0.v" \

vlog -work axi_protocol_converter_v2_1_31 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3c06/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_clock_converter_v2_1_30 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/80bf/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_8 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/09bd/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_31 -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/14b9/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/a317/hdl" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/3242" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../VNA_Vivado_Project.gen/sources_1/bd/design_1/ipshared/c783/hdl/verilog" "+incdir+/tools/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_auto_ds_0/sim/design_1_auto_ds_0.v" \
"../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \
"../../../bd/design_1/ip/design_1_auto_ds_1/sim/design_1_auto_ds_1.v" \
"../../../bd/design_1/ip/design_1_auto_pc_1/sim/design_1_auto_pc_1.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

