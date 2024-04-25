transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/XP/Documents/CPE\ 166/FPGA\ Projects/Lab4Part1 {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab4Part1/mux4_4to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/XP/Documents/CPE\ 166/FPGA\ Projects/Lab4Part1 {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab4Part1/mux4_2to1.v}
vlog -vlog01compat -work work +incdir+C:/Users/XP/Documents/CPE\ 166/FPGA\ Projects/Lab4Part1 {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab4Part1/dff4_ce.v}
vlog -vlog01compat -work work +incdir+C:/Users/XP/Documents/CPE\ 166/FPGA\ Projects/Lab4Part1 {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab4Part1/alu.v}
vlog -sv -work work +incdir+C:/Users/XP/Documents/CPE\ 166/FPGA\ Projects/Lab4Part1 {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab4Part1/datapath.sv}

vlog -sv -work work +incdir+C:/Users/XP/Documents/CPE\ 166/FPGA\ Projects/Lab4Part1 {C:/Users/XP/Documents/CPE 166/FPGA Projects/Lab4Part1/datapath_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  datapath_tb

add wave *
view structure
view signals
run -all
