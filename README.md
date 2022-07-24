# iCEBreaker amaranth examples

This repository contains examples for the [amaranth HDL](https://github.com/amaranth-lang/amaranth)
Python library for register transfer level modeling of synchronous logic. Ordinary Python code is
used to construct a netlist of a digital circuit, which can be simulated, directly synthesized via
Yosys, or converted to human-readable Verilog code for use with industry-standard toolchains.

## Getting Started
Please follow the [badge Getting Started](https://badge.team/docs/badges/mch2022/getting-started/) first and also install the [udev rules](https://badge.team/docs/badges/mch2022/software-development/#linux-permissions).

Then clone this repository recursively.

```shell
git clone --recurse-submodules https://github.com/cyber-murmel/mch2022-amaranth-examples.git
```

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

Also install `amaranth-boards` from this [pull request](https://github.com/amaranth-lang/amaranth-boards/pull/203), since the MCH2022 badge is not yet part of the official
repository yet.

```shell
python3 -m venv .venv
source .venv/bin/activate

python3 -m pip install --upgrade pip \
  git+https://github.com/amaranth-lang/amaranth-boards.git@fb430ff035cfb7c44af7f1e517e2bf032529577a \
  -r requirements.txt
```

When you are done simply close the shell or run `deactivate` to exit the venv.
You need to run `source .venv/bin/activate` from the root of this repository when you want to use this project in a new terminal window.

#### Nix(OS)
Users of Nix or NixOS can skip the toolchain instructions above and simply run `nix-shell` in the root of this directory to drop into a functional development environment.

### MCH2022 Tools
If you didn't clone this repository recursively, run the following to geth the mch2022-tools.

```shell
git submodule update --init --recursive
```

You must set the `WEBUSB_FPGA` environment variable to the location of the `webusb_fpga.py` script. This must also be done every time you open a new terminal window.
```shell
export WEBUSB_FPGA=./mch2022-tools/webusb_fpga.py
```

### Testing and Usage
After that all you need to do is connect your MCH2022 badge to the computer and run the python script
in an example directory.

To test the toolchain and hardware you can call a board package directly.
```shell
python -m amaranth_boards.mch2022
```
This should make th RGB LED blink white.

The scripts are by default set to synthesize and upload the bitstream to the MCH2022 badge board.

## Warning
Amaranth is still a work in progress project. Expect examples to occasionally break until amaranth
fully stabilizes.

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
python3 -m pip install --upgrade pip \
  git+https://github.com/amaranth-lang/amaranth-boards.git@fb430ff035cfb7c44af7f1e517e2bf032529577a \
  -r requirements.txt

# set environment variable
export WEBUSB_FPGA=./mch2022-tools/webusb_fpga.py

# test badge
python -m amaranth_boards.mch2022
```