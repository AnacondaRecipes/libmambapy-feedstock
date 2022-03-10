#!/bin/bash

# pip install...
cd mamba
echo "Preparing to pip install mamba."
$PYTHON -m pip install . --no-deps -vv


# Add symlink in condabin...
echo "Adding mamba symlink to condabin."
mkdir -p $PREFIX/condabin
ln -s $PREFIX/bin/mamba $PREFIX/condabin/mamba
