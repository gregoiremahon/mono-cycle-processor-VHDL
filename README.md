# VHDL Monocycle Processor

This project is a VHDL implementation of a monocycle processor based on the MIPS (Microprocessor without Interlocked Pipelined Stages) instruction set architecture. The processor is composed of several components, including a register file, an arithmetic logic unit (ALU), and a control unit.

## Components

The following components are used in the processor:

- `processing_unit`: the main component of the processor, including the register file, ALU, and control unit
- `banc_registres`: a 16x32-bit register file
- `ALU`: arithmetic logic unit
- `control_unit`: generates control signals for the other components based on the instruction code

## Usage

To use the processor, instantiate the `processing_unit` and connect it to the other components. The processor is clocked by the `clk` input, and instructions are loaded into the `instr` input.

The `register_bank` component is a 16x32-bit register file that can read and write values to and from registers. The `ALU` component performs arithmetic and logic operations on two 32-bit inputs. The `control_unit` component decodes instructions and generates control signals for the other components.

## Testbenches

The processor can be tested using the provided testbenches, which simulate various instruction sequences and verify the output values. Each testbench is named after the instruction sequence it tests.

## Contributors

This project was created by Grégoire Mahon and Armand Lelong [@armagrad], as part of the Polytech Sorbonne EI2I-3 project. Please feel free to contribute to the project by creating pull requests or reporting issues.
