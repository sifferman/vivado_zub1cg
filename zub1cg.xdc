# Pin constraints for ZUBoard 1CG
# Based on "ZUBoard 1CG Schematic" from https://www.tria-technologies.com/product/zuboard-1cg/


# Click Connector UART
set_property PACKAGE_PIN D7 [get_ports HD_CLICK_RX_1V8]
set_property IOSTANDARD LVCMOS18 [get_ports HD_CLICK_RX_1V8]

set_property PACKAGE_PIN D6 [get_ports HD_CLICK_TX_1V8]
set_property IOSTANDARD LVCMOS18 [get_ports HD_CLICK_TX_1V8]

# Input delay for UART RX
set_input_delay -clock [get_clocks -of_objects [get_pins */zynq_ultra_ps_e_0/pl_clk0]] \
    -max 3.0 [get_ports HD_CLICK_RX_1V8]
set_input_delay -clock [get_clocks -of_objects [get_pins */zynq_ultra_ps_e_0/pl_clk0]] \
    -min 0.5 [get_ports HD_CLICK_RX_1V8]

# Output delay for UART TX
set_output_delay -clock [get_clocks -of_objects [get_pins */zynq_ultra_ps_e_0/pl_clk0]] \
    -max 3.0 [get_ports HD_CLICK_TX_1V8]
set_output_delay -clock [get_clocks -of_objects [get_pins */zynq_ultra_ps_e_0/pl_clk0]] \
    -min 0.5 [get_ports HD_CLICK_TX_1V8]

set_max_delay -from [get_ports HD_CLICK_RX_1V8] 8.0
set_max_delay -to [get_ports HD_CLICK_TX_1V8] 8.0


# Pushbuttons
set_property PACKAGE_PIN A8 [get_ports HD_GPIO_PB1]
set_property IOSTANDARD LVCMOS18 [get_ports HD_GPIO_PB1]

set_property PACKAGE_PIN F12 [get_ports MIO32_GPIO_PB1]
set_property IOSTANDARD LVCMOS18 [get_ports MIO32_GPIO_PB1]

set_false_path -from [get_ports HD_GPIO_PB1]
set_false_path -from [get_ports MIO32_GPIO_PB1]


# LEDs
set_property PACKAGE_PIN V4 [get_ports MIO07_GPIO_LED1]
set_property IOSTANDARD LVCMOS18 [get_ports MIO07_GPIO_LED1]

set_property PACKAGE_PIN AB6 [get_ports MIO24_GPIO_LED2]
set_property IOSTANDARD LVCMOS18 [get_ports MIO24_GPIO_LED2]

set_property PACKAGE_PIN Y6 [get_ports MIO25_GPIO_LED3]
set_property IOSTANDARD LVCMOS18 [get_ports MIO25_GPIO_LED3]

set_property PACKAGE_PIN E9 [get_ports MIO33_GPIO_LED4]
set_property IOSTANDARD LVCMOS18 [get_ports MIO33_GPIO_LED4]

set_property PACKAGE_PIN A7 [get_ports HD_GPIO_RGB1_R]
set_property IOSTANDARD LVCMOS18 [get_ports HD_GPIO_RGB1_R]

set_property PACKAGE_PIN B6 [get_ports HD_GPIO_RGB1_G]
set_property IOSTANDARD LVCMOS18 [get_ports HD_GPIO_RGB1_G]

set_property PACKAGE_PIN B5 [get_ports HD_GPIO_RGB1_B]
set_property IOSTANDARD LVCMOS18 [get_ports HD_GPIO_RGB1_B]

set_property PACKAGE_PIN B4 [get_ports HP_GPIO_RGB2_R]
set_property IOSTANDARD LVCMOS18 [get_ports HP_GPIO_RGB2_R]

set_property PACKAGE_PIN A2 [get_ports HP_GPIO_RGB2_G]
set_property IOSTANDARD LVCMOS18 [get_ports HP_GPIO_RGB2_G]

set_property PACKAGE_PIN F4 [get_ports HP_GPIO_RGB2_B]
set_property IOSTANDARD LVCMOS18 [get_ports HP_GPIO_RGB2_B]
