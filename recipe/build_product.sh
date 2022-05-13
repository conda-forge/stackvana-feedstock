set -ex

conda uninstall eigen --force --yes --offline

export EUPSPKG_NJOBS=2

###############################################################################
# now build eigen and symlink it to where it can be found by default
# this is for scarlet
# this can be removed once eigen 3.4 is in use
echo "
Building eigen and making the symlinks..."
stackvana-build eigen

echo "======================================"
echo "======================================"
ls -lah ${EUPS_PATH}/*/eigen/*
echo "======================================"
echo "======================================"

if [[ `uname -s` == "Darwin" ]]; then
    eigendir=$(compgen -G "${EUPS_PATH}/DarwinX86/eigen/g04a8d4365e*")
else
    eigendir=$(compgen -G "${EUPS_PATH}/Linux64/eigen/g04a8d4365e*")
fi
ln -s ${eigendir}/include/eigen3/Eigen ${PREFIX}/include/Eigen

stackvana-build ${eups_product}
