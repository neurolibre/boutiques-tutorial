---
interact_link: content/tutorial.ipynb
kernel_name: python3
has_widgets: false
title: 'Tutorial'
prev_page:
  url: 
  title: ''
next_page:
  url: 
  title: ''
comment: "***PROGRAMMATICALLY GENERATED, DO NOT EDIT. SEE ORIGINAL FILES IN /content***"
---


<img src="http://boutiques.github.io/images/logo.png" alt="logo" width="60" align="left" style="padding:5px;"/>

# Boutiques tutorial


This tutorial will walk you through the main features of Boutiques. Boutiques is a framework to help make tools Findable Accessible Interoperable and Reusable (FAIR). An overview of the framework and its capabilities is available [here](https://figshare.com/articles/fair-pipelines-poster_pdf/8143241), and a more complete description is [here](https://academic.oup.com/gigascience/article/7/5/giy016/4951979). The entry point for our documentation is http://github.com/boutiques.



## Getting Started

Boutiques is available as a Python module on `pip` and can be installed by simply typing `pip install boutiques`. Once Boutiques is installed, the Python and command-line APIs for Boutiques can be accessed through your new favourite command, _bosh_. The Boutiques Shell (bosh) provides an access point to all of the tools wrapped within Boutiques and has some --help text to keep you moving forward if you feel like you're getting stuck. You can check that it's correctly installed by simply typing `bosh version` in a command line:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh version

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
0.5.20.post1
```
</div>
</div>
</div>



Help is available through `--help`:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh --help

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
usage: bosh [--help]
            [{create,data,evaluate,example,exec,export,import,invocation,pprint,publish,pull,search,test,validate,version}]

positional arguments:
  {create,data,evaluate,example,exec,export,import,invocation,pprint,publish,pull,search,test,validate,version}
                        
                                       BOUTIQUES COMMANDS
                        
                        TOOL CREATION
                        * create: create a Boutiques descriptor from scratch.
                        * export: export a descriptor to other formats.
                        * import: create a descriptor for a BIDS app or update a descriptor from \
                            an older version of the schema.
                        * validate: validate an existing boutiques descriptor.
                        
                        TOOL USAGE & EXECUTION
                        * example: generate example command-line for descriptor.
                        * pprint: generate pretty help text from a descriptor.
                        * exec: launch or simulate an execution given a descriptor and a set of inputs.
                        * test: run pytest on a descriptor detailing tests.
                        
                        TOOL SEARCH & PUBLICATION
                        * publish: create an entry in Zenodo for the descriptor and adds the DOI \
                            created by Zenodo to the descriptor.
                        * pull: download a descriptor from Zenodo.
                        * search: search Zenodo for descriptors.
                        
                        DATA COLLECTION
                        * data: manage execution data collection.
                        
                        OTHER
                        * evaluate: given an invocation and a descriptor,queries execution properties.
                        * invocation: generate or validate inputs against the invocation schema
                        * for a given descriptor.
                        * version: print the Boutiques version.

optional arguments:
  --help, -h            show this help message and exit
```
</div>
</div>
</div>



_bosh_ commands are also available as a Python API, where the same parameters as in the command line are passed as a list to function _bosh_:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```python
from boutiques import bosh
bosh(["version"])

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">


{:.output_data_text}
```
'0.5.20.post1'
```


</div>
</div>
</div>



This tutorial mostly uses the command line API, but all the commands are also available from the Python API.

## Tutorial outline

We will use brain extraction (BET) as a running example to illustrate Boutiques features. More specifically, we will go through the following steps:
* [Finding tools](#finding_tools)
* [Reusing tools](#reusing_tools)
* [Publishing tools](#publishing_tools)
* [Advanced features](#advanced_features)



## Finding tools
<a id="finding_tools"></a>

Perhaps someone has already described the tool you are looking for and you could reuse their work. For instance, if you are looking for a tool that does brain extraction (BET), try:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh search bet

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
[ INFO ] Showing 1 of 1 results.
ID              TITLE    DESCRIPTION                                DOWNLOADS
zenodo.1482743  fsl_bet  Automated brain extraction tool for FSL           23
```
</div>
</div>
</div>



The _search_ command returns a list of identifiers for tools matching your query. You can use these identifiers in any bosh command transparently. Even better, these identifiers are [Digital Object Identifiers](https://www.doi.org) hosted on [Zenodo](http://zenodo.org), they will never change and can't be deleted!

Once you have identified candidate tools for your task, you can get more details about them using bosh _pprint_:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh pprint zenodo.1482743 | head

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
================================================================================

Tool name: fsl_bet (ver: 1.0.0)
Tool description: Automated brain extraction tool for FSL
Tags: domain: neuroinformatics, mri

Command-line:
  bet [INPUT_FILE] [MASK] [FRACTIONAL_INTENSITY] [VERTICAL_GRADIENT]
      [CENTER_OF_GRAVITY] [OVERLAY_FLAG] [BINARY_MASK_FLAG]
      [APPROX_SKULL_FLAG] [NO_SEG_OUTPUT_FLAG] [VTK_VIEW_FLAG]
```
</div>
</div>
</div>



Behind the scene, _bosh_ has downloaded the tool descriptor from Zenodo and has stored it in `~/.cache/boutiques` on your computer:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
head ~/.cache/boutiques/zenodo-1482743.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{
    "tool-version": "1.0.0", 
    "name": "fsl_bet", 
    "author": "Oxford Centre for Functional MRI of the Brain (FMRIB)",
    "descriptor-url": "https://github.com/aces/cbrain-plugins-neuro/blob/master/cbrain_task_descriptors/fsl_bet.json",
    "command-line": "bet [INPUT_FILE] [MASK] [FRACTIONAL_INTENSITY] [VERTICAL_GRADIENT] [CENTER_OF_GRAVITY] [OVERLAY_FLAG] [BINARY_MASK_FLAG] [APPROX_SKULL_FLAG] [NO_SEG_OUTPUT_FLAG] [VTK_VIEW_FLAG] [HEAD_RADIUS] [THRESHOLDING_FLAG] [ROBUST_ITERS_FLAG] [RES_OPTIC_CLEANUP_FLAG] [REDUCE_BIAS_FLAG] [SLICE_PADDING_FLAG] [MASK_WHOLE_SET_FLAG] [ADD_SURFACES_FLAG] [ADD_SURFACES_T2] [VERBOSE_FLAG] [DEBUG_FLAG]", 
    "container-image": {
        "image": "mcin/docker-fsl:latest", 
        "index": "index.docker.io", 
        "type": "docker"
```
</div>
</div>
</div>



You can use file paths or Zenodo IDs indifferently in all _bosh_ commands. This can be useful when you work offline. For instance:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh pprint ~/.cache/boutiques/zenodo-1482743.json | head

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
================================================================================

Tool name: fsl_bet (ver: 1.0.0)
Tool description: Automated brain extraction tool for FSL
Tags: domain: neuroinformatics, mri

Command-line:
  bet [INPUT_FILE] [MASK] [FRACTIONAL_INTENSITY] [VERTICAL_GRADIENT]
      [CENTER_OF_GRAVITY] [OVERLAY_FLAG] [BINARY_MASK_FLAG]
      [APPROX_SKULL_FLAG] [NO_SEG_OUTPUT_FLAG] [VTK_VIEW_FLAG]
```
</div>
</div>
</div>



## Reusing tools
<a id='reusing_tools'></a>

It looks like we have found a tool that suits our needs -- now it's time to put it to work! The first step is to create an _invocation_ with your input values. We will use the test data in `data` that we extracted from the [CoRR](http://fcon_1000.projects.nitrc.org/indi/CoRR/html) dataset:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```python
from niwidgets import NiftiWidget
my_widget = NiftiWidget('./data/test.nii.gz')
my_widget.nifti_plotter(colormap='gray')

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">

{:.output_png}
![png](images/tutorial_17_0.png)

</div>
</div>
</div>



The _example_ command will create a first minimal invocation so that you don't have to start from scratch:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh example zenodo.1482743

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{
    "infile": "f_infile_14.cpp",
    "maskfile": "str_maskfile_vv"
}
```
</div>
</div>
</div>



If you feel like starting with a more complete set of options, you can pass `--complete` to the _example_ command:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh example --complete zenodo.1482743

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{
    "approx_skull_flag": true,
    "binary_mask_flag": true,
    "center_of_gravity": [
        -36.015,
        8.023,
        -25.984
    ],
    "debug_flag": false,
    "fractional_intensity": 0.155,
    "head_radius": 4.444,
    "infile": "f_infile_08.nii.gz",
    "maskfile": "str_maskfile_Ns",
    "no_seg_output_flag": false,
    "overlay_flag": true,
    "robust_iters_flag": false,
    "thresholding_flag": false,
    "verbose_flag": true,
    "vg_fractional_intensity": 0.314,
    "vtk_mesh": true
}
```
</div>
</div>
</div>



You can now edit the example invocation to add your input values:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
cat example_invocation.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{
	"infile": "./data/test.nii.gz",
        "maskfile": "test_brain.nii.gz"
}
```
</div>
</div>
</div>



You are now all set to use the _exec_ command to launch an analysis. One catch: we assume you have Docker or Singularity installed. A fair assumption, nowadays? We hope so:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh exec launch zenodo.1482743 ./example_invocation.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
docker is /usr/bin/docker
[32mShell command
[0mbet ./data/test.nii.gz test_brain.nii.gz                   
[32mContainer location
[0mPulled from Docker
[32mContainer command
[0mdocker run --entrypoint=/bin/sh --rm  -v /home/glatard/code/boutiques-tutorial/notebooks:/home/glatard/code/boutiques-tutorial/notebooks -w /home/glatard/code/boutiques-tutorial/notebooks mcin/docker-fsl:latest /home/glatard/code/boutiques-tutorial/notebooks/temp-808992682282-1559913263082.localExec.boshjob.sh
[32mExit code
[0m0
[32mError message
[0m[31m[0m
[32mOutput files
[0m
[32mMissing files
[0m[31m[0m

```
</div>
</div>
</div>



You can check that the output file was created as expected:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```python
from niwidgets import NiftiWidget
my_widget = NiftiWidget('./test_brain.nii.gz')
my_widget.nifti_plotter(colormap='gray')

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">

{:.output_png}
![png](images/tutorial_27_0.png)

</div>
</div>
</div>



As mentioned previously, all of this can be reproduced using the Python API, for instance:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```python
from boutiques import bosh
out = bosh(["example", "zenodo.1482743"])
print(out)

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{
    "infile": "f_infile_66.j",
    "maskfile": "str_maskfile_mJ"
}
```
</div>
</div>
</div>



And to integrate with Python programs even better, _descriptor2func_ can generate Python functions from descriptors. Here is an example that will run our BET tool:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```python
from boutiques.descriptor2func import function
fslbet = function("zenodo.1482743")
out = fslbet(infile="./data/test.nii.gz", maskfile="test_brain.nii.gz")

```
</div>

</div>



You now have a Python API for Boutiques tools, irrespective of their original programming language!



### Chaining tools

Boutiques doesn't prescribe any pipeline language or engine. Feel free to use whichever you want! In its simplest form, _descriptor2func_ makes it easy to chain tools in a Python program:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```python
from boutiques.descriptor2func import function
fslbet = function("zenodo.1482743")
fslstats = function("zenodo.3240521")
bet_out = fslbet(infile="./data/test.nii.gz", maskfile="test_brain.nii.gz")
stats_out = fslstats(input_file="test_brain.nii.gz", v=True)
! cat output.txt

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
11534336 11534336.000000 
```
</div>
</div>
</div>



## Publishing your own tool
<a id="publishing_tools"></a>

So far we have been referring to Boutiques tools through their IDs/DOIs. Tools are described in a structured format where the tool interface and installation are specified. A Boutiques tool descriptor is a JSON file that fully describes the input and output parameters and files for a given command line call (or calls, as you can include pipes(`|`) and ampersands (`&`)). To help you describe and publish your tool, we will walk through the process of making an tool descriptor for [FSL's BET](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET). The finished product is the one we used in the previous section (tool id: `zenodo.1482743`):



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh pull zenodo.1482743
head ~/.cache/boutiques/zenodo-1482743.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{
    "tool-version": "1.0.0", 
    "name": "fsl_bet", 
    "author": "Oxford Centre for Functional MRI of the Brain (FMRIB)",
    "descriptor-url": "https://github.com/aces/cbrain-plugins-neuro/blob/master/cbrain_task_descriptors/fsl_bet.json",
    "command-line": "bet [INPUT_FILE] [MASK] [FRACTIONAL_INTENSITY] [VERTICAL_GRADIENT] [CENTER_OF_GRAVITY] [OVERLAY_FLAG] [BINARY_MASK_FLAG] [APPROX_SKULL_FLAG] [NO_SEG_OUTPUT_FLAG] [VTK_VIEW_FLAG] [HEAD_RADIUS] [THRESHOLDING_FLAG] [ROBUST_ITERS_FLAG] [RES_OPTIC_CLEANUP_FLAG] [REDUCE_BIAS_FLAG] [SLICE_PADDING_FLAG] [MASK_WHOLE_SET_FLAG] [ADD_SURFACES_FLAG] [ADD_SURFACES_T2] [VERBOSE_FLAG] [DEBUG_FLAG]", 
    "container-image": {
        "image": "mcin/docker-fsl:latest", 
        "index": "index.docker.io", 
        "type": "docker"
```
</div>
</div>
</div>



### Step 0: Tool containerization

A useful feature of Boutiques is its ability to refer to container images so that tools can be deployed transparently on multiple platforms. Although Boutiques can technically describe uncontainerized tools, we strongly recommend that you find or build a container image where your tool is available. Containers will make your work more reusable! If you don't have a preferred container framework, we recommend to use [Docker](https://www.docker.com). The other possibility available in Boutiques would be [Singularity](https://www.sylabs.io/docs). Boutiques will run Docker images indifferently in the Docker or Singularity engine.

A good place to start with Docker is this [guide](https://docs.docker.com/get-started). Make sure that you have a functional Docker installation:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
docker --version

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
Docker version 19.03.0-beta5, build 4a18bf4
```
</div>
</div>
</div>



We can then proceed by searching for existing images containing the tool we are interested in, FSL BET:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
docker search fsl

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
NAME                                    DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
fslabs/uptimerobot-exporter             Prometheus uptimerobot exporter                 3                                       
williamspanlab/fsl-in-docker            Docker image used to permit the execution of…   0                                       
brainlife/fsl                           FSL container for Brainlife use                 0                                       [OK]
fslibre/odoo                            Odoo con las dependencias requeridas para la…   0                                       [OK]
vistalab/fsl-v5.0                       FSL V5.0 (fsl-core-5.0) image.                  0                                       [OK]
scitran/fsl-fast                        Flywheel Gear which runs FSL’s FAST.            0                                       [OK]
leganger/fsli-mapper                                                                    0                                       
pauldmccarthy/fsleyes-py35-wxpy4-gtk2                                                   0                                       
pauldmccarthy/fsleyes-py27-wxpy4-gtk2                                                   0                                       
pauldmccarthy/fsleyes-py36-wxpy4-gtk2                                                   0                                       
pauldmccarthy/fsleyes-py27-wxpy3-gtk2                                                   0                                       
pauldmccarthy/fsleyes-centos7                                                           0                                       
pauldmccarthy/fsleyes-py34-wxpy4-gtk2                                                   0                                       
scitran/fslmerge                        FSLMERGE (FMRIB) concatenates image files in…   0                                       [OK]
neurodata/fsl_1604                      Ubuntu 16.04 container with FSL.                0                                       
hachterberg/fsl-bet-container           FSL BET container for processing with bet       0                                       [OK]
scitran/fsl-bet                         Brain Extraction Tool (BET2) from FMRIB Soft…   0                                       [OK]
kaczmarj/fsl                                                                            0                                       
pauldmccarthy/fsleyes-centos6                                                           0                                       
pauldmccarthy/fsleyes-ubuntu1604                                                        0                                       
pauldmccarthy/fsleyes-py37-wxpy4-gtk2                                                   0                                       
jimlin95/fsl-yocto                      docker for yocto build system                   0                                       [OK]
josephdviviano/fsleyes-base             fsleyes (debian 8)                              0                                       
pauldmccarthy/fsleyes-ubuntu1404                                                        0                                       
neurology/fsl                           FSL on CentOS                                   0                                       [OK]
```
</div>
</div>
</div>



We will use image `mcin/docker-fsl`. If you're curious, the Dockerfile that was used to create it is available [here](./fsl.Dockerfile). It's a good idea to pull this image now, to make it available on your computer:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
docker pull mcin/docker-fsl

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
Using default tag: latest
latest: Pulling from mcin/docker-fsl
a3ed95caeb02: Already exists
1534505fcbc6: Already exists
a3ed95caeb02: Already exists
a3ed95caeb02: Already exists
2f340105e18c: Already exists
8bce4574a6b8: Already exists
1378af22889c: Already exists
69f6686a23f1: Already exists
Digest: sha256:095059aea79eba45f9c9e422ac9641ceee7a1b159ad6bb5f8c4f6bdc13463deb
Status: Image is up to date for mcin/docker-fsl:latest
docker.io/mcin/docker-fsl:latest
```
</div>
</div>
</div>



### Step 1: Describing the command line

The first step in creating an tool descriptor for your command line call is creating a fully descriptive list of your command line options. If your tool was written in Python and you use the `argparse` library, then this is already done for you in large part. For many tools (bash, Python, or otherwise) this can be obtained by executing it with the `-h` flag. In the case of FS BET, we get the following from our container image:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
docker run --rm mcin/docker-fsl bet || true

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```

Usage:    bet <input> <output> [options]

Main bet2 options:
  -o          generate brain surface outline overlaid onto original image
  -m          generate binary brain mask
  -s          generate approximate skull image
  -n          don't generate segmented brain image output
  -f <f>      fractional intensity threshold (0->1); default=0.5; smaller values give larger brain outline estimates
  -g <g>      vertical gradient in fractional intensity threshold (-1->1); default=0; positive values give larger brain outline at bottom, smaller at top
  -r <r>      head radius (mm not voxels); initial surface sphere is set to half of this
  -c <x y z>  centre-of-gravity (voxels not mm) of initial mesh surface.
  -t          apply thresholding to segmented brain image and mask
  -e          generates brain surface as mesh in .vtk format

Variations on default bet2 functionality (mutually exclusive options):
  (default)   just run bet2
  -R          robust brain centre estimation (iterates BET several times)
  -S          eye & optic nerve cleanup (can be useful in SIENA)
  -B          bias field & neck cleanup (can be useful in SIENA)
  -Z          improve BET if FOV is very small in Z (by temporarily padding end slices)
  -F          apply to 4D FMRI data (uses -f 0.3 and dilates brain mask slightly)
  -A          run bet2 and then betsurf to get additional skull and scalp surfaces (includes registrations)
  -A2 <T2>    as with -A, when also feeding in non-brain-extracted T2 (includes registrations)

Miscellaneous options:
  -v          verbose (switch on diagnostic messages)
  -h          display this help, then exits
  -d          debug (don't delete temporary intermediate images)

```
</div>
</div>
</div>



Looking at all of these flags, we see a list of options which can be summarized by:
```
bet [INPUT_FILE] [MASK] [FRACTIONAL_INTENSITY] [VERTICAL_GRADIENT] [CENTER_OF_GRAVITY] [OVERLAY_FLAG] [BINARY_MASK_FLAG] [APPROX_SKULL_FLAG] [NO_SEG_OUTPUT_FLAG] [VTK_VIEW_FLAG] [HEAD_RADIUS] [THRESHOLDING_FLAG] [ROBUST_ITERS_FLAG] [RES_OPTIC_CLEANUP_FLAG] [REDUCE_BIAS_FLAG] [SLICE_PADDING_FLAG] [MASK_WHOLE_SET_FLAG] [ADD_SURFACES_FLAG] [ADD_SURFACES_T2] [VERBOSE_FLAG] [DEBUG_FLAG]
```



Now that we have summarized all command line options for our tool - some of which describe inputs and others, outputs - we can begin to craft our JSON Boutiques tool descriptor.



### Step 2: Understanding Boutiques + JSON

For those unfamiliar with JSON, we recommend following this [3 minute JSON tutorial](http://www.secretgeek.net/json_3mins) to get you up to speed. In short, a JSON file is a dictionary object which contains *keys* and associated *values*. A *key* informs us what is being described, and a *value* is the description (which, importantly, can be arbitrarily typed). The Boutiques tool descriptor is a JSON file which requires the following keys, or, properties:
- `name`
- `description`
- `tool-version`
- `schema-version`
- `command-line`
- `inputs`

Some additional, optional, properties that Boutiques will recognize are:
- `groups`
- `tool-version`
- `suggested-resources`
- `container-image`:
  - `type`
  - `image`
  - `index`

The complete list of properties and their description is available [here](https://github.com/boutiques/boutiques/tree/master/schema).
In the case of BET, we will of course populate the required elements, but will also include `groups`, `container-image` and `tags`.



### Step 3: Populating the tool descriptor

bosh command _create_ will help you start with a minimal descriptor. Since we have already identified a container image for our tool, we will pass it to _create_:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh create --docker-image mcin/docker-fsl fsl-bet.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
docker is /usr/bin/docker
```
</div>
</div>
</div>



This will produce a template descriptor in `fsl-bet.json`:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
head fsl-bet.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{
    "command-line": "echo [PARAM1] [PARAM2] [FLAG1] > [OUTPUT1]",
    "container-image": {
        "image": "mcin/docker-fsl",
        "type": "docker"
    },
    "description": "tool description",
    "error-codes": [
        {
            "code": 1,
```
</div>
</div>
</div>



Note how the container image was populated from the Docker image metadata. We will break-up populating the tool descriptor into two sections: adding meta-parameters (such as `name`, `description`, `schema-version`, `command-line`, and `tool-version`) and adding i/o-parameters (such as `inputs`, `output-files`, and `groups`).





#### Step 3.1: Adding meta-parameters

Many of the meta-parameters will be obvious to you if you're familiar with the tool, or extractable from the message received earlier when you passed the `-h` flag into your program. We can update properties `name`, `tool-version`, `description`, and `command-line` in our JSON (see current descriptor in [fsl-bet-metadata.json](fsl-bet-metadata.json)):



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
grep -P "fsl_bet|tool-version|Automated|command-line" fsl-bet-metadata.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
    "command-line": "bet [INPUT_FILE] [MASK] [FRACTIONAL_INTENSITY] [VERTICAL_GRADIENT] [CENTER_OF_GRAVITY] [OVERLAY_FLAG] [BINARY_MASK_FLAG] [APPROX_SKULL_FLAG] [NO_SEG_OUTPUT_FLAG] [VTK_VIEW_FLAG] [HEAD_RADIUS] [THRESHOLDING_FLAG] [ROBUST_ITERS_FLAG] [RES_OPTIC_CLEANUP_FLAG] [REDUCE_BIAS_FLAG] [SLICE_PADDING_FLAG] [MASK_WHOLE_SET_FLAG] [ADD_SURFACES_FLAG] [ADD_SURFACES_T2] [VERBOSE_FLAG] [DEBUG_FLAG]",
    "description": "Automated brain extraction tool for FSL",
            "command-line-flag": "-f",
    "name": "fsl_bet",
    "tool-version": "1.0.0"
```
</div>
</div>
</div>



#### Step 3.2: Adding i/o parameters

Inputs and outputs of many applications are complicated - outputs can be dependent upon input flags, flags can be mutually exclusive or require at least one option, etc. The way Boutiques handles this is with a detailed schema which consists of options for inputs and outputs, as well as optionally specifying groups of inputs which may add additional layers of input complexity.

As you have surely noted, tools may have many input and output parameters. This means that inputs, outputs, and groups, will be described as a list. Each element of these lists will be a dictionary following the input, output, or group schema, respectively. 

In the following sections, we will show you the dictionaries responsible for output, input, and group entries. 



##### Step 3.2.1: Specifying inputs

The input schema contains several options, many of which can be ignored in this first example with the exception of `id`, `name`, and `type`. For BET, there are several input values we can choose to demonstrate this for you. We have chosen four with considerably different functionality and therefore schemas. In particular:
- `[INPUT_FILE]`
- `[MASK]`
- `[FRACTIONAL_INTENSITY]`
- `[CENTER_OF_GRAVITY]`

**`[INPUT_FILE]`**   The simplest of these is the `[INPUT_FILE]` which is a required parameter that simply expects a qualified path to a file. The dictionary entry is:
```
{
    "id" : "infile",
    "name" : "Input file",
    "type" : "File",
    "description" : "Input image (e.g. img.nii.gz)",
    "value-key" : "[INPUT_FILE]"
}
```

**`[MASK]`**   This parameter is a string from which the output mask file name will be defined. The dictionary entry is:
```
{
    "description": "Output brain mask (e.g. img_bet.nii.gz)", 
    "value-key": "[MASK]", 
    "type": "String", 
    "optional": false, 
    "id": "maskfile", 
    "name": "Mask file"
}
```

**`[FRACTIONAL_INTENSITY]`**   This parameter documents an optional flag that can be passed to the executable. Along with the flag, when it is passed, is a floating point value that can range from 0 to 1. We are able to validate at the level of Boutiques whether or not a valid input is passed, so that jobs are not submitted to the execution engine which will error, but they get flagged upon validation of inputs. This dictionary is:
```
{
    "id" : "fractional_intensity",
    "name" : "Fractional intensity threshold",
    "type" : "Number",
    "description" : "Fractional intensity threshold (0->1); default=0.5; smaller values give larger brain outline estimates",
    "command-line-flag": "-f",
    "optional": true,
    "value-key" : "[FRACTIONAL_INTENSITY]",
    "minimum" : 0,
    "maximum" : 1
}
```

**`[CENTER_OF_GRAVITY]`**   The center of gravity value expects a triple (i.e. [X, Y, Z] position) if the flag is specified. Here we are able to set the condition that the length of the list received after this flag is 3, by specifying that the input is a list that has both a minimum and maximum length.
```
{
    "id" : "center_of_gravity",
    "name" : "Center of gravity vector",
    "type" : "Number",
    "description" : "The xyz coordinates of the center of gravity (voxels, not mm) of initial mesh surface. Must have exactly three numerical entries in the list (3-vector).",
    "command-line-flag": "-c",
    "optional": true,
    "value-key" : "[CENTER_OF_GRAVITY]",
    "list" : true,
    "min-list-entries" : 3,
    "max-list-entries" : 3
}
```

For further examples of different types of inputs, feel free to explore [more examples](https://github.com/aces/cbrain-plugins-neuro/tree/master/cbrain_task_descriptors).



##### Step 3.2.2: Specifying outputs

The output schema also contains several options, with the only mandatory ones being `id`, `name`, and `path-template`. We again demonstrate an example from BET:
- `outfile`

**`outfile`**   All of the output parameters in BET are similarly structured, and exploit the same core functionality of basing the output file, described by `path-template`, as a function of an input value on the command line, here given by `[MASK]`. The `optional` flag also describes whether or not a derivative should always be produced, and whether Boutiques should indicate an error if a file isn't found. The output descriptor is thus:

```
{
    "id" : "outfile",
    "name" : "Output mask file",
    "description" : "Main default mask output of BET",
    "path-template" : "[MASK].nii.gz",
    "optional" : true
}
```



#### Step 3.2.3: Specifying groups

The group schema enables provides an additional layer of complexity when considering the relationships between inputs. For instance, if multiple inputs within a set are mutually exclusive, they may be grouped and a flag set indicating that only one can be selected. Alternatively, if at least one option within a group must be specified, the user can also set a flag indicating such. The following group from the BET implementation is used to illustrate this:
- `variational_params_group`

**`variational_params_group`**   Many flags exist in BET, and each of them is represented in the command line we specified earlier. However, as you may have noticed when reading the output of `bet -h`, several of these options are mutually exclusive to one another. In order to again prevent jobs from being submitted to a scheduler and failing there, Boutiques enables grouping of inputs and forcing such mutual exclusivity so that the invalid inputs are flagged in the validation stage. This group dictionary is:




```
{
    "id" : "variational_params_group",
    "name" : "Variations on Default Functionality",
    "description" : "Mutually exclusive options that specify variations on how BET should be run.",
    "members" : ["robust_iters_flag", "residual_optic_cleanup_flag", "reduce_bias_flag", "slice_padding_flag", "whole_set_mask_flag", "additional_surfaces_flag", "additional_surfaces_t2"],
    "mutually-exclusive" : true
}
```



#### Step 3.3: Specifying tags (optional)

You can also specify tags to help others find your tool once it's published:
```
"tags": {
        "domain": [ "neuroimaging", "mri" ]
        "toolbox": "fsl",
        "brain extraction": true
    }
```



#### Step 3.4: Extending the tool descriptor  (optional)

Now that the basic implementation of this tool has been done, you can check out the [schema](https://github.com/boutiques/boutiques/tree/master/schema) to explore deeper functionality of Boutiques. For instance, you can specify `suggested-resources` to help platforms run your tool on HPC clusters or clouds.



### Alternate path: Creating descriptors from Python scripts

If you want a bit more of a head start and your tool is built in Python using the argparse library, you don't have to write your descriptor by hand! In the Python script with your argparser defined, simply add the following lines to get yourself a minimal corresponding descriptor:

```
import boutiques.creator as bc
newDescriptor = bc.CreateDescriptor(myparser, execname="/command/to/run/exec")
newDescriptor.save("my-new-descriptor.json")
```

There are additional custom arguments which can be supplied to this script, such as tags for your tool. It is also worth noting that no interpretation of output files is attempted by this tool, so your descriptor could certainly be enhanced by addind these and other features available through Boutiques, such as tests, tags, error codes, groups, and container images.

Once you've created your descriptor this way you can translate your arguments to a Boutiques-style invocation using the following code block on runtime:

```
args = myparser.parse_args()
invoc = newDescriptor.createInvocation(args)

# Then, if you want to save them to a file...
import json
with open('my-inputs.json', 'w') as fhandle:
    fhandle.write(json.dumps(invoc, indent=4))
```



### Step 4: Validating the tool descriptor

You just created a Boutiques descriptor - Congratulations! 
Now, you need to quickly validate it to make sure that you didn't accidentally break any rules in this definition (like requiring a "flag" input). You can validate your schema like this



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
# here we use the final product of the FSL BET descriptor that is already published
bosh validate zenodo.1482743 

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
OK
```
</div>
</div>
</div>



Depending on the status of your descriptor, bosh will either tell you it's A-OK or tell you where the problems are and what you should fix. If you want to know more about some extra options packed into this validator, you can check them with `bosh validate -h`, as one may expect.



### Step 5: Checking the descriptor

You now have a valid tool descriptor, congratulations! It doesn't mean that it will do what you expect though. The _simulate_ command will help you check that the tool will generate meaningful command lines:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
# Command line without options
bosh exec simulate zenodo.1482743

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
Generated Command:
bet f_infile_37 str_maskfile_rx                   
```
</div>
</div>
</div>



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
# Command line with all options
bosh exec simulate -c zenodo.1482743

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
Generated Command:
bet f_infile_55.csv str_maskfile_Sn -f 0.151 -g 0.446 -c 31.273 0.805 45.597  -m -s -n -e -r -33.747         -v -d
```
</div>
</div>
</div>



The filenames and parameters were generated randomly within the valid ranges specified in the descriptor. This specific command line may not run, but you should check that it corresponds to what you had in mind. If anything seems fishy, you can update your descriptor and ensure you're describing the command-line you want. If you had a particular set of inputs in mind, you could pass them in with the `-i` flag. Again, as I'm sure you've guessed, you can learn more here with `bosh exec simulate -h`.

You could now try to run the tool on actual data, as explained in Section [Reusing tools](#reusing_tools). 



### Step 6: Publishing the descriptor

Now that you have checked that your descriptor works as intended, it's time to publish it so that others can reuse it. To do that, you will first have to create an account on [Zenodo](http://zenodo.org), the publishing platform used by Boutiques. Once your account is created, you should create an application token in the "Applications" menu so that bosh can publish descriptors under your name:

<img src="./images/zenodo-account.png"/>



Write down the access token once you create it, you will need it during publication.

You are now all set to publish your descriptor! Be careful though: once it's published, there won't be any way to remove it, although you will be able to update it. If you want to try a dry-run publication, you can use option `--sandbox` of the _publish_ command. It will require that you create an account on Zenodo's [sandbox](https://sandbox.zenodo.org) and create an access token for it.



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
# Assuming you have saved your tool in fsl-bet.json
# Option -y answers 'yes' to all questions asked during publication
bosh publish --sandbox -y fsl-bet.json

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
10.5072/zenodo.295219
```
</div>
</div>
</div>



Hooray, your tool is now published! Your tool is now being shared in a packaged and fully described fashion, making it easier than ever to reproduce and extend your work! As always, learn more about this feature with `bosh publish -h`.

You can find your tool the usual way:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh search --sandbox fsl

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
[ INFO ] Showing 10 of 11 results.
ID             TITLE                       DESCRIPTION                                    DOWNLOADS
zenodo.246085  PreFreeSurferPipelineBatch  PreFreeSurferPipelineBatch HCP pipeline                0
zenodo.264108  FNIRT                       FNIRT, as implemented in Nipype (module:...            0
zenodo.265109  fsl_fast                    FAST (FMRIB's Automated Segmentation Too...            0
zenodo.295207  tool name                   tool description                                       0
zenodo.242580  Example Boutiques Tool      This property describes the tool or appl...            0
zenodo.249793  fsl_bet                     Automated brain extraction tool for FSL                0
zenodo.252521  fsl_first                   FIRST is a model-based segmentation and ...            0
zenodo.246081  fsl_probtrackx2             probabilistic tracking with crossing fib...            0
zenodo.263338  FLIRT                       FLIRT, as implemented in Nipype (module:...            0
zenodo.295213  tool name 1                 tool description                                       0
```
</div>
</div>
</div>



Check that your tool DOI shows in the list.



## Advanced features
<a id="advanced_features"></a>

### Evaluate Your Usage

If you've been using your tool and forget what exactly that output file will be named, or if it's optional, but find re-reading the descriptor a bit cumbersome, you should just evaluate your invocation! If we wanted to check the location of our output corresponding to the id `outfile`, we could do the following query:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh evaluate zenodo.1482743 ./example_invocation.json output-files/id=outfile

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
{'outfile': 'test_brain.nii.gz.nii.gz'}
```
</div>
</div>
</div>



### Execution Records

Want to check up on what happened during a previous analysis? The details of each execution are captured and recorded in a publicly safe format so that you can review past analysis runs. These records are stored in the Boutiques cache and capture each executions' descriptor, invocation and output results. Input and output file hashes are included to easily compare results between different analyses. `bosh data` is the command to interact and publish execution records:



<div markdown="1" class="cell code_cell">
<div class="input_area" markdown="1">
```bash%%bash
bosh data inspect

```
</div>

<div class="output_wrapper" markdown="1">
<div class="output_subarea" markdown="1">
{:.output_stream}
```
There are 133 unpublished records in the cache
There are 43 unpublished descriptors in the cache
Example-Boutiques-Tool_2019-05-29T18:00:48.152289.json
fsl_bet_2019-06-03T20:50:44.270307.json
Example-Boutiques-Tool_2019-05-28T21:33:38.575874.json
Example-Boutiques-Tool_2019-05-29T16:58:27.075311.json
fsl_bet_2019-06-07T09:10:38.723725.json
fsl_bet_2019-06-06T11:31:06.295541.json
MCFLIRT_2019-05-29T16:37:03.049697.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:52:25.908698.json
fsl_bet_2019-06-06T13:04:33.441188.json
fsl_bet_2019-06-06T12:10:06.574994.json
descriptor_fslstats_2019-06-06T11:08:25.547261.json
fsl_bet_2019-06-07T09:10:58.116789.json
descriptor_Example-Boutiques-Tool_2019-05-29T11:00:46.362011.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:02:34.772235.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:59:29.807663.json
Example-Boutiques-Tool_2019-05-29T16:55:01.814602.json
Example-Boutiques-Tool_2019-05-29T16:59:21.781967.json
Example-Boutiques-Tool_2019-05-29T16:58:31.859116.json
Example-Boutiques-Tool_2019-05-29T17:59:24.383202.json
fsl_bet_2019-06-07T09:14:47.498321.json
fsl_bet_2019-06-06T09:55:54.373704.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:00:54.082491.json
fsl_bet_2019-06-06T13:17:28.881667.json
fsl_bet_2019-06-03T21:11:40.933050.json
Example-Boutiques-Tool_2019-05-29T17:59:30.596801.json
Example-Boutiques-Tool_2019-05-29T18:04:50.693507.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:05:00.575943.json
MCFLIRT_2019-06-03T21:11:43.520898.json
Example-Boutiques-Tool_2019-05-29T16:59:22.983849.json
Example-Boutiques-Tool_2019-05-28T21:36:08.214703.json
Example-Boutiques-Tool_2019-05-29T17:01:19.065796.json
Example-Boutiques-Tool_2019-05-29T17:01:07.594225.json
fslstats_2019-06-07T09:14:58.040343.json
fsl_bet_2019-06-06T10:09:18.960265.json
fsl_bet_2019-06-06T09:56:40.355299.json
descriptor_Example-Boutiques-Tool_2019-05-28T21:41:48.870398.json
Example-Boutiques-Tool_2019-05-29T17:59:25.807684.json
fsl_bet_2019-06-06T10:01:05.550132.json
fslstats_2019-06-06T12:34:01.851359.json
fsl_bet_2019-06-06T12:58:47.797025.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:58:36.682373.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:59:25.198023.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:02:33.554983.json
fsl_bet_2019-06-06T12:33:58.633511.json
fsl_bet_2019-06-06T12:58:17.820224.json
Example-Boutiques-Tool_2019-05-29T18:04:52.591565.json
descriptor_Example-Boutiques-Tool_2019-05-28T21:33:38.603079.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:01:12.393970.json
fslstats_2019-06-06T11:08:48.103266.json
fsl_bet_2019-06-06T10:09:00.987162.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:00:52.174777.json
fsl_bet_2019-06-06T12:52:43.418357.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:58:29.558597.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:04:50.743179.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:56:58.284945.json
Example-Boutiques-Tool_2019-05-29T18:03:29.529207.json
fsl_bet_2019-06-06T12:53:23.786146.json
Example-Boutiques-Tool_2019-05-29T18:03:40.177634.json
fsl_bet_2019-06-03T21:10:49.035485.json
Example-Boutiques-Tool_2019-05-28T21:41:48.819017.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:59:32.611091.json
descriptor_Example-Boutiques-Tool_2019-05-28T21:33:36.924542.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:53:58.413297.json
fsl_bet_2019-06-07T08:05:03.599150.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:55:06.695524.json
fslstats_2019-06-07T09:11:27.412900.json
descriptor_fslstats_2019-06-06T10:53:39.500539.json
Example-Boutiques-Tool_2019-05-29T18:04:44.817635.json
Example-Boutiques-Tool_2019-05-29T17:01:08.765935.json
fsl_bet_2019-06-06T09:42:17.582690.json
Example-Boutiques-Tool_2019-05-29T16:54:57.065112.json
fsl_bet_2019-06-06T13:24:31.849182.json
descriptor_Example-Boutiques-Tool_2019-05-28T21:36:06.329444.json
fsl_bet_2019-06-06T09:43:04.728946.json
Example-Boutiques-Tool_2019-05-29T16:55:00.632619.json
Example-Boutiques-Tool_2019-05-29T17:02:35.931023.json
Example-Boutiques-Tool_2019-05-29T17:02:34.722966.json
Example-Boutiques-Tool_2019-05-29T16:58:30.691861.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:55:00.686991.json
fslstats_2019-06-06T13:04:36.837276.json
fsl_bet_2019-06-07T09:13:30.905799.json
Example-Boutiques-Tool_2019-05-29T16:53:59.539666.json
descriptor_Example-Boutiques-Tool_2019-05-28T21:41:47.208936.json
fsl_bet_2019-06-06T09:55:12.813688.json
fslstats_2019-06-06T13:18:46.943980.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:56:51.097212.json
fsl_bet_2019-06-03T21:13:48.885991.json
descriptor_fslstats_2019-06-06T11:08:44.103828.json
fsl_bet_2019-06-03T21:13:08.265024.json
Example-Boutiques-Tool_2019-05-28T21:33:40.274949.json
Example-Boutiques-Tool_2019-05-29T18:00:46.181282.json
fsl_bet_2019-06-06T12:11:00.408049.json
fsl_bet_2019-06-07T09:13:21.555596.json
Example-Boutiques-Tool_2019-05-29T18:04:42.899777.json
Example-Boutiques-Tool_2019-05-29T18:05:01.356456.json
Example-Boutiques-Tool_2019-05-29T16:55:07.481712.json
Example-Boutiques-Tool_2019-05-28T21:41:50.457775.json
Example-Boutiques-Tool_2019-05-29T16:56:48.620052.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:02:40.761934.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:01:18.284431.json
fsl_bet_2019-06-06T09:42:41.301151.json
Example-Boutiques-Tool_2019-05-29T16:52:27.062199.json
fsl_bet_2019-06-06T12:31:23.260603.json
descriptor_Example-Boutiques-Tool_2019-05-29T17:01:11.234047.json
fsl_bet_2019-06-07T09:14:54.659575.json
fsl_bet_2019-06-06T13:18:05.654252.json
fsl_bet_2019-06-06T10:05:23.576303.json
fslstats_2019-06-06T11:31:14.659960.json
Example-Boutiques-Tool_2019-05-29T17:01:12.343226.json
Example-Boutiques-Tool_2019-05-28T21:36:09.931006.json
fslstats_2019-06-06T10:53:43.408902.json
Example-Boutiques-Tool_2019-05-29T18:03:31.732542.json
fsl_bet_2019-06-07T09:13:38.203172.json
fsl_bet_2019-06-07T08:16:11.386843.json
fslstats_2019-06-06T12:58:51.436869.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:59:25.457539.json
MCFLIRT_2019-06-03T21:10:51.442664.json
fsl_bet_2019-06-06T13:24:14.629790.json
Example-Boutiques-Tool_2019-05-29T16:56:52.233152.json
fsl_bet_2019-06-06T11:30:19.229138.json
Example-Boutiques-Tool_2019-05-29T16:56:53.456656.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:01:04.936517.json
Example-Boutiques-Tool_2019-05-29T18:03:37.959091.json
Example-Boutiques-Tool_2019-05-29T16:53:57.103092.json
fsl_bet_2019-06-06T10:10:14.139074.json
Example-Boutiques-Tool_2019-05-29T18:01:05.721049.json
fsl_bet_2019-06-06T11:30:33.986091.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:03:35.804361.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:59:26.598540.json
fsl_bet_2019-06-07T09:09:12.459719.json
fsl_bet_2019-06-07T08:18:56.848703.json
descriptor_Example-Boutiques-Tool_2019-05-28T21:36:08.257989.json
Example-Boutiques-Tool_2019-05-29T18:00:56.222776.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:58:30.742396.json
Example-Boutiques-Tool_2019-05-29T18:03:49.328582.json
Example-Boutiques-Tool_2019-05-29T17:01:13.517731.json
MCFLIRT_2019-06-03T21:13:50.796552.json
Example-Boutiques-Tool_2019-05-29T11:00:51.953176.json
fsl_bet_2019-06-06T09:42:07.823382.json
fsl_bet_2019-06-07T09:11:09.182554.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:04:48.843505.json
Example-Boutiques-Tool_2019-05-29T17:02:41.541266.json
descriptor_Example-Boutiques-Tool_2019-05-28T21:41:57.468571.json
Example-Boutiques-Tool_2019-05-29T16:59:27.729731.json
fsl_bet_2019-06-06T13:24:46.850230.json
fslstats_2019-06-06T13:24:50.688363.json
fsl_bet_2019-06-06T12:58:39.208108.json
fsl_bet_2019-06-06T13:18:43.531373.json
Example-Boutiques-Tool_2019-05-29T16:59:33.398707.json
fsl_bet_2019-06-06T10:02:32.392162.json
fsl_bet_2019-06-06T12:56:21.716958.json
fsl_bet_2019-06-07T09:14:34.768878.json
MCFLIRT_2019-05-29T14:09:14.041501.json
Example-Boutiques-Tool_2019-05-29T18:00:54.033204.json
fsl_bet_2019-06-06T12:09:58.426500.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:03:48.529106.json
fsl_bet_2019-06-06T11:35:00.893062.json
Example-Boutiques-Tool_2019-05-29T11:00:46.978997.json
Example-Boutiques-Tool_2019-05-29T16:58:37.464570.json
Example-Boutiques-Tool_2019-05-29T16:56:59.071789.json
descriptor_Example-Boutiques-Tool_2019-05-29T18:03:38.013878.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:56:52.283212.json
fsl_bet_2019-06-06T12:53:28.448743.json
fslstats_2019-06-06T11:08:28.387357.json
fslstats_2019-06-06T11:35:10.790944.json
fsl_bet_2019-06-06T10:05:09.591381.json
Example-Boutiques-Tool_2019-05-29T17:02:31.103425.json
MCFLIRT_2019-06-03T21:13:10.365045.json
fsl_bet_2019-06-06T11:30:11.272782.json
fslstats_2019-06-06T12:53:39.433955.json
Example-Boutiques-Tool_2019-05-29T17:02:29.892967.json
Example-Boutiques-Tool_2019-05-29T16:59:26.573236.json
Example-Boutiques-Tool_2019-05-28T21:41:58.249277.json
fsl_bet_2019-06-03T21:11:20.029370.json
descriptor_Example-Boutiques-Tool_2019-05-29T11:00:51.093886.json
descriptor_Example-Boutiques-Tool_2019-05-29T16:54:59.518340.json
OK
```
</div>
</div>
</div>



## Epilogue

That's the end of this tutorial, we hope you enjoyed it. Don't hesitate to leave us feedback by submitting an issue at https://github.com/boutiques/boutiques-tutorial, we'd love to improve this material!


