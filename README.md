# MCH2022 badge amaranth examples

This repository is based on [icebreaker-amaranth-examples](https://github.com/icebreaker-fpga/icebreaker-amaranth-examples) and contains examples for the [amaranth HDL](https://github.com/amaranth-lang/amaranth)
Python library for register transfer level modeling of synchronous logic. Ordinary Python code is
used to construct a netlist of a digital circuit, which can be simulated, directly synthesized via
Yosys, or converted to human-readable Verilog code for use with industry-standard toolchains.

## Getting Started
Please follow the [badge Getting Started](https://badge.team/docs/badges/mch2022/getting-started/) first and also install the [udev rules](https://badge.team/docs/badges/mch2022/software-development/#linux-permissions).

Then clone this repository recursively.

```shell
git clone --recurse-submodules https://github.com/cyber-murmel/mch2022-amaranth-examples.git
cd mch2022-amaranth-examples
```

If you just want to let the rubber hit the road, there is a [TL;DR](README.md#tldr) at the
bottom of this readme.

### Toolchain
To synthesize and upload bitstrams you need to install
[`yosys`](https://yosyshq.net/yosys/download.html),
[`icestorm`](https://clifford.at/icestorm),
[`nextpnr`](https://github.com/YosysHQ/nextpnr) and
[`libus`](https://libusb.info/).
These packages should be available for most common Linux distributions.
If that's not the case, click the link to the respective package above.

#### Python
Install the necessary Python packages from the `reuqirements.txt`. I recommend using Python venv.

```shell
python3 -m venv .venv
source .venv/bin/activate

python3 -m pip install --upgrade pip --requirement requirements.txt
```

When you are done with the project simply close the shell or run `deactivate` to exit the venv.
You need to run `source .venv/bin/activate` from the root of this repository when you want to use
this project in a new shell.

#### Nix(OS)
Users of Nix or NixOS can skip the toolchain instructions above and simply run `nix-shell` in the root of this directory to drop into a functional development environment.

### MCH2022 Tools
If you didn't clone this repository recursively, run the following to geth the mch2022-tools.

```shell
git submodule update --init --recursive
```

You must set the `WEBUSB_FPGA` environment variable to the location of the `webusb_fpga.py` script. This must also be done every time you open a new terminal window.
```shell
export WEBUSB_FPGA=$PWD/mch2022-tools/webusb_fpga.py
```

### Testing and Usage
After that all you need to do is connect your MCH2022 badge to the computer.

To test the toolchain and hardware you can call a board package directly.
```shell
python3 -m amaranth_boards.mch2022
```
This should make th RGB LED blink white.

The scripts are by default set to synthesize and upload the bitstream to the MCH2022 badge board.

## Repository Structure
The project structure is currently subject to change.
Most directories in [mch2022/](mch2022/) contain directories containing a Python file.
These can simply be run like

```shell
python3 mch2022/pdm_fade_gamma/gamma_pdm.py
```

The new structure can be seen in the [blink](mch2022/blink/). This contains and `__init__.py`
and `__main__.py` and is supposed to be run as a Python module.

```shell
python3 -m mch2022.blink
```

New projects are als supposed to provide a help text.

```shell
python3 -m mch2022.blink --help
usage: __main__.py [-h] [-b BLINK_FREQ] {generate,simulate} ...

positional arguments:
  {generate,simulate}
    generate            generate RTLIL, Verilog or CXXRTL from the design
    simulate            simulate the design

optional arguments:
  -h, --help            show this help message and exit
  -b BLINK_FREQ, --blink-freq BLINK_FREQ
                        blink frequency
```

## Warning
Amaranth is still a work in progress project. Expect examples to occasionally break until amaranth
fully stabilizes.

## Simulation
To run a module virtually, call the module with the `simulate` command, and specify the
number of clock cycles to run and the paths for the VCD and GTKW file. To view the waveforms install [`gtkwave`](http://gtkwave.sourceforge.net/).

The following commands run create the blink module with a frequency of 1MHz, so that the
waveform isn't too long, and then open the files with GTKWave.

```shell
python3 -m mch2022.blink \
  --blink-freq 1000000 \
  simulate \
    --clocks 100 \
    --vcd-file blink.vcd \
    --gtkw-file blink.gtkw
gtkwave --dump blink.vcd --save blink.gtkw
```

## Formal Verification
To get a quick understanding what formal verification is and what it can do, I recommend
watching [Matt Venn's](https://www.youtube.com/watch?v=_5R35QFsXM4) or [Robert Beruch's](https://www.youtube.com/watch?v=9e7F1XhjhKw) video (series) or reading the [Wikipedia entry](https://en.wikipedia.org/wiki/Formal_verification).


### Toolchain
If you want to get started with formal verification, you also need to
install [`symbiyosys` and `yices`](https://symbiyosys.readthedocs.io/en/latest/install.html).
These packages are alredy part of the [`shell.nix`](/README.md#nixos).

Currently the only example with formal verification is [mch2022/blink](/mch2022/blink/).
Formal verification runs are implemented as Python [unit test cases](mch2022/blink/tests/test_blink.py).
Start formal verification by calling the `unittest` module with the blink module as argument.

```shell
python -m unittest mch2022.blink
```

## TL;DR
MAKE BADGE BLINK NOW!!!11!!111!
```shell
# install required OS packages (choose your flavor)
# Debian
sudo apt install yosys fpga-icestorm nextpnr libusb
# Arch (AUR)
sudo yay -S yosys icestorm-git  nextpnr-git libusb

# get examples and mch2022-tools
git clone --recurse-submodules https://github.com/cyber-murmel/mch2022-amaranth-examples.git
cd mch2022-amaranth-examples

# install required python packages
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip --requirement requirements.txt

# set environment variable
export WEBUSB_FPGA=$PWD/mch2022-tools/webusb_fpga.py

# test badge
python -m amaranth_boards.mch2022
```
