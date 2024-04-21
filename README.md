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

本项目采用 GNU 协议，详情请参阅...。
