setwd("G:/R项目实战/项目二：销售数据时间序列预测")
getwd()
##----1.加载数据与处理时间----
library(lubridate)
sales <- read.csv("supermarket_sales - Sheet1.csv")
sales$Date <- dmy(sales$Date)
daily_sales <- sales %>%
  group_by(Date) %>%
  summarise(Total = sum(Total))
##----2.时间序列分解----
ts_data <- ts(daily_sales$Total, frequency = 7) # 假设周周期
decompose_result <- decompose(ts_data)
plot(decompose_result)
##----3.ARIMA模型训练----
library(forecast)
arima_model <- auto.arima(ts_data)
future_forecast <- forecast(arima_model, h = 90) # 预测90天
plot(future_forecast)
##----4.保存预测结果----
write.csv(future_forecast$mean, "sales_forecast.csv")
