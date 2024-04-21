setwd(MR_WEAK_DIR); cat("当前工作目录：", getwd())
exposure_csv_file <- file.path(LD_DIR, "exposure.LD.csv")
F_THRESHOLD <- 10  # F 统计量阈值

# ---读取连锁不平衡分析结果文件
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# ---补齐 R² 和 F 列
exposure_data$R2 <- TwoSampleMR::get_r_from_bsen(exposure_data$beta.exposure, exposure_data$se.exposure, exposure_data$samplesize.exposure)^2
exposure_data$Fval <- (exposure_data$samplesize.exposure - 2) * exposure_data$R2 / (1 - exposure_data$R2)

# ---过滤保留 F>10 的工具变量
exposure_data <- exposure_data[exposure_data$F > F_THRESHOLD,]
print(paste("剩余", nrow(exposure_data), "个 SNP"))
write.csv(exposure_data, "exposure.F.csv", row.names = FALSE); file.create(paste0("exposure.F.csv - F＞", F_THRESHOLD))

rm(list = setdiff(ls(), GLOBAL_VAR))  # 移除无用的变量
