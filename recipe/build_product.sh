set -e

export EUPSPKG_NJOBS=2

# needed by scarlet apparently
ln -s ${PREFIX}/include/eigen3/Eigen ${PREFIX}/include/Eigen

#########################################################
# try newer eups
conda uninstall eups --force --yes

git clone https://github.com/beckermr/eups.git eups_new
pushd eups_new
git checkout u/timj/fix-close-file
EUPS_HOME="${PREFIX}/eups"
EUPS_DIR="${EUPS_HOME}"
export EUPS_PATH="${PREFIX}/share/eups"
EUPS_PYTHON=$PYTHON  # use PYTHON in the host env for eups
mkdir -p "${EUPS_HOME}"
# Install EUPS
echo -e "\nInstalling EUPS..."
echo "Using python at ${EUPS_PYTHON} to install EUPS"
# echo "Configured EUPS_PKGROOT: ${EUPS_PKGROOT}"
mkdir -p "${EUPS_PATH}"/{site,ups_db}
touch "${EUPS_PATH}/ups_db/.conda_keep"
./configure \
    --prefix="${EUPS_DIR}" \
    --with-eups="${EUPS_PATH}" \
    --with-python="${EUPS_PYTHON}"
make install
# eups installs readonly, need to give permission to the user in order to complete the packaging
chmod -R a+r "${EUPS_DIR}"
chmod -R u+w "${EUPS_DIR}"
# turn off eups locking
# echo "hooks.config.site.lockDirectoryBase = None" >> "${EUPS_DIR}/site/startup.py"
# make eups use a sane path to python in scripts
# the long line causes failures on linux
for fname in "eups" "eups_setup"; do
    cp "${EUPS_DIR}/bin/${fname}" "${EUPS_DIR}/bin/${fname}.bak"
    echo "#!/usr/bin/env python" > "${EUPS_DIR}/bin/${fname}"
    tail -n +1 "${EUPS_DIR}/bin/${fname}.bak" >> "${EUPS_DIR}/bin/${fname}"
    chmod 755 "${EUPS_DIR}/bin/${fname}"
    rm "${EUPS_DIR}/bin/${fname}.bak"
done
popd
# done eups install
#########################################################

stackvana-build ${eups_product}
