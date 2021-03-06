# HASM_SILAC
This repository includes code for processing data of hasm_silac_protein. hasm_silac_protein_total.Rmd script has code for the results.

## Install the software, download the data and set up the directory
This pipeline is designed to be used in R environment.

1. Install the R statistical package. We used version 4.0.4.

2. Install the following R packages, which can be obtained using either the install.packages function in R or via the Bioconductor framework:

* limma
* proDA
* sva
* calibrate
* ggplot
* fgsea
* tidyverse
* data.table

### dep_AC2_AC6_VS_lacZ
Using 9samples_raw.txt to generate the differentially expressed proteins

### david_AC2_AC6_VS_lacZ
Input the differentially expresed protein into [david functional annotation bioinformatics](https://david.ncifcrf.gov/), generate the GO analysis. Only picked the Description, Gene_COunt, P_Vale and Enrichment_Ratio value to generate the new *.txt file.

### fgsea_AC2_AC6_VS_lacZ
Using c2.cp.v7.2.symbols.gtm and c2.cp.kegg.v7.2.symbols.gmt, gene name and the t-test value to generate the kegg and canonical pathway.

## Contact information

* Moom R. Roosam. [roosan@chapman.edu](mailto:roosan@chapman.edu)
* Yue Li. [yli1@chapman.edu](mailto:yli1@chapman.edu)


    
