--------------------------------------------------------------------------------
PRE-TRANSPLANT BIOMARKERS FOR GRAFT FAILURE IN KIDNEY RECIPIENTS
--------------------------------------------------------------------------------

AUTHOR: Amanda Robinson
DATE: May 5, 2026
COURSE: BIOS 668 Final Project
REPO: https://github.com/amandamrobinson/BIOS668-final-project

--------------------------------------------------------------------------------
1. PROJECT OVERVIEW
--------------------------------------------------------------------------------
This project analyzes single-cell RNA-seq (scRNA-seq) data from four African 
American kidney transplant recipients to identify pre-transplant PBMC 
biomarkers associated with graft failure within three years.

--------------------------------------------------------------------------------
2. DIRECTORY STRUCTURE
--------------------------------------------------------------------------------
01_extract_data.slurm  - Slurm job to download FASTQ files
02_run_cellranger.sh   - Aligns and counts reads
03_manuscript.Rmd      - Primary R Markdown file containing the full analysis
reference.bib          - BibTeX bibliography file
vancouver.csl          - Citation style file

--------------------------------------------------------------------------------
3. ANALYSIS PIPELINE
--------------------------------------------------------------------------------

STAGE 1: HPC PROCESSING (Shell/SLURM)
- 01_get_data.sh: Downloads raw FASTQ files from GEO (GSE182916).
- 02_cellranger_count.sh: Aligns reads to GRCh38 using Cell Ranger v8.0.1.

STAGE 2: BIOINFORMATIC ANALYSIS (R/Seurat)
The manuscript.Rmd file performs the following operations:
- QC: Filtering via 3x MAD for nFeature/nCount and <10% mitochondrial reads.
- NORMALIZATION: SCTransform with regression of mitochondrial variance.
- INTEGRATION: Harmony integration to mitigate patient-specific batch effects.
- ANNOTATION: Automated cell-typing via Azimuth PBMC reference.
- DIFFERENTIAL EXPRESSION: Wilcoxon rank-sum test (Failure vs Stable).
- ENRICHMENT: GO (Biological Process) and KEGG pathway enrichment.

--------------------------------------------------------------------------------
4. REPRODUCIBILITY INSTRUCTIONS
--------------------------------------------------------------------------------
1. Clone the repository: 
   git clone https://github.com/amandamrobinson/BIOS668-final-project.git

2. Requirements: 
   R (version 4.5.3) and the following R packages:
   - tidyverse, Seurat, patchwork, Azimuth, clusterProfiler, 
     org.Hs.eg.db, ggrepel, knitr, kableExtra

3. Execution:
   Open the .Rmd file in RStudio. Ensure the working directory contains 
   the /data/ folder with the 10x matrix files. Knit to HTML or Word.
- Table_S3_KEGG_Results.csv: Full KEGG pathway enrichment table.

================================================================================
