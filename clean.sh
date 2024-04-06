#!/bin/bash

# Check if the correct number of command-line arguments is provided
if [ "$#" -ne 8 ]; then
    echo "Usage: $0 <input_ms_file> <output_image_name> <output_image_width> <output_image_height> <niter> <mythresh> <cell_size> <intout>"
    exit 1
fi

# Get input file name, output image name, and output image size from command-line arguments
input_ms_file="$1"
output_image_name="$2"
output_image_width="$3"
output_image_height="$4"
niter="$5"
mythresh="$6"
cell_size="$7"
intout="$8"


# Run wsclean with the provided parameters
/data2/ananya/trial/wsclean/build/wsclean \
    -name "$output_image_name" \
    -size "$output_image_width" "$output_image_height" \
    -scale "$cell_size" \
    -gridder wstacking \
    -weight briggs 0 \
    -niter "$niter" \
    -gain 0.1 \
    -abs-threshold "$mythresh" \
    -multiscale-scales 0,5,15 \
    -multiscale-scale-bias 0.6 \
    -pol I \
    -intervals-out "$intout" \
    -no-update-model-required \
    -mgain 0.85 \
    -wstack-oversampling 63 \
    -make-psf \
    -no-reorder \
    "$input_ms_file"

echo "Image generation complete."
