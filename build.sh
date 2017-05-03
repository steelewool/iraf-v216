export iraf=`pwd`/
export host=unix/
export hlib=${iraf}${host}/hlib/
export PATH=$PATH:${iraf}${host}"/bin/"
export pkglibs=${iraf}noao/lib/,${iraf}${host}/hlib/libc/,${iraf}${host}/bin/
export HOST_CURL=1
export HOST_READLINE=1
export HOST_EXPAT=1
export HOST_CFITSIO=1
export HOST_XMLRPC=1
export IRAFARCH=`${hlib}irafarch.csh`

# Rob Steele added this, but ./install might be a better home:

echo $HOME
echo $iraf

# These softlinks were set referencing /iraf/iraf and the files did not exist under /iraf/iraf

pushd $iraf/sys/osb
rm bytmov.c
rm d1mach.f
rm i1mach.f
rm r1mach.f
ln -s $iraf/unix/as/bytmov.c   .
ln -s $iraf/unix/hlib/d1mach.f .
ln -s $iraf/unix/hlib/i1mach.f .
ln -s $iraf/unix/hlib/r1mach.f .
popd
# End of Rob's changes

rm -rf vo/votools/.old
rm -rf vo/votools/.url*
rm -f  ${host}/bin/*
rm -rf ${host}/bin.*/*
rm -f  ${host}/bin
ln -sf bin.${IRAFARCH} bin

pushd ${host}/hlib
ln -sf mach`getconf LONG_BIT`.h mach.h
ln -sf iraf`getconf LONG_BIT`.h iraf.h
popd

echo ${iraf}

find -name "*.a" | xargs rm -f
make src
export NOVOS=1
pushd vendor/voclient
make mylib
cp libvo/libVO.a ${iraf}lib
popd

${iraf}util/mksysnovos

echo $PWD

echo "This section built libVO.a"

unset NOVOS
export pkglibs=${iraf}noao/lib/,${iraf}${host}/bin/,${iraf}${host}/hlib/
pushd vendor/voclient
make clean
make mylib 
cp libvo/libVO.a ${iraf}lib
popd

echo "Do a find for libVO.a"

find . -name "libVO.a"


export pkglibs=${iraf}noao/lib/,${iraf}${host}/bin/,${iraf}${host}/hlib/libc/
${iraf}util/mksysvos
sed -i ${host}/hlib/mkiraf.csh -e s!/iraf/iraf!%{_libdir}/iraf!g
cp ${iraf}${host}/bin/*.a ${iraf}lib
rm pkg/utilities/nttools/xx_nttools.e

cd %{_builddir}/x11-iraf
rm ximtool/clients/x_ism.o
xmkmf
export PATH=$PATH:${iraf}${host}"/bin/"
make
