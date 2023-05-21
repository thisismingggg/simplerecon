SCAN_ID=$1;
OUTPUT_PATH="results"
# CONFIG_FILE_PATH="configs/data/scannet_default_test.yaml"
CONFIG_FILE_PATH="configs/data/scannet_dense_test.yaml"

# Example command to just compute scores and cache the depth
# CUDA_VISIBLE_DEVICES=0 python test.py --name HERO_MODEL \
python test.py --name HERO_MODEL \
            --output_base_path $OUTPUT_PATH \
            --config_file configs/models/hero_model.yaml \
            --load_weights_from_checkpoint weights/hero_model.ckpt \
            --data_config $CONFIG_FILE_PATH \
            --num_workers 8 \
            --batch_size 4 \
            --single_debug_scan_id $SCAN_ID \
            --run_fusion \
            --depth_fuser open3d \
            --fuse_color \
            --dump_depth_visualization \
            --cache_depths \
            --gpus 4

# video visualization
# Example command to get visualizations for dense frames
# CUDA_VISIBLE_DEVICES=0 python ./visualization_scripts/visualize_scene_depth_output.py --name HERO_MODEL \
python ./visualization_scripts/visualize_scene_depth_output.py --name HERO_MODEL \
            --output_base_path $OUTPUT_PATH \
            --data_config $CONFIG_FILE_PATH \
            --num_workers 8 \
            --single_debug_scan_id $SCAN_ID \
            --gpus 4


# Example command to fuse depths into point clouds.
# CUDA_VISIBLE_DEVICES=0 python pc_fusion.py --name HERO_MODEL \
#             --output_base_path $OUTPUT_PATH \
#             --config_file configs/models/hero_model.yaml \
#             --load_weights_from_checkpoint weights/hero_model.ckpt \
#             --data_config $CONFIG_FILE_PATH \
#             --num_workers 8 \
#             --batch_size 4 \
#             --single_debug_scan_id $SCAN_ID

# mesh fusion
# Example command to get live visualizations for mesh reconstruction
# CUDA_VISIBLE_DEVICES=0 python visualize_live_meshing.py --name HERO_MODEL \
python visualize_live_meshing.py --name HERO_MODEL \
            --output_base_path $OUTPUT_PATH \
            --config_file configs/models/hero_model.yaml \
            --load_weights_from_checkpoint weights/hero_model.ckpt \
            --data_config $CONFIG_FILE_PATH \
            --run_fusion \
            --fuse_color \
            --dump_depth_visualization \
            --depth_fuser open3d \
            --num_workers 8 \
            --dump_depth_visualization \
            --single_debug_scan_id $SCAN_ID \
            --use_precomputed_partial_meshes \
            --gpus 4


echo ""
echo "Done."
echo "Evaluating metrics is in: ./$OUTPUT_PATH/HERO_MODEL/scannet/default/scores"
echo "Visualization video is in: ./$OUTPUT_PATH/HERO_MODEL/scannet/viz/default/depth_videos"
