vlib work
vmap work

vcom exercicio.vhd
vcom exercicio_tb.vhd

vsim exercicio_tb

add wave /exercicio_tb/sclk
add wave /exercicio_tb/sop_over
add wave /exercicio_tb/sreset
add wave /exercicio_tb/serro_ula
add wave /exercicio_tb/sresult

add wave /exercicio_tb/sled_op_over
add wave /exercicio_tb/sled_doing_op
add wave /exercicio_tb/sled_reset
add wave /exercicio_tb/sled_erro_ula
add wave /exercicio_tb/sdisplays

force -freeze sim:/exercicio_tb/sclk 1 0, 0 {50 ps} -r 100
force -freeze sim:/exercicio_tb/sop_over 0 0
force -freeze sim:/exercicio_tb/sreset 1 0
force -freeze sim:/exercicio_tb/serro_ula 1 0
force -freeze sim:/exercicio_tb/sresult 0000000001001001 0

force -freeze sim:/exercicio_tb/sop_over 1 200
force -freeze sim:/exercicio_tb/sreset 0 200

force -freeze sim:/exercicio_tb/sop_over 0 400
force -freeze sim:/exercicio_tb/serro_ula 0 400
force -freeze sim:/exercicio_tb/sresult 0000000001111111 400

force -freeze sim:/exercicio_tb/sop_over 1 600

force -freeze sim:/exercicio_tb/sreset 1 700

force -freeze sim:/exercicio_tb/sreset 0 800

view wave
run 1600 ps
