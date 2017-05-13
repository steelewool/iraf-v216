This is taken from the file
[testproc.ps.Z](http://iraf.noao.edu/iraf/ftp/iraf/docs/testproc.ps.Z)
(IRAF Version V2.11, Jeannette Barnes, Central Computer Services,
National Optical Astronomy Observatories, P.O. Box 26732, Tucson, AZ
85726, Revised September 23, 1997).

***

The following pages describe a short test procedure that sites can
execute to test some basic image functions within IRAF for a new
installation. This process will help verify that everything is working
correctly and also help the rst time user gain familiarity with the
system. The commands you need to type and the expected terminal output
are given below.

We will assume that you have started IRAF and are residing in an empty
directory from which you wish to work.

All of the IRAF core packages are loaded when you log into IRAF. You
can list what packages are currently loaded by typing the word
`package`. The following should be displayed, but the packages may not
be listed in the same order:

```
cl> package
    clpackage
    language
    system
    lists
    noao
    nttools
    utilities
    proto
    imutil
    immatch
    imgeom
    imfit
    imfilter
    imcoords
    images
```

New packages can be loaded by simply typing the packages name. Not the
change of the prompt. The last package loaded can be unloaded by
typing `bye`. Try the following. Note that in our example the top
level packages listed may be different than yours.

```
cl> digiphot
di> ?
      apphot   daophot  photcal  ptools
di> bye
cl> ?
      dataio      language    obsolete    softools    vo          
      dbms        lists       plot        system      
      images      noao        proto       utilities   
```

An IRAF image exists in the `dev$` directory. Lets make a copy of this
image into the current working directory.

```
cl> imcopy dev$pix image.short
dev$pix -> image.short    
```

Let's look at the header information for this image with `imhead`.

```
cl> imhead dev$pix long+
dev$pix[512,512][short]: m51  B  600s
No bad pixels, min=-1., max=19936.
Line storage mode, physdim [512,512], length of user area 1621 s.u.
Created Mon 23:54:13 31-Mar-1997, Last modified Sun 16:37:53 12-Mar-2006
Pixel file "HDR$pix.pix" [ok]
'KPNO-IRAF'           /
'31-03-97'            /
IRAF-MAX=           1.993600E4  /  DATA MAX
IRAF-MIN=          -1.000000E0  /  DATA MIN
IRAF-BPX=                   16  /  DATA BITS/PIXEL
IRAFTYPE= 'SHORT   '            /  PIXEL TYPE
CCDPICNO=                   53  /  ORIGINAL CCD PICTURE NUMBER
ITIME   =                  600  /  REQUESTED INTEGRATION TIME (SECS)
TTIME   =                  600  /  TOTAL ELAPSED TIME (SECS)
OTIME   =                  600  /  ACTUAL INTEGRATION TIME (SECS)
DATA-TYP= 'OBJECT (0)'          /  OBJECT,DARK,BIAS,ETC.
DATE-OBS= '05/04/87'            /  DATE DD/MM/YY
RA      = '13:29:24.00'         /  RIGHT ASCENSION
DEC     = '47:15:34.00'         /  DECLINATION
EPOCH   =                 0.00  /  EPOCH OF RA AND DEC
ZD      = '22:14:00.00'         /  ZENITH DISTANCE
UT      = ' 9:27:27.00'         /  UNIVERSAL TIME
ST      = '14:53:42.00'         /  SIDEREAL TIME
CAM-ID  =                    1  /  CAMERA HEAD ID
CAM-TEMP=              -106.22  /  CAMERA TEMPERATURE, DEG C
DEW-TEMP=              -180.95  /  DEWAR TEMPRATURE, DEG C
F1POS   =                    2  /  FILTER BOLT I POSITION
F2POS   =                    0  /  FILTER BOLT II POSITION
TVFILT  =                    0  /  TV FILTER
CMP-LAMP=                    0  /  COMPARISON LAMP
TILT-POS=                    0  /  TILT POSITION
BIAS-PIX=                    0  /
BI-FLAG =                    0  /  BIAS SUBTRACT FLAG
BP-FLAG =                    0  /  BAD PIXEL FLAG
CR-FLAG =                    0  /  BAD PIXEL FLAG
DK-FLAG =                    0  /  DARK SUBTRACT FLAG
FR-FLAG =                    0  /  FRINGE FLAG
FR-SCALE=                 0.00  /  FRINGE SCALING PARAMETER
TRIM    = 'Apr 22 14:11 Trim image section is [3:510,3:510]'
BT-FLAG = 'Apr 22 14:11 Overscan correction strip is [515:544,3:510]'
FF-FLAG = 'Apr 22 14:11 Flat field image is Flat1.imh with scale=183.9447'
CCDPROC = 'Apr 22 14:11 CCD processing done'
AIRMASS =    1.08015632629395   / AIRMASS
HISTORY 'KPNO-IRAF'
HISTORY '24-04-87'
HISTORY 'KPNO-IRAF'           /
HISTORY '08-04-92'            /
```
Note that the pixels are short integers (=16 bits).

It would be useful to generate two more copies of this image but with
different pixel types - one with 32-bit floating point pixels (called
`real`s) and one with 64-bit double precision floating point pixels
(called `double`). Note that IRAF also supports other pixel data types
- 32-bit integers called `long`, 16-bit unsigned integers called
`ushort`, and complex numbers. Execute the following:

```
cl> imarith image.short / 1 image.real pixtype=r
cl> imarith image.short / 1 image.dbl pixtype=d
cl> imhead image.*
image.dbl.fits[512,512][double]: m51  B  600s
image.real.fits[512,512][real]: m51  B  600s
image.short.fits[512,512][short]: m51  B  600s
```

Let's execute a couple of more tasks that will exercise some image
operators. Typing

```
cl> minmax image.dbl,image.real,image.short
image.dbl [77,4] -1. [348,189] 19936.
image.real [77,4] -1. [348,189] 19936.
image.short [77,4] -1. [348,189] 19936.
```

Now display a table with pixel values.

```
cl> listpix image.short[300:305,200:205] formats="%4s %4s" | table
   1.   1.  145.     4.   2.  141.     1.   4.  149.     4.   5.  144.
   2.   1.  143.     5.   2.  132.     2.   4.  149.     5.   5.  145.
   3.   1.  141.     6.   2.  130.     3.   4.  146.     6.   5.  144.
   4.   1.  142.     1.   3.  162.     4.   4.  143.     1.   6.  138.
   5.   1.  135.     2.   3.  145.     5.   4.  145.     2.   6.  139.
   6.   1.  138.     3.   3.  146.     6.   4.  140.     3.   6.  145.
   1.   2.  147.     4.   3.  144.     1.   5.  144.     4.   6.  141.
   2.   2.  147.     5.   3.  135.     2.   5.  145.     5.   6.  141.
   3.   2.  145.     6.   3.  141.     3.   5.  133.     6.   6.  149.
```

Now let's test the use of image sections. Type and observe the
following terminal interactions:

```
cl> imcopy image.real[200:300,200:300] image.sect
image.real[200:300,200:300] -> image.sect
cl> imhead image.sect
image.sect[101,101][real]: m51  B  600s
```

At this time, let's modify a couple of image titles.

```
cl> hedit image.real title "m51 real" verify=no
image.real,i_title: "m51  B  600s" -> "m51 real"
image.real updated
cl> hedit image.dbl title "m51 double" verify=no
image.dbl,i_title: "m51  B  600s" -> "m51 double"
image.dbl updated
```

We can verify the new title with the `imheader` task.

```
cl> imhead image*
image.dbl.fits[512,512][double]: m51 double
image.real.fits[512,512][real]: m51 real
image.sect.fits[101,101][real]: m51  B  600s
image.short.fits[512,512][short]: m51  B  600s
```

Hopefully all went well to this point. Let's clean things up a bit.

```
cl> dir
image.dbl.fits      image.sect.fits     uparmimlminmax.par  
image.real.fits     image.short.fits
cl> imdelete image.*
cl> dir
uparmimlminmax.par
```

Remember that if you want to delete any images you just use the task
`imdelete`. The task `delete` will delete your text files. If the
wrong task is used to delete images a warning message is printed and
no images are deleted.

If discrepancies occur during any of these steps, please look at the
examples closely. It might be advisable to backtrack a few steps and
verify things again. If the discrepancies are repeatable there could
indeed be a problem. Please document the discrepancy and feel free to
contact us if some advice or help is needed (iraf@noao.edu).
