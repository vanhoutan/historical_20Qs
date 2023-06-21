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

## subset original long DF for survey question 
# for each panel, x = question, y = response
sector <- subset(demogrGRS, question == "sector")
p1 <- sector

# a basic bar plot
p1 <- ggplot(sector, aes(x = fct_infreq(response))) + # sort the response most to least 
  # if flip coord then use x = fct_rev(fct_infreq(response))
  themeKV + 
  theme(axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8)) + # names can be too long, let's shrink em
  geom_bar(fill = "#990033", alpha = 0.8, width = 0.85) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("institutional sector")
  #coord_flip() # make bars horizontal


p2 <- discipline

p3 <- work_system
p4 <- work_region

p5 <- scholarly_approach
p6 <- career_stage

p7 <- gender
p8 <- ethnicity


p9 <- first_language
p10 <- professional_language







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
  


