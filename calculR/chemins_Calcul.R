library(lubridate)
library(magrittr)
library(arrow)
library(tidyr)
library(dplyr)
library(ggplot2)
library(openxlsx)
library(hablar)
library(ggridges)
library(stringr)
library(cowplot)

library(readr)
library(readxl)
library(assertr)
library(janitor)
library(lubridate, warn.conflicts = FALSE)
library(stringr)
library(dplyr, warn.conflicts = FALSE)
library(tidyr)
library(futile.logger)
library(arrow)

# 0. Choix du nombre de gares
choix <- 41

# 1. Pr¨¦paration des donn¨¦es
if (choix == 5) {
  stations <- data.frame(
    name = c("A","B","C","D","E"),
    x = c(274,440,616,758,1002),
    y = c(211,436,648,459,188),
    stringsAsFactors = FALSE
  )
  edges <- data.frame(
    from = c("A","B","B","C","C","D"),
    to   = c("B","C","D","B","D","E"),
    stringsAsFactors = FALSE
  )
}

if (choix == 28) {
  stations <- data.frame(
    name = c("Varsovie","Vladivostok","Khabarovsk","Irkustk","Novosibirsk",
             "Sebastopol","Bakou","Erevan","Tbilissi","Tashkent","Omsk",
             "Yekaterin...","Perm","Kazan","Samara","Tsaritsyn","Rostov",
             "Kharkov","Kiev","Minsk","Br.Litovsk","Riga","Tallin",
             "Helsinski","Moscou","Petrograd","Archangel","Murmansk"),
    x = c(645,4727,4788,3663,2883,1114,1595,1417,1389,2360,2561,2127,1999,
          1666,1715,1506,1343,1172,1021,909,767,775,833,774,1244,979,1378,1098),
    y = c(1970,2414,2106,1975,1794,2332,2480,2474,2324,2534,1819,1690,1642,
          1733,1888,2130,2219,2083,2044,1849,1936,1675,1513,1401,1713,1493,
          1198,920),
    stringsAsFactors = FALSE
  )
  edges <- data.frame(
    from = c("Murmansk","Archangel","Helsinski","Tallin","Tallin","Riga","Riga",
             "Riga","Br.Litovsk","Minsk","Minsk","Kiev","Kiev","Kharkov","Kharkov",
             "Kharkov","Rostov","Rostov","Rostov","Tsaritsyn","Tsaritsyn",
             "Tsaritsyn","Tbilissi","Tbilissi","Samara","Kazan","Kazan",
             "Petrograd","Samara","Kazan","Perm","Yekaterin...","Samara","Omsk",
             "Novosibirsk","Irkustk","Vladivostok","Khabarovsk","Khabarovsk"),
    to   = c("Moscou","Moscou","Petrograd","Petrograd","Riga","Petrograd",
             "Minsk","Br.Litovsk","Minsk","Moscou","Kiev","Moscou","Kharkov",
             "Sebastopol","Moscou","Rostov","Moscou","Tbilissi","Tsaritsyn",
             "Moscou","Samara","Tbilissi","Bakou","Erevan","Moscou","Moscou",
             "Rostov","Moscou","Tashkent","Perm","Yekaterin...","Omsk","Omsk",
             "Novosibirsk","Irkustk","Khabarovsk","Khabarovsk","Irkustk",
             "Novosibirsk"),
    stringsAsFactors = FALSE
  )
}

if (choix == 41) {
  stations <- data.frame(
    name = c("Murmansk","Helsinski","ID3","Petrograd","ID5","Archangel",
             "Tallin","Riga","Minsk","Br.Litovsk","Moscou","Kiev","Kharkov",
             "Sebastopol","Rostov","Tsaritsyn","ID17","ID18","Kazan","Samara",
             "Tbilissi","Erevan","Bakou","ID24","Tashkent","Perm","Yekaterin...",
             "Omsk","Novosibirsk","Irkustk","ID31","ID32","ID33","ID34","ID35",
             "ID36","Khabarovsk","ID38","Vladivostok","ID40","ID41"),
    x = c(1138,820,1146,1023,1092,1415,874,815,950,807,1286,1065,1218,1155,
          1382,1552,1419,1584,1718,1761,1418,1463,1644,2204,2403,2039,2172,
          2595,2926,3709,3609,4207,4298,4553,4569,4723,4829,4887,4777,2380,
          2517),
    y = c(955,1435,1579,1533,1269,1247,1552,1713,1886,1977,1755,2080,2126,
          2369,2252,2174,1971,1884,1775,1926,2379,2519,2518,2274,2574,1686,
          1733,1855,1834,2026,1901,2077,1923,1949,2021,2178,2146,2222,2450,
          1670,1715),
    stringsAsFactors = FALSE
  )
  edges <- data.frame(
    from = c("Yekaterin...","Vladivostok","Tsaritsyn","Tsaritsyn","Tsaritsyn",
             "Tbilissi","Tbilissi","Tallin","Tallin","Samara","Samara","Samara",
             "Rostov","Rostov","Rostov","Riga","Riga","Riga","Petrograd","Perm",
             "Omsk","Novosibirsk","Murmansk","Minsk","Minsk","Kiev","Kiev",
             "Kharkov","Kharkov","Kharkov","Khabarovsk","Khabarovsk","Kazan",
             "Kazan","Kazan","Irkustk","Helsinski","Br.Litovsk","Archangel","ID5",
             "ID5","ID3","ID3","ID17","ID17","ID17","ID17","ID18","ID18","ID18",
             "ID40","ID40","ID40","ID41","ID24","ID24","ID31","ID31","ID32",
             "ID32","ID33","ID34","ID35","ID36","ID38","ID38","ID40","ID41",
             "ID24","ID24","ID31","ID31","ID32","ID32","ID33","ID34","ID35",
             "ID36","ID38","ID38"),
    to   = c("Omsk","Khabarovsk","Moscou","Samara","Tbilissi","Bakou","Erevan",
             "Petrograd","Riga","Moscou","Tashkent","Omsk","Moscou","Tbilissi",
             "Tsaritsyn","Petrograd","Minsk","Br.Litovsk","Moscou","Yekaterin...",
             "Novosibirsk","Irkustk","Moscou","Moscou","Kiev","Moscou","Kharkov",
             "Sebastopol","Moscou","Rostov","Irkustk","Novosibirsk","Moscou",
             "Rostov","Perm","Khabarovsk","Petrograd","Minsk","Moscou","ID3",
             "Murmansk","Moscou","Petrograd","ID18","Moscou","Tsaritsyn","Rostov",
             "Moscou","Samara","Kazan","ID41","Yekaterin...","Perm","Omsk",
             "Tashkent","Samara","Novosibirsk","Irkustk","ID33","Irkustk","ID34",
             "ID35","ID36","Khabarovsk","Khabarovsk","Vladivostok","Perm","Omsk",
             "Tashkent","Samara","Novosibirsk","Irkustk","ID33","Irkustk","ID34",
             "ID35","ID36","Khabarovsk","Khabarovsk","Vladivostok"),
    stringsAsFactors = FALSE
  )
  #correction chemin
  edges<-edges%>%filter(from != "Murmansk" & from != "Moscou")
  edges<-edges%>%filter(from != "Khabarovsk" & from != "Novosibirsk")
  edges<-edges%>%filter(from != "Samara" & from != "Tashkent")
  edges<-edges%>%filter(from != "Kazan" & from != "Rostov")
  edges<-edges%>%filter(from != "Petrograd" & from != "Moscou")
  edges<-edges%>%filter(from != "Tsaritsyn" & from != "Moscou")
  edges<-edges%>%filter(from != "Irkustk" & from != "Khabarovsk")
  edges<-edges%>%filter(from != "Vladivostok" & from != "Khabarovsk")
  
  edgestemp<-c("Kazan","Perm")
  edges<-rbind(edges,edgestemp )
  edgestemp<-c("Samara","Omsk")
  edges<-rbind(edges,edgestemp )
  }



# Inversion de y pour l'affichage
stations$y <- - stations$y

# 2. Calcul des poids (distance euclidienne)
edges$weight <- with(edges, 
                     sqrt((stations$x[match(from, stations$name)] - stations$x[match(to, stations$name)])^2 +
                            (stations$y[match(from, stations$name)] - stations$y[match(to, stations$name)])^2)
)

# 3. Construction d'une liste d'adjacence (graphe non orient¨¦)
adj <- setNames(vector("list", nrow(stations)), stations$name)
for (i in seq_len(nrow(edges))) {
  f <- edges$from[i]; t <- edges$to[i]; w <- edges$weight[i]
  adj[[f]] <- rbind(adj[[f]], data.frame(node = t, weight = w, stringsAsFactors = FALSE))
  adj[[t]] <- rbind(adj[[t]], data.frame(node = f, weight = w, stringsAsFactors = FALSE))
}

# 4. Impl¨¦mentation de Dijkstra en base R
dijkstra <- function(adj, start) {
  nodes <- names(adj)
  dist <- setNames(rep(Inf, length(nodes)), nodes)
  prev <- setNames(rep(NA, length(nodes)), nodes)
  dist[start] <- 0
  Q <- nodes
  while (length(Q) > 0) {
    # choisir u dans Q minimisant dist[u]
    u <- Q[which.min(dist[Q])]
    Q <- setdiff(Q, u)
    # relaxation
    for (k in seq_len(nrow(adj[[u]]))) {
      v <- adj[[u]]$node[k]
      alt <- dist[u] + adj[[u]]$weight[k]
      if (alt < dist[v]) {
        dist[v] <- alt
        prev[v] <- u
      }
    }
  }
  list(dist = dist, prev = prev)
}

# 5. Calcul de tous les plus courts chemins
resultats <- list()
noms <- stations$name
n <- length(noms)

for (i in seq_len(n-1)) {
  start <- noms[i]
  dj <- dijkstra(adj, start)
  for (j in (i+1):n) {
    end <- noms[j]
    if (is.infinite(dj$dist[end])) next
    # reconstruction du chemin
    chemin <- end
    u <- end
    while (!is.na(dj$prev[u])) {
      u <- dj$prev[u]
      chemin <- c(u, chemin)
    }
    resultats[[paste(start, end, sep = "-")]] <- list(
      start    = start,
      end      = end,
      chemin   = chemin,
      distance = dj$dist[end]
    )
  }
}

# 6. Mise en forme des r¨¦sultats
transformer_positions <- function(chemin, stations_df) {
  coords <- sapply(chemin, function(st) {
    stn <- stations_df[stations_df$name == st, ]
    paste0(stn$x, ";", stn$y)
  })
  paste(coords, collapse = "£ü")
}

result_df <- data.frame(
  Chemin    = character(),
  Positions = character(),
  Distance  = numeric(),
  stringsAsFactors = FALSE
)

for (res in resultats) {
  direct  <- paste(res$chemin, collapse = " - ")
  inv     <- rev(res$chemin)
  inverse <- paste(inv, collapse = " - ")
  result_df <- rbind(
    result_df,
    data.frame(
      Chemin    = direct,
      Positions = transformer_positions(res$chemin, stations),
      Distance  = res$distance,
      stringsAsFactors = FALSE
    ),
    data.frame(
      Chemin    = inverse,
      Positions = transformer_positions(inv, stations),
      Distance  = res$distance,
      stringsAsFactors = FALSE
    )
  )
}

# 7. Affichage de la base de donn¨¦es
cat("Base de donn¨¦es des plus courts chemins (dans les deux sens) :\n")
print(result_df)

# 8. Visualisation
# trace des gares
plot(stations$x, stations$y, pch = 19, cex = 1.5, xaxt = "n", yaxt = "n", xlab = "", ylab = "", main = "Graphe des gares")
text(stations$x, stations$y, labels = stations$name, pos = 3)

# trace des ar¨ºtes et ¨¦tiquettes de poids
for (i in seq_len(nrow(edges))) {
  x0 <- stations$x[match(edges$from[i], stations$name)]
  y0 <- stations$y[match(edges$from[i], stations$name)]
  x1 <- stations$x[match(edges$to[i],   stations$name)]
  y1 <- stations$y[match(edges$to[i],   stations$name)]
  segments(x0, y0, x1, y1)
  xm <- (x0 + x1) / 2; ym <- (y0 + y1) / 2
  text(xm, ym, labels = round(edges$weight[i], 2), cex = 0.8, col = "blue")
}

write.csv2(result_df, "C:/Users/u99amo/Downloads/chemins.csv")