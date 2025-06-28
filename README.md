# Shift Registers in Verilog

A comprehensive implementation of Serial-In Serial-Out (SISO) and Serial-In Parallel-Out (SIPO) shift registers with complete testbench simulation.

## Overview

This project demonstrates fundamental digital design concepts through the implementation of two types of 4-bit shift registers:
- **SISO (Serial-In Serial-Out)**: Data enters serially and exits serially after a 4-clock delay
- **SIPO (Serial-In Parallel-Out)**: Data enters serially and all 4 bits are available in parallel

## Project Structure

```
shift-registers/
├── README.md
├── src/
│   ├── siso.v              # SISO shift register module
│   ├── sipo.v              # SIPO shift register module
│   └── shift_registers_tb.v # Comprehensive testbench
└── simulation/
    └── wave.vcd            # Waveform output (generated)
```

## Features

- **Synchronous Design**: Both registers operate on positive clock edge
- **Asynchronous Reset**: Active-high reset for immediate clearing
- **4-bit Width**: Configurable design that can be easily scaled
- **Comprehensive Testing**: Includes multiple test patterns and edge cases
- **Waveform Generation**: VCD output for visual verification

## Module Specifications

### SISO Shift Register
- **Inputs**: `clk`, `rst`, `serial_in`
- **Output**: `serial_out`
- **Functionality**: 4-clock delay line with serial input/output
- **Use Cases**: Data buffering, timing delay, serial communication

### SIPO Shift Register
- **Inputs**: `clk`, `rst`, `serial_in`
- **Output**: `parallel_out[3:0]`
- **Functionality**: Serial-to-parallel data conversion
- **Use Cases**: Serial communication receivers, data deserialization

## Testbench Features

- **Pattern Testing**: Tests with `1010` and `1111` patterns
- **Reset Verification**: Ensures proper reset functionality
- **Timing Analysis**: 4ns clock period for detailed observation
- **Console Output**: Real-time display of register states
- **Waveform Capture**: Complete signal tracing for debugging

## Simulation Results

The testbench validates:
1. **Reset Operation**: All registers clear to `0000`
2. **Serial Shifting**: Data propagates correctly through register stages
3. **Output Timing**: SISO output appears after 4 clock cycles
4. **Parallel Access**: SIPO provides immediate access to all stored bits

## How to Run

### Using ModelSim/QuestaSim:
```bash
# Compile the design
vlog siso.v sipo.v shift_registers_tb.v

# Run simulation
vsim shift_registers_tb

# View waveforms
add wave -radix binary /*
run -all
```

### Using Icarus Verilog:
```bash
# Compile and simulate
iverilog -o shift_registers_tb siso.v sipo.v shift_registers_tb.v
vvp shift_registers_tb

# View waveforms
gtkwave wave.vcd
```

### Using Vivado:
```bash
# Create project and add source files
# Run behavioral simulation
# Observe waveforms in simulation window
```

## Key Learning Outcomes

- **Sequential Logic Design**: Understanding clocked register behavior
- **Shift Register Applications**: Serial data processing and conversion
- **Verilog Testbench Design**: Comprehensive verification methodology
- **Timing Analysis**: Clock domain considerations and setup/hold times
- **Modular Design**: Reusable, parameterizable components

## Technical Specifications

- **Technology**: Verilog HDL (IEEE 1364-2001)
- **Register Width**: 4-bit (easily configurable)
- **Clock Frequency**: Up to system constraints
- **Reset**: Asynchronous active-high
- **Shift Direction**: Right shift (MSB to LSB)

## Potential Enhancements

- [ ] Parameterized width for scalability
- [ ] Left shift capability
- [ ] Parallel load functionality
- [ ] Enable control for conditional shifting
- [ ] Bidirectional shift register implementation
- [ ] PISO (Parallel-In Serial-Out) variant

## Applications

- **Communication Systems**: UART receivers, SPI interfaces
- **Digital Signal Processing**: Delay lines, FIR filter implementations
- **Control Systems**: State machines, sequence generators
- **Test Equipment**: Pattern generators, data capture systems

## License

This project is open source and available under the MIT License.
