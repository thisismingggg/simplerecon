# before starting, please make sure `dataset_path`s in configs/data/scannet_default_test.yaml
# and configs/data/scannet_dense_test.yaml to match where you download your dataset

TRAIN_SCAN_ID="scene0191_00"
VAL_SCAN_ID="scene0568_00"
SCANNET_ROOT="datasets/scannet"

# echo "Downloading and preprocessing data"
bash download_preprocess_trainVal_data.sh $TRAIN_SCAN_ID $VAL_SCAN_ID $SCANNET_ROOT

echo "Inferring and evaluating depth maps and fusing meshes"
# bash test_visualization.sh $SCAN_ID