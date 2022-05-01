#!/usr/bin/env bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  RUNDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
RUNDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
ROOTDIR="$( cd -P "$( dirname "$RUNDIR/.././" )" >/dev/null 2>&1 && pwd )"
echo "This is stand rust Cross develop project tools: "
echo "script run at ${RUNDIR}"
echo "project root at ${ROOTDIR}"
cd "${ROOTDIR}" || exit


set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

DEBUG_RELEASE="release"
BUILD_TYPE="bin"
BUILD_CONTENT="test"

#BUILD_TYPE="example"
#BUILD_CONTENT="gatt_echo_server"


readonly TARGET_ARCH=aarch64-unknown-linux-gnu
readonly LINK_FLAGS='-L /usr/aarch64-linux-gnu/lib/ -L /usr/lib/aarch64-linux-gnu/'

# RUSTFLAGS=${LINK_FLAGS} cross build  --example gatt_server_cb --release --target=${TARGET_ARCH}
if [[ "${DEBUG_RELEASE}" == "debug" ]]; then
    RUSTFLAGS=${LINK_FLAGS} cross build  --${BUILD_TYPE} ${BUILD_CONTENT}  --target=${TARGET_ARCH}
else
    RUSTFLAGS=${LINK_FLAGS} cross build  --${BUILD_TYPE} ${BUILD_CONTENT} --release --target=${TARGET_ARCH}
fi



if [[ "${BUILD_TYPE}" == "example" ]]; then
  BUILD_TYPE="examples"
else
  if [[ "${BUILD_TYPE}" == "bin" ]]; then
    BUILD_TYPE=""
  fi
fi


mkdir -p "out/${TARGET_ARCH}/${DEBUG_RELEASE}/${BUILD_TYPE}"

cp "target/${TARGET_ARCH}/${DEBUG_RELEASE}/${BUILD_TYPE}/${BUILD_CONTENT}" "out/${TARGET_ARCH}/${DEBUG_RELEASE}/${BUILD_TYPE}/${BUILD_CONTENT}"