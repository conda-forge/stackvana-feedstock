set -ex

export EUPSPKG_NJOBS=2

# needed by scarlet apparently
ln -s ${PREFIX}/include/eigen3/Eigen ${PREFIX}/include/Eigen

# try newer eups
conda uninstall eups --force --yes
pip install --no-deps --no-build-isolation git+https://github.com/RobertLuptonTheGood/eups.git@u/timj/fix-close-file

stackvana-build ${eups_product}
