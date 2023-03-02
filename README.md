#VHDL Mono-Cycle Processor
This is a VHDL implementation of a mono-cycle processor based on the MIPS (Microprocessor without Interlocked Pipelined Stages) instruction set. The processor is composed of several components, including a register file, an arithmetic logic unit (UAL), and a control unit.

##Components
The following components are used in the processor:

`processing_unit`: the main component of the processor, including the register file, UAL, and control unit
`register_bank`: a 16x32-bit register file
`UAL` : arithmetic logic unit
`control_unit`: generates control signals for the other components based on the instruction code
#Usage
To use the processor, instantiate the processing_unit and connect it to the other components. The processor is clocked by the clk input, and instructions are loaded into the instr input.

The register_bank component is a 16x32-bit register file that can read and write values to and from registers. The UAL component performs arithmetic and logic operations on two 32-bit inputs. The control_unit component decodes instructions and generates control signals for the other components.

#Testbenches
The processor can be tested using the provided testbenches, which simulate various instruction sequences and verify the output values. Each testbench is named after the instruction sequence it tests.

#Contributors
This project was created by Grégoire Mahon and Armand Lelong, as part of Polytech Sorbonne EI2I-3 project. Please feel free to contribute to the project by creating pull requests or reporting issues.
