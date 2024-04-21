setwd(FMT_DIR); cat("当前工作目录：", getwd())
exposure_file <- ""  # GWAS数据，用作暴露因素
outcome_file <- ""   # GWAS数据，用作结局


# format_gwas_data()开始--------------------
format_gwas_data <- function(file, f_fmt,
                             gws_refer_id, exposure_or_outcome_name, exposure_or_outcome_data_id,
                             chromo = '', position = '', eff_allele = '', non_eff_allele = '', beta_val = '', p_val = '',
                             columns_to_remove = c()) {
  formatted_file_name <- paste0(exposure_or_outcome_name, "_", exposure_or_outcome_data_id, "_formatted.csv.gz")
  if (file.exists(formatted_file_name)) {                                       # 格式化后的文件存在则跳过处理
    return(paste0("文件已存在（", formatted_file_name, "）。跳过格式化……"))
  } else { cat("开始读取数据……\n") }
  if_rename <- FALSE
  if (f_fmt == "tsv") { data <- readr::read_tsv(file); if_rename <- TRUE }       # 预读取 TSV 文件，并计划重命名列
  else if (f_fmt == "csv") { data <- readr::read_csv(file); if_rename <- TRUE }  # 预读取 CSV 文件，并计划重命名列
  else if (f_fmt == "vcf") { data <- file }                                      # VCF 文件不需要预读取
  else { stop(paste0("尚未支持 ", f_fmt, " 格式。数据格式化异常退出！")) }
  if (if_rename) {                                                               # 删除特定列并重命名列
    data <- data %>%
      select(-one_of(columns_to_remove)) %>%  # 删除指定列
      select_if(~!all(is.na(.))) %>%          # 删除所有值均为 NA 的列
      dplyr::rename(
        CHR = chromo,         # SNP 所在染色体号
        BP = position,        # SNP 所在染色体位置
        A1 = eff_allele,      # 效应等位基因
        A2 = non_eff_allele,  # 非效应等位基因
        BETA = beta_val,      # beta 值
        P = p_val             # P 值
      )  # 以上 6 列必须严格声明
    cat("预读取已完成，开始格式化……\n")
  }
  # 删除日志文件（文件名中包含“_log_”）
  for (file in list.files(getwd())) { if (grepl(paste0(exposure_or_outcome_name, "_", exposure_or_outcome_data_id, "_formatted_log_.+\\.txt"), file)) { file.remove(file) } }
  MungeSumstats::format_sumstats(  # 执行格式化
    data,
    ref_genome = gws_refer_id,                            # 用于GWAS的参考基因组标识符
    dbSNP = 155,                                          # dbSNP 版本号（144 或 155）
    ignore_multi_trait = TRUE,                            # 忽略多个 P 值
    strand_ambig_filter = FALSE,                          # 删除具有串不明确基因的 SNP
    bi_allelic_filter = FALSE,                            # 去除非双等位基因的 SNP
    allele_flip_check = FALSE,                            # 对照参考基因组检查并翻转等位基因方向
    indels = FALSE,                                       # 是否包含 indel 变异
    nThread = 16,                                         # 并行的线程数
    save_path = file.path(FMT_DIR, formatted_file_name),  # 输出格式化了的文件
    log_mungesumstats_msgs = TRUE,                        # 保存日志信息
    log_folder = getwd(),                                 # 日志文件夹保存路径
  )
  cat(paste0("格式化已完成：", formatted_file_name, "\n"))
}

# format_gwas_data()结束--------------------

# ---格式化暴露数据
format_gwas_data(file = exposure_file, f_fmt = "...",
                 gws_refer_id = EXPOSURE_REFER_ID, exposure_or_outcome_name = EXPOSURE_NAME, exposure_or_outcome_data_id = EXPOSURE_DATA_ID,
                 # chromo = "...", position = "...", eff_allele = "...", non_eff_allele = "...", beta_val = "...", p_val = "..."
)

# ---格式化结局数据
format_gwas_data(file = outcome_file, f_fmt = "...",
                 gws_refer_id = OUTCOME_REFER_ID, exposure_or_outcome_name = OUTCOME_NAME, exposure_or_outcome_data_id = OUTCOME_DATA_ID,
                 # chromo = "...", position = "...", eff_allele = "...", non_eff_allele = "...", beta_val = "...", p_val = "...",
)

rm(list = setdiff(ls(), GLOBAL_VAR))  # 移除无用的变量
