setwd(LD_DIR); cat("当前工作目录：", getwd())
exposure_csv_file <- file.path(COR_DIR, "exposure.pvalue.csv")
CLUMP_KB <- 500  # 连锁互换的距离（建议值：10000）
CLUMP_R2 <- 0.1  # 连锁互换的 R² 阈值（建议值：0.001）

# ---读取暴露数据
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# ---去除连锁不平衡的 SNP 并保存
unclump_snps <- ieugwasr::ld_clump(dat = dplyr::tibble(rsid = exposure_data$SNP, pval = exposure_data$pval.exposure, id = exposure_data$id.exposure),
                                   clump_kb = CLUMP_KB,
                                   clump_r2 = CLUMP_R2,
                                   plink_bin = get_plink_exe(),
                                   bfile = file.path(LD_REF, EXPOSURE_POP))
exposure_data <- exposure_data %>%
  dplyr::inner_join(unclump_snps, by = c("SNP" = "rsid")) %>%
  dplyr::select(names(.))
print(paste("剩余", nrow(exposure_data), "个 SNP"))
write.csv(exposure_data, file = "exposure.LD.csv", row.names = FALSE); file.create(paste0("exposure.LD.csv - ", CLUMP_KB, " kb, ", CLUMP_R2, "R²"))

rm(list = setdiff(ls(), GLOBAL_VAR))  # 移除无用的变量
