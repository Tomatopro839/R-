setwd("G:/R项目实战/项目一：客户细分分析（聚类分析）")
getwd()
##----1.加载数据与预处理----
# 安装必要包
install.packages(c("tidyverse", "cluster", "factoextra"))
library(tidyverse)
library(cluster)
library(factoextra)
data <- read.csv("Wholesale customers data.csv")

# 删除缺失值
data_clean <- na.omit(data)
# 标准化数据（聚类对量纲敏感）
scaled_data <- scale(data_clean[, 3:8])
##----2.确定最佳聚类数----
# 肘部法则
fviz_nbclust(scaled_data, kmeans, method = "wss") + 
  geom_vline(xintercept = 3, linetype = 2)
# 选择k=3
##----3.执行K-means聚类----
set.seed(123)
kmeans_result <- kmeans(scaled_data, centers = 3)
data_clean$cluster <- as.factor(kmeans_result$cluster)
##----4.可视化聚类结果----
# PCA降维后绘图
pca_result <- prcomp(scaled_data)
fviz_cluster(kmeans_result, data = scaled_data, geom = "point", ellipse.type = "norm")
##----5.分析分群特征----
cluster_summary <- data_clean %>%
  group_by(cluster) %>%
  summarise(across(Fresh:Delicassen, mean))
print(cluster_summary)
