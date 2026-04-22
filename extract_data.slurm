#!/bin/bash
#SBATCH --job-name=SRA_unpack
#SBATCH --output=logs/unpack_%A_%a.log
#SBATCH --partition=cpu
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --array=0-7  # Launches 8 jobs at once!

source activate sra
cd /lustre/home/robinsonam7/BIOS668/final_project
mkdir -p fastqs logs

SAMPLES=(SRR15657993 SRR15657994 SRR15657995 SRR15657996 SRR15657997 SRR15657998 SRR15657999 SRR15658000)
sra_id=${SAMPLES[$SLURM_ARRAY_TASK_ID]}

echo "Processing $sra_id on node $HOSTNAME"

# 1. Dump the files
# Using --temp to ensure temporary files don't clog your home dir
fasterq-dump --split-files --include-technical --outdir fastqs/ --temp /tmp $sra_id

# 2. Zip them immediately and individually
# This ensures that even if the job fails halfway, you have some compressed data
for f in fastqs/${sra_id}*.fastq; do
    echo "Zipping $f..."
    gzip "$f" 
done

echo "Finished $sra_id"
