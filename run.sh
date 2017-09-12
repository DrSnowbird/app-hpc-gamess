#!/bin/bash -x

if [ $# -lt 1 ]; then
    echo "Usage: "
    echo "  ${0} [<repo-name/repo-tag>] "
    echo "e.g."
    echo "  ${0} openkbs/app-hpc-gamess"
fi

##################################################
#### ---- Mandatory: Change those ----
##################################################
imageTag=${1:-"openkbs/app-hpc-gamess"}

PACKAGE=app-hpc-gamess
app-hpc-gamess_HOME=/usr/${PACKAGE}

## -- Don't change this --
PACKAGE=`echo ${imageTag##*/}|tr "/\-: " "_"`

#### ---- ports mapping ----
docker_port1=22
local_docker_port1=2222

##################################################
#### ---- Mostly, you don't need change below ----
##################################################
## -- mostly, don't change this --

#instanceName=my-${2:-${imageTag%/*}}_$RANDOM
#instanceName=my-${2:-${imageTag##*/}}
instanceName=`echo ${imageTag}|tr "/\-: " "_"`

#### ----- RUN -------
# docker logs -f ${instanceName} &

echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"

set -x
docker run --rm \
    -d \
    --name=${instanceName} \
    -p ${local_docker_port1}:${docker_port1} \
    ${imageTag}
set +x

echo ">>> Docker Status"
docker ps -a | grep "${instanceName}"
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lqa`"
echo "docker exec -it ${instanceName} /bin/bash"


