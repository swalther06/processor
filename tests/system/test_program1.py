
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def program1_test(dut):
    """Test Program 1 execution"""
    
    instructions = [
        0x10000028,  # addi 0 1 #40
        0x1001003C,  # addi 0 2 #60
        0x40040003,  # and 1 2 4
    ]

    for i, instr in enumerate(instructions):
        dut.instr_memory.mem_arr[i].value = instr

    await Timer(100, units='ns')  # Wait for program to execute

    assert dut.registers[0].value == 40, f"Register 0 incorrect: {dut.registers[0].value} != 40"
    assert dut.registers[1].value == 60, f"Register 1 incorrect: {dut.registers[1].value} != 60"
    assert dut.registers[2].value == 100, f"Register 2 incorrect: {dut.registers[2].value} != 100"
    assert dut.registers[3].value == 20, f"Register 3 incorrect: {dut.registers[3].value} != 20"
    assert dut.registers[4].value == (100 & 20), f"Register 4 incorrect: {dut.registers[4].value} != {100 & 20}"
    assert dut.registers[5].value == (100 | 20), f"Register 5 incorrect: {dut.registers[5].value} != {100 | 20}"
    assert dut.registers[6].value == (100 ^ 20), f"Register 6 incorrect: {dut.registers[6].value} != {100 ^ 20}"















# movi 1 #40
# add 1 1 3