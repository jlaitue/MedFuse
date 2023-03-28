#!/bin/bash
#SBATCH -p nvidia
#SBATCH --gres=gpu:a100:1
#SBATCH --time=3-00:00:00 
#SBATCH --cpus-per-task=16
# Output and error files
#SBATCH -o outlogs/job.%J.out
#SBATCH -e errlogs/job.%J.err

# Resource requirements commands

# Activating conda
eval "$(conda shell.bash hook)"
conda activate bc

CUDA_VISIBLE_DEVICES=0 CUDA_LAUNCH_BLOCKING=1 python fusion_main.py --dim 256 \
--dropout 0.3 --mode eval \
--epochs 100 --pretrained \
--vision-backbone resnet34 --data_pairs radiology \
--batch_size 16 --align 0.0 --labels_set radiology --save_dir checkpoints/cxr_rad_full \