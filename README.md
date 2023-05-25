# VHDL Monocycle Processor

This repository contains the VHDL implementation of a monocycle processor based on the MIPS (Microprocessor without Interlocked Pipelined Stages) instruction set architecture. This project was created as part of the Polytech Sorbonne EI2I-3 project by Grégoire Mahon and Armand Lelong.

The processor is composed of several components, including a register file, an arithmetic logic unit (ALU), a control unit, an instruction decoder, and a processing unit. Each component is implemented as a separate VHDL entity, allowing for modularity and easy integration.

## Components

The following components are used in the processor:

- `processor`: The main component of the processor, integrating all other components.
- `banc_registres`: A 16x32-bit register file that can read and write values to and from registers.
- `ALU`: Arithmetic logic unit performing arithmetic and logic operations on two 32-bit inputs.
- `control_unit`: Generates control signals for the other components based on the instruction code.
- `Instruction_Decoder`: Decodes the incoming instruction and generates control signals for the registers and operators.
- `processing_unit`: A component that integrates the register file, ALU, control unit, and instruction decoder.

## Usage

To use the processor, instantiate the `processor` entity and connect it to the other components. The processor is clocked by the `clk` input, and instructions are loaded into the `instr` input.

## Testbenches

The processor can be tested using the provided testbenches, which simulate various instruction sequences and verify the output values. Each testbench is named after the instruction sequence it tests.

## Learning Outcomes

This project provided us with a deep understanding of the inner workings of a monocycle processor and a strong proficiency in VHDL, a hardware description language widely used in the industry. We learned how to design modular components and integrate them into a larger architecture, understanding how different parts of a system can interact to perform complex operations. This project also allowed us to develop our teamwork and communication skills, essential competencies for any engineer.

## Contributors

This project was created by Grégoire Mahon and Armand Lelong [@armagrad]. Please feel free to contribute to the project by creating pull requests or reporting issues.
