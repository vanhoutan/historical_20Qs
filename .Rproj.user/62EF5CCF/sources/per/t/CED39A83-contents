#### this script is for organizing and creating data visualizations 
#### of data from the project entitled "Global research priorities for historical ecology to inform conservation"
#### known colloquially as HE 20Qs 


library(ggplot2)      # plotting and viz
library(plyr)         # legacy df manipulation
library(dplyr)        # variable grouping and manipulation
library(reshape)      # legacy df manipulation
library(data.table)   # legacy functions on df 
library(tidyr)        # gathering and spreading
library(zoo)          # roll mean
library(ggthemes)     # helpful ggplot themes
library(forcats)
library(scales)
library(RColorBrewer) # pretty colors
library(ggridges)
library(colorspace)


# custom ggplot theme
themeKV <- theme_few()+
  theme(strip.background = element_blank(),
        axis.line = element_blank(),
        axis.text.x = element_text(colour = "black", margin = margin(0.2, unit = "cm")),
        axis.text.y = element_text(colour = "black", margin = margin(c(1, 0.2), unit = "cm")),
        axis.ticks.x = element_line(colour = "black"), axis.ticks.y = element_line(colour = "black"),
        axis.ticks.length=unit(-0.15, "cm"),element_line(colour = "black", linewidth=.5),
        panel.border = element_rect(colour = "black", fill=NA, linewidth=.5),
        legend.title=element_blank(),
        strip.text=element_text(hjust=0))


#### read in author demographic data, self-identified from a survey form
# setwd("/Users/kylevanhoutan/historical_20Qs/")
demogr <- read.csv('data/author_demogr.csv')
demogrG <- gather(demogr, key="survey", value="response", 2:31) 
        # reshape from wide to long df
        # may need to change numbers depending on the # of cols
demogrGR <- demogrG[!(demogrG$response == ""), ]  # remove blank entries 
# rename gathered col's that from duplicate names had appended ".x" 
demogrGR$question <- sub("\\..*", "", demogrGR$survey) # truncates field entry after "."
demogrGRS = subset(demogrGR, select = -c(survey)) # remove the col with bad names "survey"


#### begin data viz for plots here
p1 <- sector
p2 <- discipline

p3 <- work system
p4 <- work region

p5 <- approach
p6 <- career stage

p7 <- gender
p8 <- ethnicity

p9 <- language first
p10 <- language professional







#### subset full data set for just wing data 
# focusing here on dispersal ability, so pulling "wing_Hwi" 
# wing_Hwi = hand wing index from Claramunt & Wright 2017, https://doi.org/10.1201/9781315120454
morph_HWi <- subset(morphs, MORPH == "wing_Hwi")
morph_HWi <- morph_HWi[!(morph_HWi$CODE == ""), ]  
# remove blank entries in species CODE, for congeners that haven't been rescaled and assigned a CODE





# invoke patchwork to call and layout the above panels
(p1 + p2) /
  (p3 + p4) /
  (p5 + p6) / 
  (p7 + p8) /
  (p9 + p10) +
  plot_annotation(tag_levels = 'a') # add panel labels a, b, c... etc
  


