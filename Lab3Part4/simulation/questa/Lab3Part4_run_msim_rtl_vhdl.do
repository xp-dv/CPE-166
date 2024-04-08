transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab3Part4/watch.vhd}
vcom -93 -work work {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab3Part4/stopwatch_fsm.vhd}
vcom -93 -work work {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab3Part4/clk_div.vhd}
vcom -93 -work work {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab3Part4/stopwatch.vhd}

vcom -93 -work work {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab3Part4/stopwatch_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  stopwatch_tb

add wave *
view structure
view signals
run -all
