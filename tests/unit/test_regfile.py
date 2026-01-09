
import cocotb
from cocotb.triggers import Timer, RisingEdge


async def generate_clock(dut):
    """Generate clock pulses."""

    for _ in range(10):
        dut.clk.value = 0
        await Timer(1, unit="ns")
        dut.clk.value = 1
        await Timer(1, unit="ns")


@cocotb.test()
async def regfile_read_test(dut):
    """Test Register File read operation"""
    
    cocotb.start_soon(generate_clock(dut))
    # Initialize registers
    reg1 = 2
    reg2 = 3
    dut.WriteEnable.value = 0  # Disable write
    dut.RegA.value = reg1
    dut.RegB.value = reg2

    # Preload some values into registers for testing
    dut.registers[reg1].value = 42
    dut.registers[reg2].value = 84

    await Timer(10, units='ns')

    assert dut.ReadData1.value == 42, f"ReadData1 incorrect: {dut.ReadData1.value} != 42"
    assert dut.ReadData2.value == 84, f"ReadData2 incorrect: {dut.ReadData2.value} != 84"
    
    dut.registers[reg1].value = 0
    dut.registers[reg2].value = -5
    
    await Timer(10, units='ns')
    assert dut.ReadData1.value == 0, f"ReadData1 incorrect: {dut.ReadData1.value} != 0"
    assert dut.ReadData2.value == -5, f"ReadData2 incorrect: {dut.ReadData2.value} != -5"
    
    
    
@cocotb.test()
async def regfile_write_test(dut):
    """Test Register File write operation"""
    
    cocotb.start_soon(generate_clock(dut))
    reg_dest = 4
    write_value = 123
    dut.WriteEnable.value = 1  # Enable write
    dut.WriteReg.value = reg_dest
    dut.WriteData.value = write_value

    await RisingEdge(dut.clk)  # Assuming write occurs on clock edge

    assert dut.registers[reg_dest].value == write_value, f"Register {reg_dest} incorrect: {dut.registers[reg_dest].value} != {write_value}"

    # Test writing another value
    write_value2 = -456
    dut.WriteData.value = write_value2

    await RisingEdge(dut.clk)

    assert dut.registers[reg_dest].value == write_value2, f"Register {reg_dest} incorrect: {dut.registers[reg_dest].value} != {write_value2}"
    
    
    
@cocotb.test()
async def regfile_read_and_write_test(dut):
    """Test Register File write followed by read operation"""
    
    cocotb.start_soon(generate_clock(dut))
    
    reg1 = 2
    reg2 = 3
    reg_dest = 5
    write_value = 789
    dut.WriteEnable.value = 1  # Enable write
    dut.WriteReg.value = reg_dest
    dut.WriteData.value = write_value
    
    await Timer(5, units='ns')
    assert dut.registers[reg1].value == 0, f"Register {reg1} should be 0 initially"
    assert dut.registers[reg2].value == 0, f"Register {reg2} should be 0 initially"

    await RisingEdge(dut.clk)  # Write on clock edge

    # Now read back the value
    dut.WriteEnable.value = 0  # Disable write
    dut.RegA.value = reg_dest
    dut.RegB.value = reg1
    await Timer(10, units='ns')
    assert dut.Data1.value == write_value, f"ReadData1 incorrect: {dut.ReadData1.value} != {write_value}"
    assert dut.Data2.value == 0, f"ReadData2 incorrect: {dut.ReadData2.value} != 0"
    
    
# Additional tests can be added as needed