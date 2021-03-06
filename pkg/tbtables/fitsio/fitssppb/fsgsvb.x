include "fitsio.h"

procedure fsgsvb(iunit,colnum,naxis,naxes,fpixel,lpixel,inc,
                 nulval,array,anyflg,status)
# Read a subsection of byte values from the primary array.

int     iunit           # i input file pointer
int     colnum           # i colnum number
int     naxis           # i number of axes
int     naxes[ARB]      # i dimension of each axis
int     fpixel[ARB]     # i first pixel
int     lpixel[ARB]     # i last pixel
int     inc[ARB]        # i increment
int     nulval          # i value for undefined pi
int     array[ARB]      # o array of values
bool    anyflg          # o any null values?
int     status          # o error status

begin

call ftgsvb(iunit,colnum,naxis,naxes,fpixel,lpixel,inc,
                 nulval,array,anyflg,status)
end
