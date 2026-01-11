import yaml
from pathlib import Path


# Define base directory and ISA file path
base_dir = Path(__file__).resolve().parent.parent
ISA_PATH = base_dir / "isa" / "isa.yaml"

# Load ISA definitions from YAML file
with open(ISA_PATH) as f:
    isa = yaml.safe_load(f)

#Generate SystemVerilog constants file
with open("isa/constants.svh", "w") as f:
    f.write("// This file is auto-generated. Do not edit directly.\n\n")
    f.write("`ifndef CONSTANTS_SVH\n")
    f.write("`define CONSTANTS_SVH\n\n") 
    
#Generate python constants file
with open("isa/constants.py", "w") as f:
    f.write("# This file is auto-generated. Do not edit directly.\n\n")

# Write constants to both files
for section, entries in isa.items():
    for entry, value in entries.items():
        # Write to SystemVerilog file
        with open("isa/constants.svh", "a") as sv_f:
            sv_f.write(f"localparam {entry} = {value};\n")    
        # Write to Python file
        with open("isa/constants.py", "a") as py_f:
            py_f.write(f"{entry} = {value}\n")

# Close the SystemVerilog ifndef
with open("isa/constants.svh", "a") as sv_f:
    sv_f.write("\n`endif // CONSTANTS_SVH\n")
    
with open("isa/constants.py", "a") as py_f:
    py_f.write("\n # End of constants\n")