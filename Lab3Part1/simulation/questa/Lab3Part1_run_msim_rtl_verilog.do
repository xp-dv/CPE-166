transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/XP/Documents/CPE\ 166/Projects/Lab3Part1 {C:/Users/XP/Documents/CPE 166/Projects/Lab3Part1/hex_7seg_decoder_anode.sv}

