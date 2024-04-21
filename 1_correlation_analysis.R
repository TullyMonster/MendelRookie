setwd(COR_DIR); cat("当前工作目录：", getwd())
exposure_csv_file <- file.path(FMT_DIR, paste0(EXPOSURE_NAME, "_", EXPOSURE_DATA_ID, "_formatted.csv.gz"))
P_THRESHOLD <- 5e-05  # SNPs 筛选的阈值（建议值：5e-8）
output_fmt <- "png"   # 支持的格式：jpg、pdf、tiff、png

# ---读取数据完成了格式化的数据
exposure_data <- TwoSampleMR::read_exposure_data(  # 注意列名！
  filename = exposure_csv_file, sep = ',',
  snp_col = 'SNP', chr_col = 'CHR', pos_col = 'BP',
  effect_allele_col = 'A1', other_allele_col = 'A2',
  beta_col = 'BETA', se_col = 'SE', eaf_col = 'FRQ', pval_col = 'P',
  samplesize_col = 'N',
)

# ---必要时补齐 samplesize.exposure 列
if (all(is.na(exposure_data$samplesize.exposure))) {
  while (TRUE) {
    num <- readline(prompt = "samplesize.exposure 列缺失，请根据数据来源（网页、MataInfo、文献等）将该列填充为统一数值：")
    if (grepl("^\\d+\\.?\\d*$", num)) {
      exposure_data$samplesize.exposure <- as.numeric(num)
      message("已将 ", num, " 填充至 samplesize.exposure 列")
      break
    } else { stop("输入有误！只支持数值型") }
  }
}

# ---滤去关联性弱的 SNP 并输出到文件
output_data <- subset(exposure_data, pval.exposure < P_THRESHOLD)
cat(paste("剩余", nrow(output_data), "个 SNP"))
write.csv(output_data, file = 'exposure.pvalue.csv', row.names = FALSE); file.create(paste0("exposure.pvalue.csv - P＜", P_THRESHOLD))

# ---绘制曼哈顿图：准备数据并绘图输出
exposure_data <- exposure_data[, c("SNP", "chr.exposure", "pos.exposure", "pval.exposure")]
colnames(exposure_data) <- c("SNP", "CHR", "BP", "pvalue")
CMplot(exposure_data,
       plot.type = "m",  # m：线性曼哈顿图
       LOG10 = TRUE, threshold = P_THRESHOLD, threshold.lwd = 3, threshold.lty = 1, signal.cex = 0.2,
       chr.den.col = NULL, cex = 0.2, bin.size = 1e5, ylim = c(0, 50), width = 15, height = 9,
       file.output = TRUE, file = output_fmt, verbose = TRUE
)

rm(list = setdiff(ls(), GLOBAL_VAR))  # 移除无用的变量
gc()  # 垃圾回收
