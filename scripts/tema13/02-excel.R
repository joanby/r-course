#xlsx, RExcel, XLConnect
install.packages("xlsx")
library(xlsx)

auto <- read.csv("../../../data/tema13/auto-mpg.csv", stringsAsFactors=F)

write.xlsx(auto, file = "../../../data/tema13/auto.xlsx",
           sheetName = "Raw Data Autos", row.names = F)

auto$kpg <- auto$mpg * 1.609
auto$z.mpg <- (auto$mpg - mean(auto$mpg))/sd(auto$mpg)


auto.wb <- createWorkbook()
sheet1 <- createSheet(auto.wb, "auto1")
rows <- createRow(sheet1, rowIndex = 1)
cell.1 <- createCell(rows, colIndex = 1)[[1,1]]
setCellValue(cell.1, "Hola Data Frame de Coches!")
addDataFrame(auto, sheet1, startRow = 3, row.names = F)

cs <- CellStyle(auto.wb) +
  Font(auto.wb, isBold = T, color="red")
setCellStyle(cell.1, cs)

saveWorkbook(auto.wb, "../../../data/tema13/auto-wb.xlsx")


wb <- loadWorkbook("../../../data/tema13/auto-wb.xlsx")
sheets <- getSheets(wb)
sheet <- sheets[[1]]
addDataFrame(auto[,10:11], sheet, startColumn = 10, startRow = 3, row.names = F)
saveWorkbook(wb, "../../../data/tema13/auto-new.xlsx")


new.auto <- read.xlsx("../../../data/tema13/auto-new.xlsx", sheetIndex = 1)
head(new.auto)
new.auto <- read.xlsx("../../../data/tema13/auto-new.xlsx", 
                      sheetName = "auto1",
                      rowIndex = 3:10, colIndex= 1:9)
head(new.auto)
