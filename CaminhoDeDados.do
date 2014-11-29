vlib work
vmap work

vcom BancoRegistradores/exercicio.vhd
vcom DecodificadorHexaDecimal16Bit/exercicio.vhd
vcom ModuloAcessoMemoria/ula.vhd
vcom ModuloEntrada/ula.vhd
vcom RAM/ram.vhd
vcom ULA16bit/ula.vhd
vcom CaminhoDeDados.vhd
vcom CaminhoDeDados_tb.vhd

vsim cdd_tb

add wave /cdd_tb/sclk
add wave /cdd_tb/sclr
add wave /cdd_tb/svalid
add wave /cdd_tb/sdo_op
add wave /cdd_tb/sswitches

add wave /cdd_tb/sop_done_ula
add wave /cdd_tb/sfrom_reg2
add wave /cdd_tb/sfrom_ram
add wave /cdd_tb/sfrom_ula
add wave /cdd_tb/serro_ula
add wave /cdd_tb/sdo_op_ula
add wave /cdd_tb/sop_done
add wave /cdd_tb/sval_ram
add wave /cdd_tb/send_ram
add wave /cdd_tb/sval_reg2
add wave /cdd_tb/sula_a
add wave /cdd_tb/sula_b
add wave /cdd_tb/send_reg2
add wave /cdd_tb/sesc_ram
add wave /cdd_tb/sesc_reg2
add wave /cdd_tb/sula_x
add wave /cdd_tb/sula_y
add wave /cdd_tb/sula_z
add wave /cdd_tb/sstat

force -freeze sim:/cdd_tb/sclk 1 0, 0 {50 ps} -r 100
force -freeze sim:/cdd_tb/sswitches 0000100110100000 0
force -freeze sim:/cdd_tb/sclr 1 100
force -freeze sim:/cdd_tb/sclr 0 200
force -freeze sim:/cdd_tb/svalid 0 0
force -freeze sim:/cdd_tb/svalid 1 300
force -freeze sim:/cdd_tb/svalid 0 400
force -freeze sim:/cdd_tb/sdo_op 0 0
force -freeze sim:/cdd_tb/sdo_op 1 500
force -freeze sim:/cdd_tb/sdo_op 0 700
force -freeze sim:/cdd_tb/sdo_op 1 1300
force -freeze sim:/cdd_tb/sdo_op 0 1400
force -freeze sim:/cdd_tb/sdo_op 1 2000



force -freeze sim:/cdd_tb/sop_done_ula 0 0
force -freeze sim:/cdd_tb/sfrom_ram 0000000000001100 0
force -freeze sim:/cdd_tb/sfrom_ula 0000000001001001 0
force -freeze sim:/cdd_tb/serro_ula 0 0
force -freeze sim:/cdd_tb/sop_done_ula 1 900
force -freeze sim:/cdd_tb/sswitches 0000100110110000 1100
force -freeze sim:/cdd_tb/svalid 1 1100
force -freeze sim:/cdd_tb/svalid 0 1200

view wave
run 3 ns
