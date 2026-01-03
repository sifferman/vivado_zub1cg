
set project_name [lindex $argv 0]
set bd_tcl_filename [lindex $argv 1]

# start_gui

xhub::get_xstores
xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]
set_param board.repoPaths [get_property LOCAL_ROOT_DIR [xhub::get_xstores xilinx_board_store]]

xhub::install [xhub::get_xitems avnet.com:xilinx_board_store:ZUBoard_1CG:1.0]
xhub::update [xhub::get_xitems avnet.com:xilinx_board_store:ZUBoard_1CG:1.0]

set board_part [get_board_parts avnet.com:zuboard_1cg:part0:1.0* -latest_file_version]

create_project zub1cg ./$project_name -part [get_property PART_NAME [get_board_parts $board_part]]
set_property board_part $board_part [current_project]

# add_files -norecurse {}
# set_property file_type {Memory File} [get_files -all]

# Alex Forencich Ethernet IP
add_files -norecurse {
    ../third_party/alexforencich_ethernet/rtl/eth_mac_1g_rgmii_fifo.v
    ../third_party/alexforencich_ethernet/rtl/eth_mac_1g_rgmii.v
    ../third_party/alexforencich_ethernet/rtl/rgmii_phy_if.v
    ../third_party/alexforencich_ethernet/rtl/ssio_ddr_in.v
    ../third_party/alexforencich_ethernet/rtl/iddr.v
    ../third_party/alexforencich_ethernet/rtl/oddr.v
    ../third_party/alexforencich_ethernet/rtl/eth_mac_1g.v
    ../third_party/alexforencich_ethernet/rtl/axis_gmii_rx.v
    ../third_party/alexforencich_ethernet/rtl/axis_gmii_tx.v
    ../third_party/alexforencich_ethernet/rtl/lfsr.v
    ../third_party/alexforencich_ethernet/lib/axis/rtl/axis_async_fifo_adapter.v
    ../third_party/alexforencich_ethernet/lib/axis/rtl/axis_adapter.v
    ../third_party/alexforencich_ethernet/lib/axis/rtl/axis_async_fifo.v
}

# add_files -fileset constrs_1 -norecurse {}
# set_property PROCESSING_ORDER EARLY [get_files -of_objects [get_filesets constrs_1]]

create_bd_design "design_1"
source ../$bd_tcl_filename
save_bd_design
make_wrapper -files [get_files $project_name/zub1cg.srcs/sources_1/bd/design_1/design_1.bd] -top -import
set_property top design_1_wrapper [current_fileset]

set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]
set_property STEPS.SYNTH_DESIGN.ARGS.DIRECTIVE PerformanceOptimized [get_runs synth_1]
launch_runs synth_1 -jobs [exec nproc]
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs [exec nproc]
wait_on_run impl_1

exit
