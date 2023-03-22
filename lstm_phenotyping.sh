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

CUDA_VISIBLE_DEVICES=0 CUDA_LAUNCH_BLOCKING=1 python fusion_main.py \
--dim 256 --dropout 0.3 --layers 2 \
--vision-backbone resnet34 --mode train \
--epochs 50 --batch_size 16 --lr 0.00053985 \
--vision_num_classes 25 --num_classes 25 \
--data_pairs partial_ehr \
--fusion_type uni_ehr \
--save_dir checkpoints/phenotyping/uni_ehr_full