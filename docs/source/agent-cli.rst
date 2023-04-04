[_metadata_:title]:- "Nimbus Command Line Interface"
[_metadata_:date]:- "Aug 2 2021"
[_metadata_:description]:- "Managing Nimbus through the command line interface."

[Nimbus](index.md)> CLI

- [The Nimbus agent CLI](#the-nimbus-agent-cli)
  - [Overview](#overview)
  - [The Nimbus agent](#the-nimbus-agent)
  - [Nimbus system help menu](#nimbus-system-help-menu)
  - [Session manager](#session-manager)
    - [List current sessions](#list-current-sessions)
    - [List local host addresses for direct access to platform](#list-local-host-addresses-for-direct-access-to-platform)
  - [Platform manager](#platform-manager)
    - [Find connected devices](#find-connected-devices)
    - [Query a specific device by ID](#query-a-specific-device-by-id)
    - [Query memory usage](#query-memory-usage)
  - [Configuration manager](#configuration-manager)
    - [Saving a configuration locally](#saving-a-configuration-locally)
    - [Uploading a configuration to Nimbus cloud](#uploading-a-configuration-to-nimbus-cloud)
  - [System manager](#system-manager)
    - [Show Nimbus system status](#show-nimbus-system-status)
    - [Monitor the Nimbus system](#monitor-the-nimbus-system)
  - [Analytics manager](#analytics-manager)
    - [Display computing resources in use by configuration](#display-computing-resources-in-use-by-configuration)
    - [Display computing resources used by a named component](#display-computing-resources-used-by-a-named-component)
  - [Components manager](#components-manager)
    - [Component environments](#component-environments)
  - [Device manager](#device-manager)
    - [Create a new device using usb-id](#create-a-new-device-using-usb-id)
    - [Find existing devices on the robot](#find-existing-devices-on-the-robot)
    - [Push a new device to Nimbus](#push-a-new-device-to-nimbus)
  - [Streams manager](#streams-manager)
    - [Echo data from a stream to the terminal](#echo-data-from-a-stream-to-the-terminal)
    - [Publish data to a component`s stream](#publish-data-to-a-components-stream)
    - [Query an active stream](#query-an-active-stream)
  - [Storage manager](#storage-manager)
  - [Parameters manager](#parameters-manager)
    - [Show a component's parameters](#show-a-components-parameters)
    - [Show the value for a parameter](#show-the-value-for-a-parameter)
  - [Data log manager](#data-log-manager)
    - [Start and stop recording stream from a component](#start-and-stop-recording-stream-from-a-component)
    - [List stream recordings](#list-stream-recordings)
  - [Custom message manager](#custom-message-manager)
  - [ROS1 dynamic parameters manager](#ros1-dynamic-parameters-manager)

# The Nimbus agent CLI

## Overview

Many tasks performed from the Nimbus web graphical user interface (GUI) also can be accomplished through the Nimbus agent command line interface (CLI). The CLI is accessed from a terminal connected (directly or remotely) to the target (robot) platform"s, CPU board, after the Nimbus software is installed and a unique API key has been assigned to the Nimbus agent. This document explains the significance and use of each Nimbus agent command. For each command, one or more use examples are provided

## The Nimbus agent

The Nimbus agent is installed as a remote procedure call (RPC) service on the robot platform. Whether using the Nimbus web GUI or the CLI, user interaction with robots connected to Nimbus Cloud Services is facilitated by the Nimbus agent.

The Nimbus Agent:

- Establishes connection between the platform and Nimbus cloud services
- Installs on the platform the Nimbus agent daemon and application dependencies
- Gathers platform information
- Installs component configurations
- Monitors connected device drivers and algorithms

The procedure for installing the Nimbus agent is explained in [Connecting Your Robot to Nimbus](Creating_Rbot_agent.md).

When the Nimbus agent is installed on the robot platform, the file `nimbus.json` is created in the `/etc/nimbus/` directory. This file stores the agent's credentials, which enables the robot to communicate securely with Nimbus Cloud Services and provide authorized access for teleoperation via [AnyDesk](https://anydesk.com/en). The `nimbus.json` file contains the following, self-explanatory,`"key":"value"` fields (example values are shown).

~~~json
{
  "apiKey": "e6748433-1db9-4c43-b662-1e41dcb9aff6",
  "server": "https://api.cognimbus.com",
  "password": "bdebdc1e-59b",
  "ssh": {
    "id": "tmk-HAk3dPf7sRPDMC5XAecLpvhm6s",
    "password": "ae70cf23-5af6-4866-a39c-fd597ac5913f"
  },
  "anydesk": {
    "id": "251125865",
    "password": "3960f4c7-cd60-4fa5-a7ae-3c50b07a4b01"
  },
  "agentStatusInterval": 30,
  "platformInfoInterval": 30,
  "agentStatsInterval": 5
}
~~~

## Nimbus system help menu

The Nimbus command line help menu provides brief details on the available system commands, arguments, and options. This document aims to provide additional context and explanations for managing Nimbus tasks through the command line.

To access the help menu, on a terminal, enter `nimbus -h`.

Nimbus system commands are classified under the ten categories listed in the table, below. Commands within each category are explained in the subsequent sections.

| Command                                 | Function               |
| --------------------------------------- | -----------------------|
| [session](#session-manager)             | Session manager        |
| [platform](#platform-manager)           | Platform manager       |
| [config](#configuration-manager)        | Configuration manager  |
| [system](#system-manager)               | System manager         |
| [analytics](#analytics-manager)         | Analytics manager      |
| [comp](#components-manager)             | Components manager     |
| [device](#device-manager)               | Device manager         |
| [stream](#streams-manager)              | Stream manager         |
| [storage](#storage-manager)             | Storage manager        |
| [param](#parameters-manager)            | Parameters manager     |
| [datalog](#data-log-manager)            | Data log manager       |
| [msg](#custom-message-manager)          | Custom message manager |
| [dynparam](#dynamic-parameters)         | ROS1 dynamic parameters manager|

## Session manager

The `nimbus session` command displays details of an active Nimbus session. A session is active when a robot with the Nimbus agent installed is connected with Nimbus Cloud Services.

Usage: `nimbus session [list] [local]`


| Command | Options | Arguments | Response                                                     |
| ------- | ------- | --------- | ------------------------------------------------------------ |
| list    | None    | None      | Displays a list of active sessions and endpoints.            |
| local   | None    | None      | For enabling direct control (bypassing Nimbus Cloud Services) the `local` comand displays the platform's available host URI addresses, open ports, and SSH password. |

The following subsections present examples of typical output from two frequently used `nimbus session` commands - `list` and `local`.

### List current sessions

The command `nimbus:~$ nimbus session list` list the current Nimbus sessions.

**Example output:**

~~~bash
Session name  Endpoint                   Status     Message
webapi        https://api.cognimbus.com  Active     Session started
~~~

### List local host addresses for direct access to platform

The `nimbus session local` command displays a list of available local host URIs and the SSH password. These are used to connect to the robot without the need to connect through Nimbus Cloud. This can be advantageous where very low latency is important.

Typical response:

~~~bash
Possible addresses:
[http://127.0.0.1:19992](http://127.0.0.1:19992/)
[http://192.168.1.53:19992](http://192.168.1.53:19992/)
[http://172.17.0.1:19992](http://172.17.0.1:19992/)
[http://172.133.0.1:19992](http://172.133.0.1:19992/)

Password:
bdebdc1e-59b
~~~

## Platform manager

The `nimbus platform` commands provide information on:

- Connected devices
- Device specifications
- Current memory usage

Usage:  `nimbus platform [command] [options] [arguments]`

| Command    | Options | Arguments | Action / Response                                            |
| ---------- | ------- | --------- | ------------------------------------------------------------ |
| `wifi`     | None    | None      | Lists the status of Nimbus system installed on the robot. Verifies whether the robot is connected. |
| `battery`  | None    |       | Shows battery level                                             |
| `usb`      | None    |       | List IDs of connected USB devices, with basic details           |
| `usb-info` | None    | usb-id| Shows full details for a connected USB device with specific ID  |
| `memory`   | None    |       | Shows RAM memory usage  and swap data                           |
| `system`   | None    |       | Shows operating system details                                  |
| `cpu`      | None    |       | Shows CPU usage (%)                                             |
| `network`  | None    |       | Shows details of local networks traffic data for active ports   |
| `disk`     | None    |       | Shows directories with disk allocation and throughput statistics|
| `thermal`  | None    |       | Shows main processor temperature (Celsius)                      |
| `ros-version`  | None| None  | Lists installed ROS versions                                    |
| `vendor name`  | None| None  | Shows motherboard vendor's name                                 |
| `computer-name`| None| None  | Shows computer's hostname (equivalent to `hostnamectl` command) |
| `cuda-version` | None| None  | Shows the Nvidia CUDA toolkit version (if installed)            |

The following subsections present examples of typical output from three frequently used `nimbus platform` commands: `usb`, `usb-info`, and `memory`.

### Find connected devices

The command `nimbus platform usb` lists all available USB connected devices.

**Example output:**

~~~bash
Id        Type   Vend  Prod  Name               Manufacturer                Port
a8e659aa  camera 04f2  b6d9  Integrated Camera  Chicony Elect Co. /dev/video0,/dev/video1
~~~

### Query a specific device by ID

The command `nimbus platform usb-info <usb-id>` outputs full details of the connected device.

**Example output:**

~~~bash
id : <a8e659aa>
type : Camera,
product-id : b6d9
revision : 2699
serial : 0001
vendor-name : Chicony Electronics Co.,Ltd.
product-name : Integrated Camera
attributes : [

DEVPATH : /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/video4linux/video1
DEVNAME : /dev/video1
MAJOR : 81
MINOR : 1
SUBSYSTEM : video4linux
USEC_INITIALIZED : 6491879
ID_V4L_VERSION : 2
ID_V4L_PRODUCT : Integrated Camera: Integrated C
ID_V4L_CAPABILITIES : :
ID_VENDOR : Chicony_Electronics_Co._Ltd.
ID_VENDOR_ENC : Chicony\x20Electronics\x20Co.\x2cLtd.
ID_VENDOR_ID : 04f2
ID_MODEL : Integrated_Camera
ID_MODEL_ENC : Integrated\x20Camera
ID_MODEL_ID : b6d9
ID_REVISION : 2699
ID_SERIAL : Chicony_Electronics_Co._Ltd._Integrated_Camera_0001
ID_SERIAL_SHORT : 0001
ID_TYPE : video
ID_BUS : usb
ID_USB_INTERFACES : :0e0100:0e0200:
ID_USB_INTERFACE_NUM : 00
ID_USB_DRIVER : uvcvideo
ID_PATH : pci-0000:00:14.0-usb-0:8:1.0
ID_PATH_TAG : pci-0000_00_14_0-usb-0_8_1_0
ID_FOR_SEAT : video4linux-pci-0000_00_14_0-usb-0_8_1_0
COLORD_DEVICE : 1
COLORD_KIND : camera
DEVLINKS : /dev/v4l/by-id/usb-Chicony_Electronics_Co._Ltd._Integrated_Camera_0001-video-index1 /dev/v4l/by-path/pci-0000:00:14.0-usb-0:8:1.0-video-index1
TAGS : :seat:uaccess:
]
~~~

### Query memory usage

~~~bash
nimbus platform memory
~~~

**Example output:**

~~~bash
 total memory: 15692
 Used memory: 4735
 Available memory: 3935
 total swap: 2047
 Used swap: 0
 available swap: 2047
~~~

## Configuration manager

The `nimbus config` group of commands allows you to:

- provide information on the current configuration of devices and components attacurations
- Load or unload a configuration to/from a robot platform
- Download or upload configurations from/to Nimbus Hub
- Add new configurations
- List details of user-defined configurations
- Switch the currently loaded configuration for a different one
- Display configuration version changes

A Nimbus configuration is encoded in a JSON file that specifies the parameter values for four object types:

- **Devices** - the mapping of physical connections among devices and the placement of devices relative to the robot platform
- **Drivers** - the software used by Nimbus to communicate with and enable the functionality of connected devices
- **Components** - the software (algorithms) that provide functionality to devices
- **Streams** - the data transfer connections among devices and components

Usage: `nimbus config [command] [options] [arguments]`

| Command      | Options | Arguments          | Action / Response                                       |
| ------------ | ------- | ------------------ | ------------------------------------------------------- |
| `show`   | None    | None               | Displays the current configuration status, name, and version        |
| `save`   | None | None | Saves the current configuration                         |
| `load`   | None    | None               | Loads the current configuration                |
| `unload` | None | None | Unloads the current configuration |
| `upload` | None    | None               | Uploads the current configuration to Nimbus Hub         |
| `download`| None    | `configuration-name` | Downloads a configuration from Nimbus Hub               |
| `new`    | `--version` | `configuration-name` | Adds a new configuration. <br> The `--version` option default value is `1.0.0-default` |
| `list`   | None    | None               | Displays list of  user-generated configurations |
| `switch` | None    | `configuration-name` | Switches to another (specified) configuration                     |
| `log`    | None    | None               | Displays log of configuration version changes           |

The following subsections present examples of typical output from three frequently used `nimbus config` commands: `save` and `upload`.

### Saving a configuration locally

To save a configuration on the robot platform, from a terminal, enter the following command.

~~~bash
nimbus config save
~~~

Upon execution the response is:

~~~bash
configuration saved successfully
~~~

Saving a configuration permanently sets the current configuration on the robot.

A configuration is persistent on platform reboot.

### Uploading a configuration to Nimbus cloud

Saving a configuration returns the current configuration to the Nimbus Cloud and enables it to be restored in the future. This is the complementary action to "Deploy configuration" from the cloud.

To return the current configuration to Nimbus Cloud, from a terminal, enter the following command.

~~~bash
nimbus config upload
~~~

Upon execution the response is:

~~~bash
configuration uploaded successfully
~~~

## System manager

The `nimbus system` group of commands allows you to:

- Interrogate the current status of the Nimbus system installation in robot (`status`)
- View all events since the Nimbus agent was installed in the robot (`log`)
- Upgrade a Nimbus subscription plan (`upgrade`)
- Display the Nimbus agent installation command, including the API key (`link`)
- Enables a the installed agent to accept a new API key (`login`)

Usage:  `nimbus system [command] [arguments]`

| Command       | Options | Arguments            | Action / Response                                     |
| ------------- | ------------- | -------------------------- | ------------------------------------------------------------ |
| `status`  | None | None                   | Displays the current status of Nimbus system installed on the robot (version number, configuration name). Indicates whether the robot is connected to Nimbus Cloud Services. |
| `upgrade` | None | None | Upgrades the Nimbus agent to the latest version |
| `link`    | None | None                   | Displays the Nimbus system install command and agent API key |
| `login <api-key>` | None | `api-key` | Connect success / Failed to authorize |
| `uninstall` | None | None | Uninstalls the Nimbus agent |
| `prune` | None | None | Cleans up the nimbus agent files installation. Indicates reclaimed memory. |
|`log` | None |None |Displays a history of system events for the platform in which the agent is installed. |

The following subsections present examples of typical output from two frequently used `nimbus system` commands - `status` and `log`.

### Show Nimbus system status

The following command entered on the terminal displays information on the current status of a connected robot.

~~~bash
nimbus system status
~~~

**Example output:**

~~~bash
state: Ready
pid: 28555
xec: /usr/bin/nimbusd
ersion: 1.0.0-7(Available:1.0.0-Initial)
onfig: ROB-1-default (v1.0.1-1)
ptime: 2:8:36
~~~

### Monitor the Nimbus system

The following command entered on the terminal lists a history of system events for platform in which the agent is installed.

~~~bash
nimbus system log
~~~

**Example output:**

~~~bash
19/2/2021 05:40:23  Component  Starting Ros1Component [Laptop-cam] component
19/2/2021 05:40:24  Environment  Starting docker [cognimbus/usb-cam:latest] environment
19/2/2021 05:40:25  Environment  Environment docker [cognimbus/usb-cam:latest] started
19/2/2021 05:40:28  Component  Component Ros1Component [Laptop-cam] started
19/2/2021 05:40:28  Configuration  Configuration test-robot-default v1.0.5 loaded
19/2/2021 05:40:56  Component  Stopping Ros1Component [Laptop-cam] component
19/2/2021 05:40:57  Environment  Stopping docker [cognimbus/usb-cam:latest] environment
19/2/2021 05:40:59  Environment  Environment docker [cognimbus/usb-cam:latest] stopped
19/2/2021 05:40:59  Component  Component Ros1Component [Laptop-cam] stopped
~~~

## Analytics manager

The `nimbus analytics` group of commands enable you to inspect computing resources usage for individual connected components and the configuration as a whole.

Usage: `nimbus analytics [command] [options] [arguments]`

| Command     | Options                                                  | Arguments                      | Action / Response                                            |
| ----------- | -------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------ |
| `data`  | None                                                     | None                           | Display total system resource data for current configuration                           |
| `component-data` | None                                                     | `component-name`               | Display system resource data for  named component                                           |
| `list`      | None | None | List system resource data for each connected component  |

The following subsections present examples of typical output `nimbus analytics` commands: `data` and `component_data`.

### Display computing resources in use by configuration

**Example output:**

~~~bash
nimbus> nimbus analytics data
CPU%   MEM%   Storage%  Network   creation date          Online time  Offline Time  Active Time  Idle Time             Battery%  
10.00% 42.12% 19.14%    53.983 MB 11/25/2021 12:26:20 PM -            -             -            11/25/2021 1:02:22 PM 0    -            11/25/2021 1:02:22 PM 0    
~~~

### Display computing resources used by a named component

~~~bash
nimbus> nimbus analytics component_data realsense-t265
CPU%    MEM%    Docker Size Network   Active Time Idle Time Error Time
0.00 %  2.20 %  1.63GB      16.444 MB 00:01:30    00:00:13  -  
~~~

## Components manager

The `nimbus comp` group of commands enable you to:

- Display details on the current configuration
- Start and stop (turn on and off) components
- Attach and detach components from devices

Usage: `nimbus comp [command] [options] [arguments]`

| Command     | Options                                                  | Arguments                      | Action / Response                                            |
| ----------- | -------------------------------------------------------- | ------------------------------ | ------------------------------------------------------------ |
| `list`  | None                                                     | None                           | List the currently configured components                           |
| `start` | None                                                     | `component-name`               | Turns on a component                                           |
| `show`      | None                                                     | `component-name`               | Displays a component's details                                 |
| `stop`      | None                                                     | `component-name`               | Turns off a component                                          |
| `delete`    | None                                                     | `component_name`               | Removes a component from the configuration           |
| `attach`    | None                                                     | `component-name` <br> `device-name`| Attaches a component to a device. Device name optional      |
| `detach`| None                                                     |`component-name`<br>`device_name`| Detaches a component from a device. Device name optional    |
| `env`| None                                                     | None                           | Displays environment information (e.g., Docker) for each component in the current configuration |
| `stats`| None                                                     |`component-name`| Displays CPU load, memory usage, and network traffic volume for the component                 |
| `push`|`--name` <br> `--category` <br> `--public` <br> `--plugin`|path (to component json file) | Uploads a component's json definition file to the server |
| `pull`| None                                                     |`component-name`| Downloads a component's definition json file from the server |
| `local`| None                                                     | None                           | Displays details of local (e.g., native ROS) components |
| `UploadLog` | None                                                     | `component-name`| Uploads component's streams to the server                                                             |
| `new`| --json --type  --tag             --className --version | unique name                    | Installs a new component                                     |
| `log`| None                                                     |`component-name`               | Displays environment log                                     |

### Component environments

In nimbus, components are executed within their own environment. For example, ROS projects can be executed either locally or from inside a Docker container. For dockerized environments, projects are launched with their own ROS Master and additional software application dependencies, all of them running inside the Docker container.

To display the component environment settings, from a terminal enter:

~~~bash
 nimbus comp env
~~~

~~~bash
cb294983c054 172.133.0.2  cognimbus/usb-cam:latest(1.51GB)[ "roslaunch","usb_cam_clear.launch","width:=${width}","height:=${height}","fps:=${fps}","pixel_format:=${pixel_format}","io_method:=${io_method}"] docker started
~~~

The following command outputs specifications and the executable environment for a named component.

~~~bash
nimbus comp show <instance_name>
~~~

Example output (where the instance_name is generic-webcam-driver ):

~~~bash
name:  nimbus/generic-webcam-driver
instance name:  Laptop-cam
class:  Ros1Component
type:  Component
description:  Generic webcam driver
version:
state:  Unloaded

Environment:
type: docker
image: cognimbus/usb-cam:latest

Input streams:
None

Output streams:
image  Nimbus.Core.Messages.Ros1.Messages.sensor_msgs.CompressedImage

parameters:
width: 424
height: 240
fps: 30
pixel_format:  yuyv
io_method:  userptr
frame_id:  front-camera
frame_id:  front-camera

required device :
Requirements  Mount as  Attached device
camera [Type=Camera]/dev/video0  front-camera [/dev/video0]
~~~

## Device manager

The `nimbus device` group of commands allows you to

- Create new device instances
- List currently attached devices
- Delete (remove) devices
- Rename device name instances
- Set device IP addresses

A Nimbus device is the mapping of sensor physical connection (ports) and placement (position,orientation) relative to the robot. In order to run a nimbus component that communicates with a physical device(a driver), a nimbus device needs to be created.

Usage: `nimbus device [command] [options] [arguments]`

| Command      | Options                                       | Arguments         | Action / Response                 |
| ------------ | --------------------------------------------- | ----------------- | --------------------------------- |
| `new`    | `--usb-id` <br>`--port-index` <br>`--vid`, <br>`--type` <br>`--ip` | `device-name` <br>`pose` | Creates new device instance       |
| `list`   | None                                          | None              | Lists details of attached devices |
| `delete` | None                                          | `device-name`     | Removes device                    |
| `push`   | `--new_name` <br>`--public`                     | `new_name` <br>`public` | Renames device instance           |
| `set`    | `--ip`                                        | device-name       | Assigns the device's IP address   |

### Create a new device using usb-id

In the example script below, a new device, which is connected a USB port with ID a8e659aa is assigned the name "front-camera".

~~~bash
nimbus device new front-camera --usb-id a8e659aa
~~~

The other options listed in the table specify that the new device is to be connected to a specific port (--port-index), whether it is a serial or parallel port (--type), and the device's IP address.

### Find existing devices on the robot

~~~bash
 nimbus device list
~~~

**Example output:**

~~~bash
Instance Name  Id  Type  Vend  Prod  Name  Manufacturer  Connected  Position  Orientation  Ports
front-camera  camera 04f2  b6d9  True 0,0,0 0,0,0 /dev/video0,/dev/video1
~~~

### Push a new device to Nimbus

Pushing a new device to Nimbus renames the device instance. In the following example, a webcam device whose current instance name is lenovo integrated-camera is renamed to front-camera.

~~~bash
 nimbus device push front-camera --new_name lenovo-integrated-camera
~~~

## Streams manager

The `nimbus stream` group of commands enables you to:

- List input and output stream connections between components and devices
- Connect and disconnect input and output streams
- Upload stream data to the server

Usage: `nimbus stream [command] [options] [arguments]`

| Command      | Options | Arguments                                                    | Action / Response                                            |
| ------------ | ------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `ls`         | None    | None                                                         | Lists inputs and outputs of connected streams               |
| `connect`    |         | `source-component-name` `output-stream-name` <br> `target- component-name` <br> `input-stream-name` | Connects stream between component input and output  terminals |
| `disconnect` | None    | `source-component-name`                                       | Disconnects stream between two components                    |
| `info`   |         |                                                              | Stream                                                       |
| `upload`     | None    | `component-name` `stream-name`                                   | Uploads stream to server                                     |
| `download`   | None    | `source-component-name` `output-stream-name` <br> `target- component-name` <br> `input-stream-name` | Connects remotely separated components                       |
| `pub`       |`--rate`    | `component-name` `stream-name` `message`                                  | Publishes data (`message`) to a stream. <br> `message` must be in JSON format. <br> The publishing update rate (Hz) is set by the `--rate` option.                       |
| `echo`       | None    | `component-name` `stream-name`                                   | Outputs specified stream to terminal                         |

The following subsections present examples of typical output `nimbus stream` commands: `echo` and `pub`.

### Echo data from a stream to the terminal

The following command sends stream data from a component to the terminal (stdout).

~~~bash
nimbus stream echo <component_name> <stream_name>
~~~

**Example output:**

The following command echos to the terminal (in JSON format) the value `true` of the Boolean variable `data`, from the `move_to_next_point` input stream of the `waypoint-navigation` component.

~~~bash
nimbus stream echo waypoints-navigation move_to_next_point
{ "message": "{ \"data\": true }" }

---
~~~

### Publish data to a component`s stream

The following command publishes a message, in JSON format, to a component.

~~~bash
nimbus stream pub <component_name> <stream_name>
~~~

**Example output:**

The following command publishes the value `Th4` of the string variable `data` to the `message` output stream of the `tutorials-listener` component. The `echo` command then reproduces the stream output at terminal.

~~~bash
nimbus stream pub tutorials-listener message '{ "data": "Th4"  }'
nimbus stream echo tutorials-listener message
{ "message": "{ \"data\": \"Th4\" }" }

~~~

### Query an active stream

~~~bash
nimbus stream info <component_name> <stream_name>
~~~

**Example output:**

~~~bash
nimbus stream info Laptop-cam image
~~~

~~~bash
Name:  image
Type:  Nimbus.Core.Messages.Ros1.Messages.sensor_msgs.CompressedImage
Stats:
Rate : 10.00 hz
Total-messages : 25828
Bandwidth : 23.48 kb/s
Total-bandwidth : 63554322 bytes
~~~

## Storage manager

Nimbus uses a serverless NoSQL database, such as LiteDB , to store the data processed by the agent: configurations, streams, logs, and so on.

The `nimbus storage` command displays the following information:

- The database system type
- The database status
- The full path to the database file
- The volume of data currently stored

This command has no subcommands, options, or parameters.

Typical output:

~~~bash
 name: LiteDb
 state: Ready
 path: /var/lib/nimbus/nimbus_litedb.db
 size: 23324432 Bytes
~~~

## Parameters manager

The `nimbus param` group of commands allows you to list, set, extract, and display details of a component's parameters.

Usage: `nimbus device [command] [arguments]`

| Command    | Options | Arguments                                                    | Action / Response                       |
| ---------- | ------- | ------------------------------------------------------------ | --------------------------------------- |
| `list` | None    | unique `component-name`                                        | Shows all of the component's parameters |
| `set`  | None    | unique `component-name` <br> unique `parameter-name` <br>`parameter-value` | Sets the component parameter values               |
| `get`  | None    | unique `component-name` <br>unique `parameter-name`              | Shows the value for a specified parameter of a component |
| `info` | None    | unique `component-name` <br> unique `parameter-name`                                        | Shows component parameter details       |

The following subsections present examples of typical output from two frequently used `nimbus param` commands: `list` and `get`.

### Show a component's parameters

`nimbus param list <component_name>`

**Example output:**

~~~linux
nimbus> nimbus param list NB_webcam
  Name          Type     Value    Min limit  Max limit  Step size  
  width         Integer  640       -          -          -        
  height        Integer  480       -          -          -        
  fps           Double   15        -          -          -        
  pixel_format  String   yuyv      -          -          -        
  io_method     String   userptr   -          -          -        
  quality       Integer  40        -          -          -        
~~~~

### Show the value for a parameter

`nimbus param get <component_name>`
~~~linux
nimbus> nimbus param get NB_webcam quality
🉑 40
~~~~

## Data log manager

| Command   | Options | Arguments | Action / Response |
| --------- | ------- | --------- | ----------------- |
| `record`  | `--rate`     |  `component-name` <br> `stream-name`      | Records component's stream. <br>The `--rate` option accepts a value specifying the recording rate. |
| `stop`    | `--rate` | `component-name` <br/>`stream-name` | Stops recording the specified stream |
| `recorders` | None | None | Shows details of active recorders |
| `streams` | None | None | Shows streams database details |
| `list`    | None | None | Shows list of all existing recordings |
| `info`    |         | `full_path_to_database` | Show details on a specified recording |
| `delete`  |  | `file-name` | Deletes specified recording file |
| `play`    | `--file` | `full-path-to_file` | Plays a specified recording file. <br>The `--file` option (default `FALSE`) sets the path to the current directory.

The following subsections present examples of typical output from two frequently used `nimbus datalog` commands: `record`, `stop`, and `list`.

### Start and stop recording stream from a component

`nimbus datalog record <component_name> <stream_name>`  
`nimbus datalog stop <component_name> <stream_name>`

**Example output:**

~~~~bash
nimbus> nimbus datalog record realsense-t265 gyro
🉑 Recording gyro+/realsense-t265
nimbus> nimbus datalog stop realsense-t265 gyro
🉑 Stop recording gyro+/realsense-t265
~~~~

### List stream recordings

~~~bash
nimbus> nimbus datalog list
Name                                            Size(Bytes)  
nimbus_stream_litedb-04.7.2021-03:44:44-log.db  65536        
nimbus_stream_litedb-04.7.2021-03:44:44.db      65536        
~~~~

## Custom message manager

The `nimbus stream` group of commands enables you to:

- Specify the file name and path for a custom ROS1 `.msg` file and the path of the build directory.
- Push or pull a custom ROS1 message package to/from Nimbus
- List all ROS1 custom message packages
- Search custom message packages by message type name

Usage: `nimbus msg [command] [options] [path]`

| Command   | Options | Arguments | Action / Response |
| --------- | ------- | --------- | ----------------- |
| `build`  | `--namespace` [default: name of the current directory] <br> `--output` - [default: the `build/` directory in the current working directory   | `<path>` [default: current working directory of CLI]    |  Takes a user-created text file and builds a custom ROS1 message.  |
| `push` | `--name` <br> `--description` <br> `--public` [default: false]| `<path>` to message package| Pushes ROS1 message package to Nimbus |
| `pull` | `--version`| `<packageName>` | Pulls ROS1 message package from Nimbus |
| `list` | None]| None| List all ROS1 custom message packages |
| `search` | None]| None| Search all ROS1 custom message packages |

## ROS1 dynamic parameters manager

Usage: `nimbus dynparam [command] [arguments]`

| Command   | Options | Arguments | Action / Response |
| --------- | ------- | --------- | ----------------- |
|`list`     | None    | `instanceName` <br> `node`      | List component's dynamic parameters |
| `get`     | None    | `instanceName` <br> `node`      | Get component's dynamic parameter values |
| `set`     | None    | `instanceName` <br> `node` <br> <parameterName>  <br> <parameterValue>  | Set component's dynamic parameter value|
