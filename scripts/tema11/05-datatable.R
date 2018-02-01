auto <- read.csv("../data/tema11/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))

install.packages("data.table")
library(data.table)

auto.dt <- data.table(auto)
class(auto.dt)

auto.dt[, .(mpg)]
auto.dt[, .(mpg, horsepower, acceleration)]

auto.dt[cylinders %in% c("3C", "4C", "5C")]
auto.dt[cylinders == "4C" & horsepower>100]
auto.dt[car_name %like% "mazda"]

auto.dt[, mean(mpg), by= cylinders]
auto.dt[, meanmpg := mean(mpg), by = cylinders]
        
head(auto.dt)
        
auto.dt[, c("sd_mpg", "z_mpg") := list(
  sd(mpg), round((mpg - mean(mpg))/sd(mpg),2)
), by = cylinders
]
auto.dt[1:5, c(1:3, 9:12), with = FALSE]        


auto.dt[, lapply(.SD, mean), 
        .SDcols = c("mpg", "horsepower")]

setkey(auto.dt, cylinders)
tables()

auto.dt["4C", c(1:3, 9:10), with = F]

auto.dt[,list(mean = mean(mpg), min = min(mpg),
              max = max(mpg), sd = sd(mpg)),
        by = cylinders]

###DT[i,j,by]

setkeyv(auto.dt, c("cylinders", "model_year"))
auto.dt[.("4C"), c(1:3, 9:10), with = F]



auto.dt[,.N, by = cylinders]
auto.dt["3C", .N]

auto.dt[, meanmpg:=NULL]
head(auto.dt)


#DT[i,j,by]

empl <- read.csv("../data/tema11/employees.csv", stringsAsFactors = F)
dept <- read.csv("../data/tema11/departments-1.csv", stringsAsFactors = F) 

empl.dt <- data.table(empl)
dept.dt <- data.table(dept)

setkey(empl.dt, "DeptId")

combine <- empl.dt[dept.dt]
head(combine)
combine[,.N]

dept2 <- read.csv("../data/tema11/departments-2.csv", stringsAsFactors = F)
dept2.dt <- data.table(dept2)

combine <- empl.dt[dept2.dt, allow.cartesian = T, nomatch = 0]
combine[,.N]

merge(empl.dt, dept2.dt, by = "DeptId") #InnerJoin
merge(empl.dt, dept2.dt, by = "DeptId", all.x = T) #Left Join
merge(empl.dt, dept2.dt, by = "DeptId", all.y = T) #Right Join
merge(empl.dt, dept2.dt, by = "DeptId", all = T) # Full Join



#DT[i,j,by]
#.SD -> guardar referencia a todas las columnas (salvo las del by)
  #.SDcols -> la referencia guardada a las columnas (son las que se pueden incluir o excluir en la 'j')
#.EACHI -> para agrupar por claves
#.N -> número de filas 
#.I -> los índices indicados en el DT


#Sueldo máximo de cada departamento....
empl.dt[dept2.dt, max(.SD), by = .EACHI, .SDcols = "Salary" ]

#Sueldo promedio por departamento
empl.dt[, .(AvgSalary = lapply(.SD, mean)),
        by = "DeptId", .SDcols = "Salary"]

empl.dt[dept2.dt, list(DeptName, 
                       AvgSalary = lapply(.SD, mean)),
        by = .EACHI, .SDcols = "Salary"]
