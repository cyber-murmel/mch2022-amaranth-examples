import argparse
from .blink import Blinker, Top
from amaranth import *
from amaranth.asserts import *
from amaranth.cli import main_parser, main_runner
from amaranth_boards.mch2022 import MCH2022BadgePlatform


def extra_options():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-b", "--blink-freq", type=float, default=1, help="blink frequency"
    )
    return parser


if __name__ == "__main__":
    parser = main_parser(extra_options())
    args = parser.parse_args()

    plat = MCH2022BadgePlatform()
    top = Top(plat.default_clk_frequency, 1 / args.blink_freq)

    if args.action:
        main_runner(parser, args, top, ports=top.ports)
    else:
        plat.build(top, do_program=True)
