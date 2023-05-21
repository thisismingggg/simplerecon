# before starting, please make sure `dataset_path`s in configs/data/scannet_default_test.yaml
# and configs/data/scannet_dense_test.yaml to match where you download your dataset

SCAN_ID="scene0710_00"
SCANNET_ROOT="datasets/scannet"

# echo "Downloading and preprocessing data"
bash download_preprocess_test_data.sh $SCAN_ID $SCANNET_ROOT

echo "Inferring and evaluating depth maps and fusing meshes"
bash test_visualization.sh $SCAN_ID