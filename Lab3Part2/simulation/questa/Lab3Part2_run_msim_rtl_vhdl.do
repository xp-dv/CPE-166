transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/XP/Documents/CPE 166/Projects/Lab3Part2/parity_pack.vhd}
vcom -93 -work work {C:/Users/XP/Documents/CPE 166/Projects/Lab3Part2/hamming7_4.vhd}

vcom -93 -work work {C:/Users/XP/Documents/CPE 166/Projects/Lab3Part2/hamming7_4_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  hamming7_4_tb

add wave *
view structure
view signals
run -all
