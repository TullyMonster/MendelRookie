# ---GWAS 数据暴露因素和结局简称、标识符、参考基因组标识符、人群类别
EXPOSURE_NAME <- ''     # 数据名称。建议使用英文简称，如 WBC、BMI 等
EXPOSURE_DATA_ID <- ''  # 数据标识符。建议使用英文简称，如 UK_Biobank_BMI 等
EXPOSURE_REFER_ID <- '' # GWAS 数据所用的参考序列版本，如 GRCh37 等
EXPOSURE_POP <- ''      # 人口学种群标识，如 AFR（非洲）、AMR（美洲）、EAS（东亚）、EUR（欧洲）、SAS（南亚）

OUTCOME_NAME <- ''
OUTCOME_DATA_ID <- ''
OUTCOME_REFER_ID <- ''
OUTCOME_POP <- ''

# 千人基因组计划中用于 LD 参考的数据集位置
LD_REF <- ''  # 下载 http://fileserve.mrcieu.ac.uk/ld/1kg.v3.tgz 文件，解压归档。保证该目录下有可用的 .bed、.bim 和 .fam 文件

# ---分析结果的根目录。必须预先手动创建
root_dir <- ''

# 子文件夹名
topic <- paste0(EXPOSURE_NAME, '(', EXPOSURE_DATA_ID, ')', '→', OUTCOME_NAME, '(', OUTCOME_DATA_ID, ')')
fmt <- '#_FORMATED_DATA'                   # 数据格式化
cor <- '1_correlation_analysis'            # 相关性分析
ld <- '2_linkage_disequilibrium_analysis'  # 连锁不平衡分析
mr_weak <- '3_remove_weak_IV'              # 弱工具变量剔除
mr_con <- '4_remove_confounder'            # 混杂因素剔除
mr <- '5_do_MR'                            # 孟德尔随机化分析

# 子文件夹路径
FMT_DIR <- file.path(root_dir, fmt)
TOPIC_DIR <- file.path(root_dir, topic)
COR_DIR <- file.path(root_dir, topic, cor)
LD_DIR <- file.path(root_dir, topic, ld)
MR_WEAK_DIR <- file.path(root_dir, topic, mr_weak)
MR_CON_DIR <- file.path(root_dir, topic, mr_con)
MR_DIR <- file.path(root_dir, topic, mr)
dirs <- list(FMT_DIR, TOPIC_DIR, COR_DIR, LD_DIR, MR_WEAK_DIR, MR_CON_DIR, MR_DIR)

# 文件目录与 #confounder_SNPs.txt 文件初始化
for (dir in dirs) { if (!dir.exists(dir)) { dir.create(dir) } }
confounder_file <- file.path(MR_CON_DIR, '#confounder_SNPs.txt')
if (!file.exists(confounder_file)) { file.create(confounder_file) }

# 移除无用的变量
GLOBAL_VAR <- c('EXPOSURE_NAME', 'OUTCOME_NAME',  # 暴露因素和结局的简称
                'EXPOSURE_DATA_ID', 'OUTCOME_DATA_ID',  # GWAS 数据标识符
                'EXPOSURE_REFER_ID', 'OUTCOME_REFER_ID',  # 参考基因组标识符
                'EXPOSURE_POP', 'OUTCOME_POP',  # 人群类别
                'LD_REF',  # 用于 LD 参考的数据集位置
                'FMT_DIR', 'COR_DIR', 'LD_DIR', 'MR_WEAK_DIR', 'MR_CON_DIR', 'MR_DIR',  # 子文件夹路径
                'GLOBAL_VAR')
rm(list = setdiff(ls(), GLOBAL_VAR))
