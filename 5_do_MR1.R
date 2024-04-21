setwd(MR_DIR); cat("当前工作目录：", getwd())
exposure_csv_file <- file.path(MR_CON_DIR, "exposure.confounder.csv")
outcome_file <- file.path(FMT_DIR, paste0(OUTCOME_NAME, "_", OUTCOME_DATA_ID, "_formatted.csv.gz"))


# ---读取整理好的暴露数据
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# ---读取结局数据
outcome_data <- TwoSampleMR::read_outcome_data(  # 注意列名！
  filename = outcome_file, sep = ',',
  snp_col = 'SNP',
  effect_allele_col = 'A1', other_allele_col = 'A2',
  beta_col = 'BETA', se_col = 'SE', eaf_col = 'FRQ', pval_col = 'P'
)

# ---筛选结局数据中，与工具变量相交集的部分，并输出到文件
outcome_table <- merge(exposure_data, outcome_data, by.x = "SNP", by.y = "SNP")
write.csv(outcome_table[, -(2:ncol(exposure_data))], file = "outcome.csv")
rm(outcome_table)

# ---将暴露数据和结局数据打标签后整合到一个数据框
exposure_data$exposure <- EXPOSURE_NAME
outcome_data$outcome <- OUTCOME_NAME
data <- TwoSampleMR::harmonise_data(exposure_data, outcome_data, action = 1)

# ---输出工具变量
write.csv(data[data$mr_keep == "TRUE",], file = "SNP.csv", row.names = FALSE)

# ---MR-PRESSO 方法进行异常值检测，得到偏倚的 SNP
mr_presso_result <- run_mr_presso(data)
write.csv(mr_presso_result[[1]]$
            `MR-PRESSO results`$
            `Outlier Test`, file = "outlier_SNPs.csv")


# ---执行孟德尔随机化分析
mr_result <- mr(data)
write.csv(generate_odds_ratios(mr_result), file = "MR-Result.csv", row.names = FALSE)

# ---异质性检验
write.csv(mr_heterogeneity(data), file = "heterogeneity.csv", row.names = FALSE)

# ---多效性检验
write.csv(mr_pleiotropy_test(data), file = "pleiotropy.csv", row.names = FALSE)

# ---绘图
pdf(file = "pic.scatter_plot.pdf", width = 7.5, height = 7); mr_scatter_plot(mr_result, data); dev.off()  # 散点图
res_single <- mr_singlesnp(data)
pdf(file = "pic.forest.pdf", width = 7, height = 6.5); mr_forest_plot(res_single); dev.off()  # 森林图
pdf(file = "pic.funnel_plot.pdf", width = 7, height = 6.5); mr_funnel_plot(singlesnp_results = res_single); dev.off()  # 漏斗图
pdf(file = "pic.leaveoneout.pdf", width = 7, height = 6.5); mr_leaveoneout_plot(leaveoneout_results = mr_leaveoneout(data)); dev.off()  # 敏感性分析

rm(list = setdiff(ls(), GLOBAL_VAR))  # 移除无用的变量
gc()  # 垃圾回收
