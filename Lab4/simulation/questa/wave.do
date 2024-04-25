onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/clk
add wave -noupdate -divider {User Input}
add wave -noupdate /datapath_tb/m_i
add wave -noupdate /datapath_tb/cin_i
add wave -noupdate -divider {From FSM}
add wave -noupdate /datapath_tb/clr_i
add wave -noupdate /datapath_tb/ce_i
add wave -noupdate /datapath_tb/w_i
add wave -noupdate /datapath_tb/sel_i
add wave -noupdate /datapath_tb/s_i
add wave -noupdate -divider Registers
add wave -noupdate /datapath_tb/r_q
add wave -noupdate /datapath_tb/uut/a_q
add wave -noupdate -divider {Internal Signals}
add wave -noupdate /datapath_tb/uut/y_d
add wave -noupdate /datapath_tb/uut/b_io
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {126778 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 10000
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {251440 ps}
