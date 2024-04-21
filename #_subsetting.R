# 抽取数据集子集
extract_subset <- function(file_path, b = 1, N, subset_file) {
  head_lines <- readr::read_lines(file_path, skip = 0, n_max = b)
  remaining_lines <- readr::read_lines(file_path, skip = b + 1)
  sample_lines <- sample(remaining_lines, N)
  write_lines(c(head_lines, sample_lines), subset_file)
}

# 使用示例
# extract_subset(input_file, 1, 100, output_file)
