# Introduction to the ChipFlow platform

## Preparing your local environment

 - [Poetry must be installed](https://python-poetry.org/docs/#installation). 
   - Note: If you choose to install `poetry` within a venv, `poetry` will reuse 
     that venv instead of creating a new one, so you should ensure that its 
     version of Python is compatible with the requirements of this project 
     in `./pyproject.toml`.
 - Docker (or podman) should be available, which is used for the 
   [dockcross](https://github.com/dockcross/dockcross) builds.
 - [openFPGAloader is required](https://trabucayre.github.io/openFPGALoader/guide/install.html) to use a board.
   - macOS: Easiest way is `brew install openfpgaloader`.
   - Linux/Windows: Easiest way may be via the [OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build).
 - Clone this repository to your local environment.
 - Run `make init` to install the dependencies.

## Run the design in simulation

First we need to build a local simulation binary. The simulation uses blackbox C++ models 
of external peripherals, such as the flash, to interact with:

```
make sim-build
```

Next we need to build the software/BIOS which will run on our design. The build
of this depends on the design itself.

```
make software-build
```

Now that we have our simulation and a BIOS, we can run it:

```
make sim-run
```

You should see something like this:

![Simulation output](docs/simulation-output.png)

## Run the design on a ULX3S board

Build the design into a bitstream for the board (doesn't load it):

```
make board-build
```

Build the bios, and program BIOS into the board's flash:

```
make software-build
make board-load-software-ulx3s
```

Load SoC onto board (program its bitstream):

```
make board-load-ulx3s
```

Your board should now be running. You can connect to it via its serial port:

### Connecting to your board on macOS

* Find the serial port for your board, using `ls /dev/tty.*` or `ls /dev/cu.*`. 
  You should see something like `/dev/tty.usbserial-K00219` for your board.
* Connect to the port via the screen utility, at baud 112200, with the command:
  `screen /dev/tty.usbserial-K00219 115200`.
* Now, press the `PWR` button on your board, which will restart the design.
* Within screen, should now see output like:
  ![Board output](docs/board-output.png)
* To exit screen, use `CTRL-A`, then `CTRL-\`.


## Generate an RTLIL from your design

```
make silicon-rtlil
```

You should now have an `build/my_design.rtlil`.

## Send your RTLIL to the ChipFlow cloud

```
make send-to-chipflow
```

