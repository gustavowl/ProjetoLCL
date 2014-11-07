vlib work
vmap work

vcom exercicio.vhd
vcom exercicio_tb.vhd

vsim exercicio_tb

add wave /exercicio_tb/mentry
add wave /exercicio_tb/md3
add wave /exercicio_tb/md2
add wave /exercicio_tb/md1
add wave /exercicio_tb/md0

view wave
run 800 ns
