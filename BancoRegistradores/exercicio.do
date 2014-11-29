vlib work
vmap work

vcom exercicio.vhd
vcom exercicio_tb.vhd

vsim exercicio_tb

add wave /exercicio_tb/si
add wave /exercicio_tb/sclk
add wave /exercicio_tb/sld
add wave /exercicio_tb/sregnum
add wave /exercicio_tb/sq

force -freeze sim:/exercicio_tb/sclk 1 0, 0 {50 ps} -r 100
force -freeze sim:/exercicio_tb/si 1010101010101010 0
force -freeze sim:/exercicio_tb/sld 1 0, 0 {75 ps} -r 150
force -freeze sim:/exercicio_tb/sregnum 000 0, 100 {250 ps} -r 500
force -freeze sim:/exercicio_tb/si 1010101010101010 0, 1010000010101111 {200 ps} -r 400

view wave
run 1600 ps
