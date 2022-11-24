.. role:: bash(code)
   :language: bash

Introduction to the ChipFlow platform
=====================================

Preparing your local environment
--------------------------------

* `Poetry must be installed <https://python-poetry.org/docs/#installation>`_, which will be used to install the Python dependencies. 
   .. note::
     If you choose to install ``poetry`` within a venv, ``poetry`` will reuse 
     that venv instead of creating a new one, so you should ensure that its 
     version of Python is compatible with the requirements of this project 
     in ``./pyproject.toml``.

* `Docker <https://docs.docker.com/get-docker/>`_  (or `podman <https://podman.io/getting-started/installation>`_) should be available, it's used for the `dockcross <https://github.com/dockcross/dockcross>`_ builds.

* `openFPGAloader is required <https://trabucayre.github.io/openFPGALoader/guide/install.html>`_ to use a board.
   * macOS: Easiest way is :bash:`brew install openfpgaloader`.
   * Linux/Windows: Easiest way may be via the `OSS CAD Suite <https://github.com/YosysHQ/oss-cad-suite-build>`_.

* Clone this repository to your local environment.

* Run :bash:`make init` to install the dependencies.

The example project
-------------------

The project contains:

* ``.gitlab-ci.yml`` - Runs linting and tests in GitLab CI.
* ``chipflow.toml`` - Congiuration telling the ChipFlow library how to load your Python design and allows you to configure the ChipFlow platform.
* ``Makefile`` - Contains helpful shortcuts to the CLI tools used in the project.
* ``my_design/chipflow.py`` - Used as a loader by the ChipFlow platform for the design.
* ``my_design/design.py`` - This has the actual chip design.
* ``my_design/my_contexts/*`` - These contexts control how your design will be presented to the ChipFlow contexts, ``simulation``(ulation), (FPGA)``board`` and ``silicon``.
* ``my_design/sim/*`` - The C++ and `doit build file <https://pydoit.org/>`_ which builds the binary which will simulate our design.
* ``my_design/software/*`` - The C++ and `doit build file <https://pydoit.org/>`_ for the software/BIOS which we will load onto our design when it's running in simulation or on a board.
* ``tests/*`` - This has some pytest integration tests which cover the sim/board/silicon builds.

The design
----------

The chip design is contained within the `MySoC` class in ``my_design/design.py``, and is described 
using the `Amaranth hardware definition language <https://github.com/amaranth-lang/amaranth>`_.

Something a bit unusual about the design is that we have to change how some of the 
peripherals are physically accessed, according to the context the design is being 
used in .

For example, here's where we add ``QSPIFlash`` to our design:

.. code-block:: python

    self.rom = SPIMemIO(
        flash=self.load_provider(platform, "QSPIFlash").add(m)
    )

The implementations, which are provided by ChipFlow, look a bit different for each context:

QSPIFlash for a Board
~~~~~~~~~~~~~~~~~~~~~

For a board, in our case a ULX3S board, we need a means of accessing the clock pin (``USRMCLK``) and buffer primitives (``OBZ``, ``BB``) to access the other pins:

.. code-block:: python

        flash = QSPIPins()

        plat_flash = platform.request("spi_flash", dir=dict(cs='-', copi='-', cipo='-', wp='-', hold='-'))
        # Flash clock requires a special primitive to access in ECP5
        m.submodules.usrmclk = Instance(
            "USRMCLK",
            i_USRMCLKI=flash.clk_o,
            i_USRMCLKTS=ResetSignal(),  # tristate in reset for programmer accesss
            a_keep=1,
        )
        # IO pins and buffers
        m.submodules += Instance(
            "OBZ",
            o_O=plat_flash.cs.io,
            i_I=flash.csn_o,
            i_T=ResetSignal(),
        )
        # Pins in order
        data_pins = ["copi", "cipo", "wp", "hold"]

        for i in range(4):
            m.submodules += Instance(
                "BB",
                io_B=getattr(plat_flash, data_pins[i]).io,
                i_I=flash.d_o[i],
                i_T=~flash.d_oe[i],
                o_O=flash.d_i[i]
            )
        return flash

This is specific to the ECP5 family of boards, and the code would look different for others.

QSPIFlash for Simulation
~~~~~~~~~~~~~~~~~~~~~~~~

For simulation, we add a C++ model which will mock/simulate the flash:

.. code-block:: python

    flash = QSPIPins()
    m.submodules.flash = platform.add_model("spiflash_model", flash, edge_det=['clk_o', 'csn_o'])
    return flash

QSPIFlash for Silicon
~~~~~~~~~~~~~~~~~~~~~

For Silicon we just hook up the IO.

.. code-block:: python

    flash = QSPIPins()
    platform.connect_io(m, flash, "flash")
    return flash


Run the design in simulation
----------------------------

Running our design and its software in simulation allows us to loosely check 
that it's working. 

First we need to build a local simulation binary. The simulation uses 
blackbox C++ models of external peripherals, such as the flash, to interact 
with:

.. code-block:: bash

    make sim-build

After running this, we will have a simulation binary at ``build/sim/sim_soc``. 

We can't run it just yet, as it needs the software/BIOS too. To build the 
software we run:

.. code-block:: bash

    make software-build

Now that we have our simulation binary, and a BIOS, we can run it:

.. code-block:: bash

    make sim-run

You should see console output like this:

.. code-block:: bash

 🐱: nyaa~!
 SoC type: CA7F100F
 SoC version: 43D6A2C3
 Flash ID: CA7CA7FF
 Entering QSPI mode
 Zeroing initial RAM...
 Kernel: 00800000
 DTB: 00F80000
 DTB magic: FFFFFFFF
 about to boop the kernel, ganbatte~!

Run the design on a ULX3S board
-------------------------------

We can also run our design on an FPGA board, currently only the ULX3S is supported.

First we need to build the design into a bitstream for the board:

.. code-block:: bash

    make board-build

This will write a file ``build/top.bit``. As for the simulation, we need the 
software/BIOS too. 

If we haven't already, build the bios:

.. code-block:: bash

    make software-build

Now, we load the software/BIOS and design onto board (program its bitstream):

.. code-block:: bash

    make board-load-software-ulx3s
    make board-load-ulx3s

Your board should now be running. For us to check that it's working, we can 
connect to it via its serial port:

Connecting to your board on macOS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Find the serial port for your board, using :bash:`ls /dev/tty.*` or :bash:`ls /dev/cu.*`. 
  You should see something like ``/dev/tty.usbserial-K00219`` for your board.
* Connect to the port via the screen utility, at baud ``112200``, with the command:
  :bash:`screen /dev/tty.usbserial-K00219 115200`.
* Now, press the ``PWR`` button on your board, which will restart the design.
* Within ``screen``, you should now see output like:
   .. code-block:: bash

     🐱: nyaa~!
     SoC type: CA7F100F
     SoC version: B79C1FD7
     Flash ID: EF401800
     Entering QSPI mode
     Zeroing initial RAM...
     Kernel: 00800000
     DTB: 00F80000
     DTB magic: FFFFFFFF
     about to boop the kernel, ganbatte~!

* To exit screen, use ``CTRL-A``, then ``CTRL-\``.


Silicon! 
--------

When you want to go to silicon for your design, the ChipFlow API gets involved.

First we build an `RTLIL file <https://en.wikipedia.org/wiki/Register-transfer_level>`_, 
which describes the design as registers and gates.

.. code-block:: bash

    make silicon-rtlil

You should now have an `build/my_design.rtlil`.

Send your RTLIL to the ChipFlow cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At this point, we'll send the RTLIL along with configuration to the ChipFlow 
API. 

Within the ChipFlow platform, we will place & route the design for the chosen 
ASIC technologies, perform silicon-focused checks on the design, and provide 
information about its maximum frequency.

.. code-block:: bash

    make send-to-chipflow
