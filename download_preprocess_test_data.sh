# DONE: seperate the download script

SCAN_ID=$1;
SCANNET_ROOT=$2
SCRIPT_ROOT="./data_scripts/scannet_wrangling_scripts";
OUTPUT_PATH="results"
# CONFIG_FILE_PATH="configs/data/scannet_default_test.yaml"
CONFIG_FILE_PATH="configs/data/scannet_dense_test.yaml"

# download the datset
python $SCRIPT_ROOT/download_scannet.py -o $SCANNET_ROOT --id $SCAN_ID

# extract files (depth, jpg, intrinsics files) from downloaded `.sens` files,
# and make the directories
python $SCRIPT_ROOT/reader.py \
                 --scans_folder $SCANNET_ROOT/scans_test \
                 --output_path  $OUTPUT_PATH/scans_test \
                 --scan_list_file $SCRIPT_ROOT/splits/scannetv2_test.txt \
                 --num_workers 12 \
                 --export_poses \
                 --export_depth_images \
                 --export_color_images \
                 --export_intrinsics \
                 --single_debug_scan_id $SCAN_ID;

# create frame tuples: seperate keyframes and construct a corresponding tuple(s) to match
# this is for further visualization
# There are two choices of configs to set:
# 1. --data_config configs/data/scannet_default_test.yaml: defualt tuple, a tuple for every keyframe
# 2. --data_config configs/data/scannet_dense_test.yaml: defualt tuple, a tuple for every frame
python ./data_scripts/generate_test_tuples.py \
    --data_config $CONFIG_FILE_PATH \
    --num_workers 16 \
    --single_debug_scan_id $SCAN_ID \
    --gpus 4
