quit -sim 

vlib work 
vlog design.v TB.v 
vsim -voptargs=+acc AMBA_APB_tb

add wave -position insertpoint  \
sim:/AMBA_APB_tb/pclk \
sim:/AMBA_APB_tb/prst_n \
sim:/AMBA_APB_tb/psel \
sim:/AMBA_APB_tb/penable \
sim:/AMBA_APB_tb/pWRITE \
sim:/AMBA_APB_tb/pADDr \
sim:/AMBA_APB_tb/pWDATA \
sim:/AMBA_APB_tb/pSTRB \
sim:/AMBA_APB_tb/pREADY \
sim:/AMBA_APB_tb/pRDATA
add wave -position insertpoint  \
sim:/AMBA_APB_tb/DUT/cs \
sim:/AMBA_APB_tb/DUT/ns
add wave -position insertpoint  \
sim:/AMBA_APB_tb/DUT/BLK/mem

run -all 