# Bootstrap the UNIX bootstrap utilities and host system interface.
# Note - the environment variables HSI_CF and HSI_FF (compile/link flags)
# are required for the bootstrap; these are defined in hlib$irafuser.csh.
#
# USAGE:  `sh -x mkpkg.sh >& spool'  to bootstrap the IRAF HSI.

# Set the HSI architecture.
sh -x setarch.sh

echo "----------------------- OS -----------------------------"
echo "+"; echo "+"
(cd os;   sh -x mkpkg.sh)
echo "----------------------- F2C ----------------------------"
echo "+"; echo "+"
(cd f2c; sh -x mkpkg.sh)
echo "----------------------- BOOT ---------------------------"
echo "+"; echo "+"
(cd boot; sh -x mkpkg.sh)
#echo "----------------------- SHLIB --------------------------"
#echo "+"; echo "+"
#(cd shlib; sh -x mkpkg.sh)
echo "----------------------- GDEV ---------------------------"
(cd gdev; sh -x mkpkg.sh)

# Install the newly created executables.
echo "install HSI executables in $host/bin.$MACH"
mv -f hlib/*.e bin.$MACH

# When run from Joe's build.sh this pushd and popd are returning errors
echo "error in push, pushd bin.$MACH"
echo "print working directory: $PWD"

# pushd bin.$MACH

cd $PWD/bin.$MACH

for i in *.e
do ln -sf $i ${i%.*}
done

# popd

cd $PWD
