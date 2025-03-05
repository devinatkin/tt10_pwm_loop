# Makefile for testing with iverilog and vvp

# Define the compiler and simulator
IVL = iverilog -g2012
VVP = vvp

# Output directory for simulation files
OUT_DIR = sim_out

# Create the output directory if it doesn't exist
$(shell mkdir -p $(OUT_DIR))

# Phony targets
.PHONY: all clean

all: tb_shift_register

tb_shift_register: 
	$(IVL) -o $(OUT_DIR)/$@.vvp ../src/shift_register.v tb_shift_register.v
	$(VVP) $(OUT_DIR)/$@.vvp

tb_pwm_module: 
	$(IVL) -o $(OUT_DIR)/$@.vvp ../src/pwm_module.v tb_pwm_module.v
	$(VVP) $(OUT_DIR)/$@.vvp

tb_top: 
	$(IVL) -o $(OUT_DIR)/$@.vvp ../src/tt_um_devinatkin_pwm.v ../src/shift_register.v ../src/pwm_module.v tb_tt_um_devinatkin_pwm.v
	$(VVP) $(OUT_DIR)/$@.vvp


clean:
	@echo Cleaning up...
	rm -rf $(OUT_DIR)