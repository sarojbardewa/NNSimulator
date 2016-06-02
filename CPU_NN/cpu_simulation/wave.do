onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /cpuTest/ArtNN_CPU/ALU1/SrcA
add wave -noupdate -radix decimal /cpuTest/ArtNN_CPU/ALU1/SrcB
add wave -noupdate -radix binary /cpuTest/ArtNN_CPU/ALU1/ALU1Control
add wave -noupdate /cpuTest/ArtNN_CPU/ALU1/ALUResult
add wave -noupdate -radix decimal /cpuTest/CLK_cycle
add wave -noupdate /cpuTest/ArtNN_CPU/CLK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1594 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
configure wave -valuecolwidth 38
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {225 ns}
