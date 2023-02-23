# VHDL Mono-Cycle Processor

This is a VHDL implementation of a mono-cycle processor. It is composed of several components, including a register file, an arithmetic logic unit (UAL), and a control unit. The processor architecture is based on the MIPS (Microprocessor without Interlocked Pipelined Stages) instruction set.

## Components

The following components are used in the processor:

- `banc_registres`: 16x32-bit register file
- `UAL`: arithmetic logic unit
- `controleur`: control unit

## Usage

To use the processor, instantiate the components and connect them together as shown in the `mono_cycle_processor` entity. The processor is clocked by the `clk` input, and instructions are loaded into the `instruction` input.

The `banc_registres` component is a 16x32-bit register file that can read and write values to and from registers. The `UAL` component performs arithmetic and logic operations on two 32-bit inputs. The `controleur` component decodes instructions and generates control signals for the other components.

## Testing

The processor can be tested using the provided testbenches, which simulate various instruction sequences and verify the output values. Each testbench is named after the instruction sequence it tests.

## Contributors

This project was created by Grégoire Mahon and Armand Lelong. Please feel free to contribute to the project by creating pull requests or reporting issues.
