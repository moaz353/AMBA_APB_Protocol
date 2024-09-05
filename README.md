# AMBA APB Protocol Verilog Implementation

## Overview

### This repository contains a Verilog implementation of the AMBA APB (Advanced Peripheral Bus) protocol.
### The AMBA APB is used for interfacing with peripheral devices in an ARM-based system.

## This Verilog code implements an AMBA APB (Advanced Peripheral Bus) interface with a basic FSM (Finite State Machine) to handle the bus protocol states: IDEAL, SETUP, and ACCESS. Here's a description of the code and its function:

## Code Functionality:
### FSM (Finite State Machine):

### IDEAL : 
The system is in an idle state. It waits for a peripheral selection (psel). When psel is asserted, it transitions to the SETUP state.
### SETUP :
The bus is being set up for a read or write operation. If psel and penable are asserted, it transitions to the ACCESS state, where the actual data transfer occurs. If psel is deasserted, it goes back to IDEAL.
### ACCESS :
The bus is actively reading or writing data. If psel is deasserted, it returns to the IDEAL state. Otherwise, it continues in the ACCESS state.

## Memory Interface:

The RAM module is instantiated to handle memory operations. It performs read and write operations based on the control signals (penable, pWRITE, pADDr, pWDATA, and pSTRB).

## Output Signals:

pREADY is the readiness signal that indicates whether the slave device is ready to transfer data. This signal is asserted (1) during the ACCESS state and deasserted (0) during the IDEAL and SETUP states.

## Wait State Analysis:

### This design implements a "With Wait" state configuration. Here's why:

The pREADY signal is not asserted immediately during the SETUP state but only during the ACCESS state. This means that the bus must wait for the ACCESS state before any data transfer can occur, introducing a wait period between the SETUP and ACCESS states.

# THX ;
