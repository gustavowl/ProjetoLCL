vlib work
vmap work

vcom ula.vhd
vcom ula_tb.vhd

vsim ula_tb

add wave /ula_tb/sclk
add wave /ula_tb/scalcular
add wave /ula_tb/sa
add wave /ula_tb/sb
add wave /ula_tb/sresul
add wave /ula_tb/sconcl
add wave /ula_tb/serrout
add wave /ula_tb/sstate

force -freeze sim:/ula_tb/sclk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ula_tb/scalcular 0 0
force -freeze sim:/ula_tb/scalcular 1 100
force -freeze sim:/ula_tb/scalcular 0 200
force -freeze sim:/ula_tb/sa 0000000000001100 0
force -freeze sim:/ula_tb/sb 0000000000000100 0

view wave
run 1 ns
