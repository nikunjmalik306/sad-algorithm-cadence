read_libs /home/install/FOUNDRY/digital/90nm/dig/lib/slow.lib
read_hdl sad.v
elaborate
read_sdc sad.sdc
set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium
syn_generic
syn_map
syn_opt
report_timing > sad_timing.rep
report_area > sad_area.rep
report_power > sad_power.rep
write_hdl > netlist.v
write_sdc > block.sdc
gui_show
