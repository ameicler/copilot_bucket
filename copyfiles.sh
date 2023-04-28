#!/bin/bash

# Change the SOURCE_DIR to the relative path of your desired source directory
SOURCE_DIR="../APIBackend/src/Api.Backend"

# File paths relative to the source directory
FILES=(
  "Dal/LabellingTask/LabellingTaskDetails.cs"
  "Dto/LabellingTask/LabellingTaskDetails.cs"
  "Controllers/LabellingTaskControllers.cs"
  "Models/LabellingTask/LabellingTaskItem.cs"
)

# Iterate through FILES array
for REL_FILE_PATH in "${FILES[@]}"; do
  # Create the target directory
  mkdir -p "$(dirname "${REL_FILE_PATH}")"
  # Copy the file from source to the target folder
  cp "${SOURCE_DIR}/${REL_FILE_PATH}" "${REL_FILE_PATH}"
done
