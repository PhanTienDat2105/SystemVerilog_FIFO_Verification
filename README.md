# Synchronous FIFO Verification using SystemVerilog

## Overview

This project implements an 8-depth synchronous FIFO in SystemVerilog and verifies it using a self-checking testbench.
## FIFO Features

- 8-bit data width
- Depth = 8
- Write/Read pointer
- Full and Empty flag
- Count-based status logic
## Verification Features

- Task-based stimulus generation
- Self-checking testbench
- Queue-based expected model
- Assertion-based checking
- Waveform verification

 ## Expected Model

A SystemVerilog queue is used as the golden reference model.

- push_back() models FIFO write
- pop_front() models FIFO read

DUT output is automatically compared against the expected queue output using assertions.
<img width="1625" height="571" alt="image" src="https://github.com/user-attachments/assets/3fb6c44d-2cef-40ae-84f2-4ee4e62e0862" />
## Tools

- Vivado Simulator
- SystemVerilog
