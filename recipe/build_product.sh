set -ex
mkdir -p $PREFIX/bin
echo "Some mention of $PREFIX" >> $PREFIX/bin/stakvana-product
exit 0
export EUPSPKG_NJOBS=2

# needed by scarlet apparently
ln -s ${PREFIX}/include/eigen3/Eigen ${PREFIX}/include/Eigen

stackvana-build ${eups_product}
