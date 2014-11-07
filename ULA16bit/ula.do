vlib work
vmap work

vcom ula.vhd
vcom ula_tb.vhd

vsim ula_tb

add wave /ula_tb/mx
add wave /ula_tb/my
add wave /ula_tb/mz
add wave /ula_tb/ma
add wave /ula_tb/mb
add wave /ula_tb/ms
add wave /ula_tb/mcout

view wave
run 400 ns
