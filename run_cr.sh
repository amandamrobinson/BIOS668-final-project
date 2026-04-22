#!/bin/bash
#SBATCH --job-name=CR_Final
#SBATCH --output=logs/cr_%A_%a.log
#SBATCH --partition=cpu
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH --array=1-4
module load cellranger/8.0.1
cd /lustre/home/robinsonam7/BIOS668/final_project
ID="Patient${SLURM_ARRAY_TASK_ID}"
REF="/lustre/home/robinsonam7/BIOS668/final_project/refdata-gex-GRCh38-2020-A"
cellranger count --id="${ID}_results" --transcriptome=$REF --fastqs="${ID}/" --sample="${ID}" --create-bam true --localcores=16 --localmem=60
