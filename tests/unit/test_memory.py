
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

async def generate_clock(dut):
    """Generate clock pulses."""
    clock = Clock(dut.clk, 2, units="ns")  # 2 ns period
    cocotb.start_soon(clock.start())
    


@cocotb.test()
async def memory_read_test(dut):
    """Test Memory read operation"""
    
    cocotb.start_soon(generate_clock(dut))
    
    # Preload some values into memory for testing
    dut.memory[0].value = 100
    dut.memory[1].value = 200

    dut.Address.value = 0
    await Timer(10, units='ns')
    assert dut.ReadData.value == 100, f"ReadData incorrect: {dut.ReadData.value} != 100"

    dut.Address.value = 1
    await Timer(10, units='ns')
    assert dut.ReadData.value == 200, f"ReadData incorrect: {dut.ReadData.value} != 200"
    
    

@cocotb.test()
async def memory_write_test(dut):
    """Test Memory write operation"""
    
    cocotb.start_soon(generate_clock(dut))
    
    dut.WriteEnable.value = 1  # Enable write
    dut.Address.value = 2
    dut.WriteData.value = 555

    await RisingEdge(dut.clk)  # Assuming write occurs on clock edge

    assert dut.memory[2].value == 555, f"Memory at address 2 incorrect: {dut.memory[2].value} != 555"
    
    
    
@cocotb.test()
async def memory_write_disable_test(dut):
    """Test Memory write operation when disabled"""
    
    cocotb.start_soon(generate_clock(dut))
    
    dut.WriteEnable.value = 0  # Disable write
    dut.Address.value = 3
    dut.WriteData.value = 777

    await RisingEdge(dut.clk)  # Assuming write occurs on clock edge

    assert dut.memory[3].value != 777, f"Memory at address 3 should not be written: {dut.memory[3].value} == 777"
    
    
# Additional tests can be added as needed