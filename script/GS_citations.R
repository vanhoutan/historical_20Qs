#### this script is for plotting Google Scholar citations 
#### tentatively figure 1 in the manuscript
#### of data from the project entitled "Global research priorities for historical ecology to inform conservation"
#### known colloquially as HE 20Qs 


library(ggplot2)      # plotting and viz
library(ggthemes)     # helpful ggplot themes
library(RColorBrewer) # pretty colors
library(patchwork)


# custom ggplot theme
themeKV <- theme_few()+
  theme(strip.background = element_blank(),
        axis.line = element_blank(),
        axis.text.x = element_text(colour = "black", margin = margin(0.2, unit = "cm")),
        axis.text.y = element_text(colour = "black", margin = margin(c(1, 0.2), unit = "cm")),
        axis.ticks.x = element_line(colour = "black", linewidth=.25), 
        axis.ticks.y = element_line(colour = "black", linewidth=.25),
        axis.ticks.length=unit(-0.15, "cm"), 
        element_line(colour = "black", linewidth=.5),
        panel.border = element_rect(colour = "black", fill=NA, linewidth=.5),
        legend.title=element_blank(),
        strip.text=element_text(hjust=0))


#### read in Google Scholar citation data
## query for the exact phrase "historical ecology" annually from 1970-present
## tabulating the counts from queries like this:
## https://scholar.google.com/scholar?q=%22historical+ecology%22&hl=en&as_sdt=0%2C10&as_ylo=2022&as_yhi=2022


# setwd("/Users/kylevanhoutan/historical_20Qs/")
cites <- read.csv('data/citations.csv')

ggplot(cites, aes(x = YEAR, y = CITATIONS, group = SEARCH, color = SEARCH)) +
  themeKV + 
  theme(#axis.title.x=element_blank(),
        axis.text.y = element_text(size = 9),
        axis.text.x = element_text(size = 9)) + 
  geom_line(aes(color=SEARCH), stat="smooth", method = "loess", formula = y ~ x, span = 0.15, 
            se = FALSE, linewidth = 1.8, alpha = 0.5)  +
  scale_color_manual(values=c("#abdda4", "#3288bd")) + 
  geom_point(size = 3.3, shape = 16, alpha = 0.8) +
  scale_fill_manual(values=c("#abdda4", "#3288bd")) + 
  scale_y_continuous(breaks = seq(0, 2000, by = 200)) +
  ylab("no. publications") +
  xlab("publication year")
