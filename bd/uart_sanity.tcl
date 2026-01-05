
##############
# PL IO ports
##############

# RX input
create_bd_port -dir I HD_CLICK_RX_1V8

# TX output
create_bd_port -dir O HD_CLICK_TX_1V8

##############
# Direct wire-through
##############

connect_bd_net [get_bd_ports HD_CLICK_RX_1V8] [get_bd_ports HD_CLICK_TX_1V8]
