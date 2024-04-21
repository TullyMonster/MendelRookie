install_if_not_installed <- function(pkg, install_function = install.packages) {
  # 检查包是否安装，或指定安装函数
  if (!requireNamespace(pkg, quietly = TRUE)) {
    if (identical(install_function, install.packages)) {
      install.packages(pkg)
    } else {
      install_function
    }
  }
}

pkgs <- c(  # 需要安装的包列表
  "VariantAnnotation", "gwasglue", "dplyr", "tidyr",
  "CMplot", "TwoSampleMR", "MendelianRandomization",
  "LDlinkR", "ggplot2", "ggforestplot", "ggfunnel",
  "cowplot", "friendly2MR", "plinkbinr", "FastDownloader",
  "FastTraitR", "MRPRESSO", "SNPlocs.Hsapiens.dbSNP155.GRCh37",
  "SNPlocs.Hsapiens.dbSNP155.GRCh38", "tidyverse",
  'MungeSumstats', 'GenomicFiles'
)

# 未安装则安装
install_if_not_installed("devtools")
install_if_not_installed("tidyverse")
install_if_not_installed("gwasglue", devtools::install_github("mrcieu/gwasglue", force = TRUE))
install_if_not_installed("BiocManager")
install_if_not_installed("VariantAnnotation", BiocManager::install)
install_if_not_installed("dplyr")
install_if_not_installed("tidyr")
install_if_not_installed("CMplot")
install_if_not_installed("remotes")
install_if_not_installed("TwoSampleMR", remotes::install_github("MRCIEU/TwoSampleMR"))
install_if_not_installed("MendelianRandomization")
install_if_not_installed("LDlinkR")
install_if_not_installed("ggfunnel", devtools::install_github("pedropark99/ggfunnel", force = TRUE))
install_if_not_installed("ggforestplot", devtools::install_github("NightingaleHealth/ggforestplot", force = TRUE))
install_if_not_installed("friendly2MR", devtools::install_github("xiechengyong123/friendly2MR", force = TRUE))
# install_friendly2MR_dependence()
install_if_not_installed("plinkbinr", devtools::install_github("explodecomputer/plinkbinr", force = TRUE))
# https://flash0926.yuque.com/org-wiki-flash0926-kivyu0/otdnsb/tluzaguvye4t9l08
install_if_not_installed("FastDownloader")
install_if_not_installed("FastTraitR", FastDownloader::install_pkg("FastTraitR"))
install_if_not_installed("MRPRESSO")
install_if_not_installed("SNPlocs.Hsapiens.dbSNP155.GRCh37", BiocManager::install("SNPlocs.Hsapiens.dbSNP155.GRCh37"))
install_if_not_installed("SNPlocs.Hsapiens.dbSNP155.GRCh38", BiocManager::install("SNPlocs.Hsapiens.dbSNP155.GRCh38"))
install_if_not_installed("MungeSumstats", BiocManager::install("MungeSumstats"))
install_if_not_installed("GenomicFiles", BiocManager::install("GenomicFiles"))

# 导入包
lapply(pkgs, function(pkg) {
  suppressMessages(library(pkg, character.only = TRUE, quietly = TRUE))
})
rm(list = ls())  # 包初始化结束