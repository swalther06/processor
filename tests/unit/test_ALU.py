from rtl.constants import ALU_ADD
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def alu_addition_test(dut):
    """Test ALU addition operation"""
    dut.ALU_Op.value = ALU_ADD  # Assuming opcode 0 is for addition
    dut.A.value = 15
    dut.B.value = 10

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 25, f"Addition result incorrect: {dut.ALU_Out.value} != 25"
    

@cocotb.test()
async def alu_subtraction_test(dut):
    """Test ALU subtraction operation"""
    dut.ALU_Op.value = 1  # Assuming opcode 1 is for subtraction
    dut.A.value = 20
    dut.B.value = 5

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 15, f"Subtraction result incorrect: {dut.ALU_Out.value} != 15"
    
    
@cocotb.test()
async def alu_and_test(dut):
    """Test ALU AND operation"""
    dut.ALU_Op.value = 2  # Assuming opcode 2 is for AND
    dut.A.value = 0b1100
    dut.B.value = 0b1010

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b1000, f"AND result incorrect: {dut.ALU_Out.value} != 0b1000"
    
    
@cocotb.test()
async def alu_or_test(dut):
    """Test ALU OR operation"""
    dut.ALU_Op.value = 3  # Assuming opcode 3 is for OR
    dut.A.value = 0b1100
    dut.B.value = 0b1010

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b1110, f"OR result incorrect: {dut.ALU_Out.value} != 0b1110"
    
    
@cocotb.test()
async def alu_xor_test(dut):
    """Test ALU XOR operation"""
    dut.ALU_Op.value = 4  # Assuming opcode 4 is for XOR
    dut.A.value = 0b1100
    dut.B.value = 0b1010

    await Timer(10, units='ns')

    assert dut.ALU_Out.value == 0b0110, f"XOR result incorrect: {dut.ALU_Out.value} != 0b0110"