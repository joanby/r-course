#API Meetup
api_key <- "1e2029242634661b60467297d5b282"

topic <- "mathematics"
country <- "ES"
city <- "Madrid"
radius <- 50
fields <- "id,name,members"

url <- paste("https://api.meetup.com/2/groups?&topic=",topic,
             "&country=",country,
             "&city=",city,
             "&radius=",radius,
             "&only=",fields,
             "&key=",api_key,sep="")
url

library(jsonlite)
meetup.data <- fromJSON("../data/tema9/meetup-mathematics.json")
groups <- meetup.data$results
head(groups)



meetup.getUsers <- function(groups, api_key){
  users <- as.data.frame(NULL)
  for (i in 1:nrow(groups)) {
    url <- paste0("https://api.meetup.com/2/members?group_id=", groups$id[i],
                  "&only=id&key=",api_key)
    while (url!= "") {
      temp_json <- fromJSON(RCurl::httpGET(url))
      if(class(temp_json$results) == "data.frame"){
        tests <- cbind(group_id=groups$id[i],member_id=temp_json$results)
        users <- rbind(users,tests)
      }
      url <- temp_json$meta$`next`
    }
    print(paste0("Hemos recuprado los miembros del grupo ",i))
  }
  u <- data.frame(group_id = users$group_id, user_id = users$id)
  u
}


meetup.getGroups <- function(topic, api_key, 
                             country = "ES", city = "Madrid", radius = 100){
  groups <- as.data.frame(NULL)
  url <- paste0("https://api.meetup.com/2/groups?topic=", topic,
                "&country=",country,"&city=",city, "&radius=",radius,
                "&only=id,name,members&key=",api_key)
  while (url!= "") {
    temp_json <- fromJSON(RCurl::httpGET(url))
    if(class(temp_json$results) == "data.frame"){
      groups <- rbind(groups,temp_json$results)
    }
    url <- temp_json$meta$`next`
  }
  print(paste0("Hemos recuprado los grupos del tema ",topic))
  
  groups
}

groups <- meetup.getGroups("mathematics", api_key, radius = 1000)
groups

members <- meetup.getUsers(groups, api_key)
members

hiking.data <- fromJSON("../data/tema9/hiking-ny.json")
hiking.groups <- hiking.data$results
hiking.members <- meetup.getUsers(hiking.groups, api_key)


library(data.table)
users <- setDT(members)[, .SD[.N > 4], by = user_id]
save(users, file="../data/tema9/meetup-users.Rdata")

