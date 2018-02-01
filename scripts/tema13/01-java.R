#Java
library(rJava)
.jinit()
.jcall("java/lang/System", "S", "getProperty", "java.runtime.version")
getwd()
setwd("tema13")
setwd("java-files")

.jaddClassPath(getwd())
.jclassPath()

###String de Java
s <- .jnew("java/lang/String", "Hola, soy Juan Gabriel y este es mi curso")
print(s)
.jstrVal(s) #toString()
.jcall(s, "S", "toLowerCase")
.jcall(s, "S", "toUpperCase")
.jcall(s, "S", "replaceAll", "Juan Gabriel", "un alumno")

#Valores de retorno en Java
#I : int
#D : double
#J : long
#F : float
#V : void
#Z : boolean
#C : char
#B : byte
#L<class> : Objetos de la clase <class>
#S : String (java.lang.String)
#[<type>: arrays de objetos de tipo <type>, [S: array de Strings



###Vectores de Java
v <- .jnew("java/util/Vector")
months <- month.abb
months
sapply(months, v$add) # v.add(months) 
v$size()
v$toString()


###Calendario y Arrays
monthArray <- .jarray(month.abb)
yearsArray <- .jarray(as.numeric(2011:2017))
calArray <- .jarray(list(monthArray, yearsArray))
print(calArray)
.jevalArray(calArray)
.jevalArray(monthArray)
print(l <- .jevalArray(calArray))
l
lapply(l, .jevalArray)


###Clase Hello World
hw <- .jnew("HelloWorld")
hello <- .jcall(hw, "S", "getString")
hello

greet <- .jnew("Greeting")
print(greet)

jb <- .jcall(greet, "S", "getString", "Juan Gabriel")
print(jb)
.jstrVal(jb)

#Parámetros de config de la JVM
jvm <- .jnew("java.lang.System")
jvm.props <- jvm$getProperties()$toString()
jvm.props
jvm.props <- strsplit(gsub("\\{(.*)}","\\1", jvm.props), ", ")
jvm.props[[1]]

#Lista de métodos disponibles
.jmethods(s)
.jmethods(s, "trim")
