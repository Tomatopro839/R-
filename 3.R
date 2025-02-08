setwd("G:/R项目实战/项目三：泰坦尼克号数据清洗")
getwd()
##----1.加载与探索数据----
titanic <- read.csv("titanic.csv")
summary(titanic) # 查看Age/Fare的缺失值和分布
##----2.清洗数据----
# 填充Age缺失值（用中位数）
titanic$Age[is.na(titanic$Age)] <- median(titanic$Age, na.rm = TRUE)
##----3.特征工程----
# 创建家庭规模特征
titanic$FamilySize <- titanic$SibSp + titanic$Parch + 1
# 分箱Fare（离散化）
titanic$FareCategory <- cut(titanic$Fare, breaks = c(0, 20, 50, 100, 600), labels = c("Low", "Medium", "High", "Very High"))
##----4.保存清洗后数据----
write.csv(titanic, "titanic_clean.csv")
