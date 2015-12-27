Bitonic Sorter Network - VHDL
=============================

# Overview

## Introduction

This is the logical synthesis possible Bitonic Sorter Network written in VHDL.

## Licensing

Distributed under the BSD 2-Clause License.


# Simulation

## Simulation for Vivado

### Environment

- Xilinx Vivado 2015.4

### Create Project for Vivado

#### using Vivado Tcl Shell

````Shell
Vivado% cd sim/vivado/bitonic_sorter
Vivado% vivado -mod batch -source create_project.tcl
````

#### using Vivado GUI

````
Vivado > Tools > Run Tcl Script... >  sim/vivado/bitonic_sorter/create_project.tcl
````

### Run Simulation

using Vivado GUI

````
Vivado > Open Project > sim/vivado/bitonic_sorter/bitonic_sorter.xpr
Flow Navigator > Run Simulation > Run Bihavioral Simulation 
````

# Logic Synthesis and Implementation

## Logic Synthesis for Vivado

### Environment

- Xilinx Vivado 2015.4
- Xilinx Zynq7020-1 (xc7z020clg400-1)

### Create Project for Vivado

#### using Vivado Tcl Shell

````Shell
Vivado% cd sim/vivado/bitonic_sorter
Vivado% vivado -mod batch -source create_project.tcl
````

#### using Vivado GUI

````
Vivado > Tools > Run Tcl Script... >  sim/vivado/bitonic_sorter/create_project.tcl
````

### Run Implementation

using Vivado GUI

````
Vivado > Open Project > sim/vivado/bitonic_sorter/bitonic_sorter.xpr
Flow Navigator > Run Implementation
````
### Utilization

| WORDS | Slice LUTs | Slice Registers | Slice |
|------:|-----------:|----------------:|------:|
|     4 |        252 |              70 |    87 |
|     8 |       2061 |            1585 |   545 |
|    16 |       6658 |            5247 |  1746 |
|    32 |      19715 |           15684 |  5228 |
