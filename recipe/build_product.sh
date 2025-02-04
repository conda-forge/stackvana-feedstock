set -ex

export EUPSPKG_NJOBS=2

# needed by scarlet apparently
ln -s ${PREFIX}/include/eigen3/Eigen ${PREFIX}/include/Eigen

. ${RECIPE_DIR}/stackvana-build-local.sh source_injection ${eups_product} 
