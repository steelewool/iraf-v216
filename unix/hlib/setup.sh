#!/bin/bash

# Prevent the setup scripts from running recursively
if [ -z "$iraf_hlib_setup" ]; then

    # Allow a previously defined $iraf to be used.
    if [ -z $iraf ]; then
        export iraf=/iraf/iraf/
    fi

    # Allow a previously defined $IRAFARCH to be used.
    if [ -z $IRAFARCH ]; then
        export IRAFARCH=`$iraf/unix/hlib/irafarch.sh -actual`
    fi
    source $iraf/unix/hlib/irafuser.sh

    export PATH=$HOME/.iraf/bin:${PATH}

    # The world'd most obvious alias ....
    alias iraf="xgterm -e cl &"

    # Set the $iraf_hlib_setup flag to avoid recursively running the setup scripts
    export iraf_hlib_setup=1
fi
