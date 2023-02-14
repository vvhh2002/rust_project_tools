#!/usr/bin/env bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  RUNDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
RUNDIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
ROOTDIR="$( cd -P "$( dirname "$RUNDIR/.././" )" >/dev/null 2>&1 && pwd )"
echo "This is stand CMake develop project tools"
echo "script run at ${RUNDIR}"
echo "project root at ${ROOTDIR}"
cd "${ROOTDIR}" || exit


echo "./3rds all 3rd part components src and lib"


mkdir -p 3rds
mkdir -p doc
mkdir -p tools
mkdir -p .cargo
mkdir -p examples
mkdir -p tools
mkdir -p crates

\cp "${RUNDIR}/template/.gitignore" ./

cp "${RUNDIR}/template/.cargo/config" ./.cargo/