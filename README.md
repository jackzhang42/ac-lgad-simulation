# AC-LGAD simulation

a place for storing AC-LGAD simulation codes.
Please note that the directory structure does **NOT** necessarily reflect the real case.

## TCAD codes

Most of the codes here correspond to command files(.cmd) of TCAD tools used in the TCAD project.
For example, *sprocess_fps.cmd* is the command file for TCAD tool sprocess.
Some other .cmd file has a user-revised name different from TCAD default one, such as *inspect_IV_ins.cmd*, 
and they will be explained below in the desciption of Tool flow.

### 2D simulation

The workflow is:

sprocess &rarr snmesh &rarr sdevice &rarr inspect(inspect\_trans) &rarr inspect(inspect\_IV)

The name in () is the tool's label name and should match their command file name.

Here,

* sprocess defines the 2D AC-LGAD structure and doping profile;
* snmesh remeshes the previously-generated structure for different use;
* sdevice biases the device to working voltage condition, can run a heavyion signal simulation, and generates the dynamic weighting fields as well as the drift electric field;
* inspect\_trans draws a simple plot for heavyion signal of different AC pads;
* inspect\_IV draws a simple plot for the IV curve of the device.
### 3D simulation

The workflow is:

sprocess &rarr sde(sde\_for\_idealize) &rarr sde &rarr snmesh &rarr snmesh(snmesh1) &rarr sdevice

The name in () is the tool's label name and should match their command file name.

Here,

* sprocess defines the 2D AC-LGAD structure and doping profile;
* sde(sde\_for\_idealize) generates the same bnd.tdr file of sprocess, which is pure geometrical compared to sprocess-generated non-uniform edge;
* sde generates the 3D geometrical structure of AC-LGAD by sweeping and rotating 2D bnd.tdr file;
* snmesh and snmesh(snmesh1) together generates the 3D doping profile of AC-LGAD by sweeping and rotating 2D fps.tdr file. The usage of 2 consistent snmesh is due to an unknown bug which makes the output strange, and by changing the logic of the certain bug-like action it can be solved for current 2-step 3D transformation;
* sdevice biases the device to working voltage condition and can run a heavyion signal simulation. Please note that the command file is severely outdated and should be revised according to the latest 2D sdevice command file.

## Garfield++ codes

### run in local

### submit jobs using condor

