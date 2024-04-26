# 菜鸟的孟德尔随机化分析

孟德尔随机化（Mendelian Randomization, MR）的基本原理是：

以 GWAS 的结果为基础，引入随机分配的遗传变异（即 SNPs）作为随机化工具（工具变量 (instrumental variable, IV)），替代暴露因素。

- 一方面，实验对象、顺序和样本的分配被随机化，随机引起的误差、处理效应和样本偏倚得以消除；
- 另一方面，使用工具变量而不是暴露因素，规避了混杂因素和反向因果的影响，大大降低结果受未知因素影响的可能性。

于是，在 MR 中引入工具变量，有助于揭示暴露因素与结局的因果关系，保证了结论的可靠性。

## 项目文件说明

- `README.md`：本文件，项目说明文档
- `#_env_init.R`：加载项目依赖
- `#_subsetting`：从数据集中提取子集，用于调试项目
- `0_0folder_init.R`：初始化每个孟德尔随机化分析的文件夹
- `0_1data_formating.R`：使用`MungeSumstats::format_sumstats()`格式化 GWAS 数据，以便后续分析
- `1_correlation_analysis.R`：基于关联性筛选 SNPs
- `2_linkage_disequilibrium_analysis.R`：基于连锁不平衡筛选 SNPs
- `3_remove_weak_IV.R`：基于 F 统计量筛选 SNPs
- `4_remove_confounder.R`：去可能引起混杂的 SNPs
- `5_do_MR1.R`：执行孟德尔随机化（Mendelian Randomization）分析
- `5_do_MR2.R`：绘制孟德尔随机化结果图

## 相关链接

- [孟德尔随机化方法 · 从入门到实践](https://www.yuque.com/tully-sci/consensus/wts8foqt1c2r6cqf)
- [孟德尔随机化 - 从入门到实践 | 自学 | 小白 | 代码 | 原理_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1Xm411k7ug)

## 开源协议

本项目采用 GNU 协议，详情请参阅 [LICENSE](https://github.com/TullyMonster/MendelRookie/blob/master/LICENSE)。

## 常见问题及可能的解决方案

### 获取 `FastTraitR` 和 `FastDownloader` 包

用于去除混杂因素的 `FastTraitR` 和 `FastDownloader` 包由[医工科研](https://www.medicineitlab.com/)
提供，详情参见：[`FastDownloader` 安装教程
](https://flash0926.yuque.com/org-wiki-flash0926-kivyu0/otdnsb/tluzaguvye4t9l08)。

|                  | Windows OS                                                         | Unix-like OS                                                                 |
|------------------|--------------------------------------------------------------------|------------------------------------------------------------------------------|
| `FastDownloader` | [FastDownloader-WindowsOS.zip](annex/FastDownloader-WindowsOS.zip) | [FastDownloader-Unix-likeOS.tar.gz](annex/FastDownloader-Unix-likeOS.tar.gz) |
| `FastTraitR`     | `FastDownloader::install_pkg("FastTraitR")`                        | `FastDownloader::install_pkg("FastTraitR")`                                  |

## Session 信息

<details>

```
R version 4.3.3 (2024-02-29 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 8 x64 (build 9200)

Matrix products: default


locale:
[1] LC_COLLATE=Chinese (Simplified)_China.936 
[2] LC_CTYPE=Chinese (Simplified)_China.936   
[3] LC_MONETARY=Chinese (Simplified)_China.936
[4] LC_NUMERIC=C                              
[5] LC_TIME=Chinese (Simplified)_China.936    

time zone: Asia/Shanghai
tzcode source: internal

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets 
[7] methods   base     

other attached packages:
 [1] GenomicFiles_1.38.0                     
 [2] BiocParallel_1.36.0                     
 [3] MungeSumstats_1.10.1                    
 [4] lubridate_1.9.3                         
 [5] forcats_1.0.0                           
 [6] stringr_1.5.1                           
 [7] purrr_1.0.2                             
 [8] readr_2.1.5                             
 [9] tibble_3.2.1                            
[10] tidyverse_2.0.0                         
[11] SNPlocs.Hsapiens.dbSNP155.GRCh38_0.99.24
[12] SNPlocs.Hsapiens.dbSNP155.GRCh37_0.99.24
[13] BSgenome_1.70.2                         
[14] rtracklayer_1.62.0                      
[15] BiocIO_1.12.0                           
[16] MRPRESSO_1.0                            
[17] FastTraitR_1.0.0                        
[18] FastDownloader_1.0.0                    
[19] plinkbinr_0.0.0.9000                    
[20] friendly2MR_0.2.0                       
[21] cowplot_1.1.3                           
[22] ggfunnel_0.1.0                          
[23] ggforestplot_0.1.0                      
[24] ggplot2_3.5.0                           
[25] LDlinkR_1.4.0                           
[26] MendelianRandomization_0.9.0            
[27] TwoSampleMR_0.5.11                      
[28] CMplot_4.5.1                            
[29] tidyr_1.3.1                             
[30] dplyr_1.1.4                             
[31] gwasglue_0.0.0.9000                     
[32] ieugwasr_0.2.2-9000                     
[33] gwasvcf_0.1.2                           
[34] VariantAnnotation_1.48.1                
[35] Rsamtools_2.18.0                        
[36] Biostrings_2.70.3                       
[37] XVector_0.42.0                          
[38] SummarizedExperiment_1.32.0             
[39] Biobase_2.62.0                          
[40] GenomicRanges_1.54.1                    
[41] GenomeInfoDb_1.38.8                     
[42] IRanges_2.36.0                          
[43] S4Vectors_0.40.2                        
[44] MatrixGenerics_1.14.0                   
[45] matrixStats_1.2.0                       
[46] BiocGenerics_0.48.1                     

loaded via a namespace (and not attached):
  [1] splines_4.3.3            later_1.3.2             
  [3] bitops_1.0-7             filelock_1.0.3          
  [5] R.oo_1.26.0              XML_3.99-0.16.1         
  [7] lifecycle_1.0.4          lattice_0.22-6          
  [9] MASS_7.3-60.0.1          backports_1.4.1         
 [11] magrittr_2.0.3           openxlsx_4.2.5.2        
 [13] plotly_4.10.4            rmarkdown_2.26          
 [15] yaml_2.3.8               remotes_2.5.0           
 [17] httpuv_1.6.15            zip_2.3.1               
 [19] sessioninfo_1.2.2        pkgbuild_1.4.4          
 [21] DBI_1.2.2                abind_1.4-5             
 [23] pkgload_1.3.4            zlibbioc_1.48.2         
 [25] R.utils_2.12.3           RCurl_1.98-1.14         
 [27] rappdirs_0.3.3           GenomeInfoDbData_1.2.11 
 [29] MatrixModels_0.5-3       codetools_0.2-20        
 [31] DelayedArray_0.28.0      xml2_1.3.6              
 [33] tidyselect_1.2.1         shape_1.4.6.1           
 [35] gmp_0.7-4                BiocFileCache_2.10.2    
 [37] GenomicAlignments_1.38.2 jsonlite_1.8.8          
 [39] ellipsis_0.3.2           survival_3.5-8          
 [41] iterators_1.0.14         foreach_1.5.2           
 [43] tools_4.3.3              progress_1.2.3          
 [45] Rcpp_1.0.12              glue_1.7.0              
 [47] SparseArray_1.2.4        xfun_0.43               
 [49] usethis_2.2.3            withr_3.0.0             
 [51] numDeriv_2016.8-1.1      BiocManager_1.30.22     
 [53] fastmap_1.1.1            fansi_1.0.6             
 [55] SparseM_1.81             digest_0.6.35           
 [57] timechange_0.3.0         R6_2.5.1                
 [59] mime_0.12                colorspace_2.1-0        
 [61] arrangements_1.1.9       biomaRt_2.58.2          
 [63] RSQLite_2.3.6            R.methodsS3_1.8.2       
 [65] utf8_1.2.4               generics_0.1.3          
 [67] data.table_1.15.4        robustbase_0.99-2       
 [69] prettyunits_1.2.0        httr_1.4.7              
 [71] htmlwidgets_1.6.4        S4Arrays_1.2.1          
 [73] pkgconfig_2.0.3          gtable_0.3.4            
 [75] blob_1.2.4               htmltools_0.5.8.1       
 [77] profvis_0.3.8            scales_1.3.0            
 [79] png_0.1-8                knitr_1.46              
 [81] tzdb_0.4.0               rjson_0.2.21            
 [83] curl_5.2.1               cachem_1.0.8            
 [85] parallel_4.3.3           miniUI_0.1.1.1          
 [87] AnnotationDbi_1.64.1     restfulr_0.0.15         
 [89] pillar_1.9.0             grid_4.3.3              
 [91] vctrs_0.6.5              urlchecker_1.0.1        
 [93] promises_1.3.0           dbplyr_2.5.0            
 [95] xtable_1.8-4             evaluate_0.23           
 [97] GenomicFeatures_1.54.4   cli_3.6.2               
 [99] compiler_4.3.3           rlang_1.1.3             
[101] crayon_1.5.2             fs_1.6.3                
[103] stringi_1.8.3            viridisLite_0.4.2       
[105] assertthat_0.2.1         munsell_0.5.1           
[107] lazyeval_0.2.2           devtools_2.4.5          
[109] glmnet_4.1-8             quantreg_5.97           
[111] Matrix_1.6-5             hms_1.1.3               
[113] bit64_4.0.5              KEGGREST_1.42.0         
[115] shiny_1.8.1.1            googleAuthR_2.0.1       
[117] iterpc_0.4.2             gargle_1.5.2            
[119] broom_1.0.5              memoise_2.0.1           
[121] DEoptimR_1.1-3           bit_4.0.5
```

</details>
