vlib work
vmap work

vcom ram.vhd
vcom ram_tb.vhd

vsim ram_tb

add wave /ram_tb/sclk
add wave /ram_tb/swren
add wave /ram_tb/send
add wave /ram_tb/sin
add wave /ram_tb/sout

force -freeze sim:/ram_tb/sclk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ram_tb/swren 0 0
force -freeze sim:/ram_tb/send 0000000000000001 0
force -freeze sim:/ram_tb/sin 0000000001001001 0

force -freeze sim:/ram_tb/send 0000000000000000 100

force -freeze sim:/ram_tb/swren 1 200
force -freeze sim:/ram_tb/swren 0 300

force -freeze sim:/ram_tb/send 0000000000000001 300
force -freeze sim:/ram_tb/send 0000000000000000 400


view wave
run 1 ns
