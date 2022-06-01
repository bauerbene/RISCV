from sys import modules


files = [
    "ALU.vhd",
    "constants.vhd",
    "Decode.vhd",
    "Inc10Bit.vhd",
    "MUX.vhd",
    "processor.vhd",
    "RegisterSet.vhd",
    "DecodeStage.vhd",
    "ExecutionStage.vhd",
    "MemStage.vhd",
    "Forward.vhd"
]

modules = {
    "local": [
        "../test"
    ]
}
