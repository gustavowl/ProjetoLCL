vlib work
vmap work

vcom ula.vhd
vcom ula_tb.vhd

vsim ula_tb

add wave /ula_tb/sclk
add wave /ula_tb/sclr
add wave /ula_tb/svalid
add wave /ula_tb/sdo_op
add wave /ula_tb/sswitches
add wave /ula_tb/sreset
add wave /ula_tb/ssave
add wave /ula_tb/sdonext
add wave /ula_tb/sinstru
add wave /ula_tb/sstate

force -freeze sim:/ula_tb/sclk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ula_tb/sswitches 1001100110011001 0
force -freeze sim:/ula_tb/sclr 1 200
force -freeze sim:/ula_tb/sclr 0 400
force -freeze sim:/ula_tb/svalid 1 600
force -freeze sim:/ula_tb/svalid 0 800
force -freeze sim:/ula_tb/sdo_op 1 1000
force -freeze sim:/ula_tb/sdo_op 0 1200

view wave
run 2 ns
