# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# All RTL sources
RTL_DIR = rtl
VERILOG_SOURCES = $(shell find $(RTL_DIR) -name "*.sv")

# COCOTB_TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
COCOTB_TOPLEVEL ?= my_design # replace with your top-level module/entity name

# COCOTB_TEST_MODULES is the basename of the Python test file(s)
COCOTB_TEST_MODULES ?= test_my_design # replace with your test file name(s) without .py extension

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim