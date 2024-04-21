setwd(MR_CON_DIR); cat("当前工作目录：", getwd())
exposure_csv_file <- file.path(MR_WEAK_DIR, "exposure.F.csv")

# ---读取去除了弱工具变量的结果文件
exposure_data <- read.csv(exposure_csv_file, header = TRUE, sep = ",", check.names = FALSE)

# 获取当前的工具变量表型并保存到文件
snp_with_trait <- FastTraitR::look_trait(rsids = exposure_data$SNP, out_file = 'check_SNPs_trait.csv')
snp_with_trait_save <- snp_with_trait %>%
  arrange(trait) %>%
  select(trait) %>%
  distinct()  # 工具变量表型去重
writeLines(snp_with_trait_save$trait, 'check_SNPs_trait.txt')  # 保存到文件
print(paste("当前筛选到的 SNPs 表型描述，按行分隔地保存到了 check_SNPs_trait.txt 文件～"))

# ----👇手动整理混杂因素列表----
message(paste0("查看 check_SNPs_trait.txt 文件中的表型是否为 [", EXPOSURE_NAME, " → ", OUTCOME_NAME, "] 的混杂因素，\n将混杂因素保存到 ./4_remove_confounder/#confounder_SNPs.txt 文件！"))
if (file.info("#confounder_SNPs.txt")$size == 0) { stop("请手动整理混杂因素列表文件 #confounder_SNPs.txt！") }
# ----☝️手动整理混杂因素列表----

# ---比较并剔除包含在文本文件中的短语的 SNP，并保存到文件
confounders <- readLines("#confounder_SNPs.txt")
snp_with_trait$trait <- tolower(snp_with_trait$trait)  # 确保 trait 列文本均为小写
for (confounder in confounders) {
  snp_with_trait <- snp_with_trait[!grepl(tolower(confounder), snp_with_trait$trait),]
}
snp_with_trait <- dplyr::distinct(snp_with_trait, rsid, .keep_all = FALSE)  # 去重
exposure_data <- exposure_data %>%
  dplyr::inner_join(snp_with_trait, by = c("SNP" = "rsid")) %>%
  dplyr::select(names(exposure_data))
print(paste("剔除混杂因素后，剩余", nrow(exposure_data), "个 SNP"))
print(paste("剩余", nrow(exposure_data), "个 SNP"))
write.csv(exposure_data, "exposure.confounder.csv", row.names = FALSE)

rm(list = setdiff(ls(), GLOBAL_VAR))  # 移除无用的变量
