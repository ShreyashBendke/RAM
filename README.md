# RAM Modules in Verilog

A collection of synchronous RAM examples, including a 16-word × 8-bit memory with separate read/write addresses and an 8-word × 16-bit single-port memory with a bidirectional data bus.

## Features
- 16×8 RAM with independent read and write address inputs
- Clocked write and read operations
- 8×16 single-port RAM example
- Bidirectional tri-state data bus in the single-port design
- Testbenches for the memory modules

## Tools & Technologies
- Verilog HDL
- Icarus Verilog for command-line simulation (or ModelSim/QuestaSim)
- Testbenches for functional verification

## Project Structure
- `ram_16x8.v` – 16-word × 8-bit RAM
- `ram_16x8_tb.v` – testbench
- `ram_8x16_singleport.v` – 8-word × 16-bit single-port RAM
- `ram_8x16_singleport_tb.v` – testbench

## How to Run
1. Install a Verilog simulator such as [Icarus Verilog](https://steveicarus.github.io/iverilog/) or use ModelSim/QuestaSim.
2. Open a terminal in this project directory.
3. Run the following command(s):

For the 16×8 RAM:
```bash
iverilog -o ram16_sim ram_16x8.v ram_16x8_tb.v
vvp ram16_sim
```
Compile `ram_8x16_singleport.v` with its matching testbench to simulate the single-port variant.

4. Review the simulator output. To inspect waveforms, add `$dumpfile` / `$dumpvars` to the testbench and open the generated VCD file in GTKWave, or configure waveform viewing in ModelSim/QuestaSim.

## Results
- Simulation is driven by the included testbench files.
- Add screenshots of simulation output or waveforms here after running the testbench.
- Verify the results against the expected behavior for each input combination.

## Author
Shreyash Bendke – [LinkedIn](https://www.linkedin.com/in/shreyash-bendke-422b72254/)
