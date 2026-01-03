
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
# Ethernet MAC
##############

create_bd_cell -type module -reference eth_mac_1g_rgmii_fifo eth_mac_0

set_property -dict [list \
    CONFIG.TARGET {XILINX} \
    CONFIG.IODDR_STYLE {IODDR} \
    CONFIG.CLOCK_INPUT_STYLE {BUFG} \
    CONFIG.USE_CLK90 {TRUE} \
] [get_bd_cells eth_mac_0]

set_property CONFIG.ASSOCIATED_BUSIF {tx_axis:rx_axis} [get_bd_pins eth_mac_0/logic_clk]

##############
# Config Constants
##############

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_ifg
set_property -dict [list CONFIG.CONST_WIDTH {8} CONFIG.CONST_VAL {12}] [get_bd_cells const_ifg]
connect_bd_net [get_bd_pins const_ifg/dout] [get_bd_pins eth_mac_0/cfg_ifg]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_0
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells const_0]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 const_1
set_property -dict [list CONFIG.CONST_VAL {1}] [get_bd_cells const_1]
connect_bd_net [get_bd_pins const_1/dout] [get_bd_pins eth_mac_0/cfg_tx_enable]
connect_bd_net [get_bd_pins const_1/dout] [get_bd_pins eth_mac_0/cfg_rx_enable]

##############
# Clocks
##############

connect_bd_net [get_bd_pins zynq_ultra_ps_e_0/pl_clk0] \
               [get_bd_pins eth_mac_0/gtx_clk] \
               [get_bd_pins eth_mac_0/gtx_clk90] \
               [get_bd_pins eth_mac_0/logic_clk]

connect_bd_net [get_bd_pins const_0/dout] \
               [get_bd_pins eth_mac_0/gtx_rst] \
               [get_bd_pins eth_mac_0/logic_rst]

##############
# RGMII Loopback
##############

# Loopback
connect_bd_intf_net [get_bd_intf_pins eth_mac_0/rx_axis] [get_bd_intf_pins eth_mac_0/tx_axis]

# Connect RX clock to TX clock for internal loopback
connect_bd_net [get_bd_pins eth_mac_0/rgmii_tx_clk] [get_bd_pins eth_mac_0/rgmii_rx_clk]

# Tie off RX data and control signals (not used in AXI Stream loopback mode)
connect_bd_net [get_bd_pins const_0/dout] [get_bd_pins eth_mac_0/rgmii_rxd]
connect_bd_net [get_bd_pins const_0/dout] [get_bd_pins eth_mac_0/rgmii_rx_ctl]
