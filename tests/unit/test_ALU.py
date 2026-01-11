import isa.constants 
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def alu_addition_test(dut):
    """Test ALU addition operation"""
    dut.ALU_Op.value = isa.constants.ALU_ADD  # Assuming opcode 0 is for addition
    dut.A.value = 15
    dut.B.value = 10

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 25, f"Addition result incorrect: {dut.ALU_Out.value} != 25"
    

@cocotb.test()
async def alu_subtraction_test(dut):
    """Test ALU subtraction operation"""
    dut.ALU_Op.value = isa.constants.ALU_SUB  # Assuming opcode 1 is for subtraction
    dut.A.value = 20
    dut.B.value = 5

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 15, f"Subtraction result incorrect: {dut.ALU_Out.value} != 15"
    
    
@cocotb.test()
async def alu_and_test(dut):
    """Test ALU AND operation"""
    dut.ALU_Op.value = isa.constants.ALU_AND  # Assuming opcode 2 is for AND
    dut.A.value = 0b1100
    dut.B.value = 0b1010

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b1000, f"AND result incorrect: {dut.ALU_Out.value} != 0b1000"
    
    
@cocotb.test()
async def alu_or_test(dut):
    """Test ALU OR operation"""
    dut.ALU_Op.value = isa.constants.ALU_OR  # Assuming opcode 3 is for OR
    dut.A.value = 0b1100
    dut.B.value = 0b1010

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b1110, f"OR result incorrect: {dut.ALU_Out.value} != 0b1110"
    
    
@cocotb.test()
async def alu_xor_test(dut):
    """Test ALU XOR operation"""
    dut.ALU_Op.value = isa.constants.ALU_XOR  # Assuming opcode 4 is for XOR
    dut.A.value = 0b1100
    dut.B.value = 0b1010

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b0110, f"XOR result incorrect: {dut.ALU_Out.value} != 0b0110"
    
    
@cocotb.test()
async def alu_nor_test(dut):
    """Test ALU NOR operation"""
    dut.ALU_Op.value = isa.constants.ALU_NOR  # Assuming opcode 5 is for NOR
    dut.A.value = 0b1100
    dut.B.value = 0b1010

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b0001, f"NOR result incorrect: {dut.ALU_Out.value} != 0b0001"
    
    
@cocotb.test()
async def alu_lsl_test(dut):
    """Test ALU Logical Shift Left operation"""
    dut.ALU_Op.value = isa.constants.ALU_LSL  # Assuming opcode 6 is for LSL
    dut.A.value = 0b0001
    dut.B.value = 2  # Shift by 2

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b0100, f"LSL result incorrect: {dut.ALU_Out.value} != 0b0100"
    

@cocotb.test()
async def alu_lsr_test(dut):
    """Test ALU Logical Shift Right operation"""
    dut.ALU_Op.value = isa.constants.ALU_LSR  # Assuming opcode 7 is for LSR
    dut.A.value = 0b0100
    dut.B.value = 2  # Shift by 2

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b0001, f"LSR result incorrect: {dut.ALU_Out.value} != 0b0001"
    

# Additional ALU operation tests can be added as needed