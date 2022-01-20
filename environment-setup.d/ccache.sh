#!/bin/sh

# Adds ccache to compiler commands.

export CC="ccache $CC"
export CXX="ccache $CXX"
export CPP="ccache $CPP"
