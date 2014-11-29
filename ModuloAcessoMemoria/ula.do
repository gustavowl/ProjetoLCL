vlib work
vmap work

vcom ula.vhd
vcom ula_tb.vhd

vsim ula_tb

add wave /ula_tb/sclk
add wave /ula_tb/sclr
add wave /ula_tb/sdo_op
add wave /ula_tb/sop_done_ula
add wave /ula_tb/sinst_in
add wave /ula_tb/sfrom_reg
add wave /ula_tb/sfrom_ram
add wave /ula_tb/sfrom_ula
add wave /ula_tb/serro_ula

add wave /ula_tb/sdo_op_ula
add wave /ula_tb/sop_done
add wave /ula_tb/sval_ram
add wave /ula_tb/send_ram
add wave /ula_tb/sval_reg
add wave /ula_tb/sula_a
add wave /ula_tb/sula_b
add wave /ula_tb/send_reg
add wave /ula_tb/sesc_ram
add wave /ula_tb/sesc_reg
add wave /ula_tb/srst_reg
add wave /ula_tb/sula_x
add wave /ula_tb/sula_y
add wave /ula_tb/sula_z
add wave /ula_tb/sstat

force -freeze sim:/ula_tb/sclk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ula_tb/sclr 0 0
force -freeze sim:/ula_tb/sdo_op 0 0
force -freeze sim:/ula_tb/sop_done_ula 0 0
force -freeze sim:/ula_tb/sinst_in 1110011010001000 0
force -freeze sim:/ula_tb/sfrom_reg 0000000000000011 0
force -freeze sim:/ula_tb/sfrom_ram 0000000000001100 0
force -freeze sim:/ula_tb/sfrom_ula 0000000001001001 0
force -freeze sim:/ula_tb/serro_ula 0 0

force -freeze sim:/ula_tb/sclr 1 100

force -freeze sim:/ula_tb/sclr 0 200

force -freeze sim:/ula_tb/sdo_op 1 300

force -freeze sim:/ula_tb/sdo_op 0 400

force -freeze sim:/ula_tb/sop_done_ula 1 500





view wave
run 1 ns
