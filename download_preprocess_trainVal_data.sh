# DONE: seperate the download script

TRAIN_SCAN_ID=$1;
VAL_SCAN_ID=$2;
SCANNET_ROOT=$3;
SCRIPT_ROOT="data_scripts/scannet_wrangling_scripts";
OUTPUT_PATH="results"
TRAIN_CONFIG_FILE_PATH="configs/data/scannet_default_train.yaml"
# TRAIN_CONFIG_FILE_PATH="configs/data/scannet_dense_train.yaml"
VAL_CONFIG_FILE_PATH="configs/data/scannet_default_val.yaml"
# VAL_CONFIG_FILE_PATH="configs/data/scannet_dense_val.yaml"

# download the datset
# python $SCRIPT_ROOT/download_scannet.py -o $SCANNET_ROOT --id $TRAIN_SCAN_ID
# python $SCRIPT_ROOT/download_scannet.py -o $SCANNET_ROOT --id $VAL_SCAN_ID

# extract files (depth, jpg, intrinsics files) from downloaded `.sens` files,
# and make the directories
# python $SCRIPT_ROOT/reader.py \
#                  --scans_folder $SCANNET_ROOT/scans \
#                  --output_path  $SCANNET_ROOT/scans \
#                  --scan_list_file $SCRIPT_ROOT/splits/scannetv2_train.txt \
#                  --num_workers 12 \
#                  --export_poses \
#                  --export_depth_images \
#                  --export_color_images \
#                  --export_intrinsics \
#                  --single_debug_scan_id $TRAIN_SCAN_ID;

# python $SCRIPT_ROOT/reader.py \
#                  --scans_folder $SCANNET_ROOT/scans \
#                  --output_path  $SCANNET_ROOT/scans \
#                  --scan_list_file $SCRIPT_ROOT/splits/scannetv2_val.txt \
#                  --num_workers 12 \
#                  --export_poses \
#                  --export_depth_images \
#                  --export_color_images \
#                  --export_intrinsics \
#                  --single_debug_scan_id $VAL_SCAN_ID;

# create frame tuples: seperate keyframes and construct a corresponding tuple(s) to match
# this is for further visualization
# There are two choices of configs to set:
# 1. --data_config configs/data/scannet_default_test.yaml: defualt tuple, a tuple for every keyframe
# 2. --data_config configs/data/scannet_dense_test.yaml: defualt tuple, a tuple for every frame
python data_scripts/generate_train_tuples.py \
    --data_config $TRAIN_CONFIG_FILE_PATH \
    --num_workers 16 \
    --single_debug_scan_id $TRAIN_SCAN_ID \
    --gpus 4

python data_scripts/generate_train_tuples.py \
    --data_config $VAL_CONFIG_FILE_PATH \
    --num_workers 16 \
    --single_debug_scan_id $VAL_SCAN_ID \
    --gpus 4
