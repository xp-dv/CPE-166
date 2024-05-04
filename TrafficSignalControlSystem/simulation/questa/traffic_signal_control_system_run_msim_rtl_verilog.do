transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/XP/Documents/CPE\ 166/TrafficSignalControlSystem {C:/Users/XP/Documents/CPE 166/TrafficSignalControlSystem/traffic_signal_colors_pkg.sv}
vlog -sv -work work +incdir+C:/Users/XP/Documents/CPE\ 166/TrafficSignalControlSystem {C:/Users/XP/Documents/CPE 166/TrafficSignalControlSystem/traffic_signal_control_system.sv}

vlog -sv -work work +incdir+C:/Users/XP/Documents/CPE\ 166/TrafficSignalControlSystem {C:/Users/XP/Documents/CPE 166/TrafficSignalControlSystem/traffic_signal_control_system_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  traffic_signal_control_system_tb

add wave *
view structure
view signals
run -all
