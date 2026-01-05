
##############
# Zynq PS
##############

create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.5 zynq_ultra_ps_e_0
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1"} [get_bd_cells zynq_ultra_ps_e_0]

set_property -dict [list \
    CONFIG.PSU__USE__M_AXI_GP0 {0} \
    CONFIG.PSU__USE__M_AXI_GP1 {0} \
    CONFIG.PSU__USE__M_AXI_GP2 {0} \
] [get_bd_cells zynq_ultra_ps_e_0]

##############
# RTL Blinky
##############

create_bd_cell -type module -reference blinky blinky

set_property -dict [list \
    CONFIG.clk_freq_hz {100000000} \
] [get_bd_cells blinky]

create_bd_port -dir O HD_GPIO_RGB1_R
connect_bd_net [get_bd_pins blinky/q] [get_bd_ports HD_GPIO_RGB1_R]

##############
# Clock connection
##############

connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] [get_bd_pins blinky/clk]
