from sys import modules


files = [
    "ALU.vhd",
    "constants.vhd",
    "Decode.vhd",
    "Inc10Bit.vhd",
    "MUX.vhd",
    "processor.vhd",
    "RegisterSet.vhd"
]

modules = {
    "local": [
        "../test"
    ]
}
