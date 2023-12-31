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


#### read in author demographic data, self-identified from a survey form
# setwd("/Users/kylevanhoutan/historical_20Qs/")
demogr <- read.csv('data/author_demogr.csv')
demogrG <- gather(demogr, key="survey", value="response", 2:31) # the number of cols may change
        # reshape from wide to long df
        # may need to change numbers depending on the # of cols
demogrGR <- demogrG[!(demogrG$response == ""), ]  # remove blank entries 
# rename gathered col's that from duplicate names had appended ".x" 
demogrGR$question <- sub("\\..*", "", demogrGR$survey) # truncates field entry after "."
demogrGRS = subset(demogrGR, select = -c(survey)) # remove the col with bad names "survey"

#### begin data viz for plots here

## subset original long DF for survey question 
# for each panel, x = question, y = response
p1sector <- subset(demogrGRS, question == "sector")
# a basic bar plot
p1 <- ggplot(p1sector, aes(x = fct_infreq(response))) + # sort the response most to least 
  themeKV + 
  theme(legend.position = "none",
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 6)) + # names can be too long, let's shrink em
# manually scraping hex codes from 10 category palette 👇
# https://colorbrewer2.org/#type=diverging&scheme=Spectral&n=10
  scale_fill_brewer(palette = "Spectral") +
  geom_bar(fill = "#9e0142", alpha = 0.85, width = 0.85) + # width controls gaps between bars
  scale_y_continuous(breaks = seq(0, 40, by = 8), 
                     ) +
  ylab("no. coauthors") +
  xlab("institution type")
  #coord_flip() # make bars horizontal


# bar plot, but flip due to category name lengths
p2discipline <- subset(demogrGRS, question == "discipline") ## subset original long DF for survey question 
p2 <- ggplot(p2discipline, aes(x = fct_rev(fct_infreq(response)))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 7.5)) + # names can be too long, let's shrink em
  geom_bar(fill = "#d53e4f", alpha = 0.85, width = 0.85) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("discipline") + 
  scale_y_continuous(breaks = seq(0, 30, by = 5), 
                     #limits = c(0,28),
  ) +
  coord_flip() # make bars horizontal


#subset for p3 data
p3scholarly_approach <- subset(demogrGRS, question == "scholarly_approach")
# a basic bar plot akin to p1
p3 <- ggplot(p3scholarly_approach, aes(x = fct_infreq(response))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 7.5)) + # names can be too long, let's shrink em
  geom_bar(fill = "#f46d43", alpha = 0.85, width = 0.9) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  scale_y_continuous(breaks = seq(0, 30, by = 5), 
                     limits = c(0,28),
                     ) +
  xlab("methodology")


# subset, then make bar akin to p1
p4work_system <- subset(demogrGRS, question == "work_system")
p4 <- ggplot(p4work_system, aes(x = fct_infreq(response))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 6)) + # names can be too long, let's shrink em
  geom_bar(fill = "#fdae61", alpha = 0.85, width = 0.85) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("study domain")


# subset for p5 data
p5work_region <- subset(demogrGRS, question == "work_region") ## subset original long DF for survey question 
# flipped bar plot akin to p2
p5 <- ggplot(p5work_region, aes(x = fct_rev(fct_infreq(response)))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 7.5)) + # names can be too long, let's shrink em
  geom_bar(fill = "#fee08b", alpha = 0.85, width = 0.85) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("study region") + 
  coord_flip() # make bars horizontal


# subset for p6 career stage data
p6career_stage <- subset(demogrGRS, question == "career_stage")
# bar plot akin to p1
p6 <- ggplot(p6career_stage, aes(x = fct_infreq(response))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8)) + # names can be too long, let's shrink em
  geom_bar(fill = "#e6f598", alpha = 0.9, width = 0.85) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("career stage")


# subset for p7 gender data
p7gender <- subset(demogrGRS, question == "gender")
# bar plot akin to p1
p7 <- ggplot(p7gender, aes(x = fct_infreq(response))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8),
        axis.text.x = element_text(size = 8)) + # names can be too long, let's shrink em
  geom_bar(fill = "#abdda4", alpha = 0.9, width = 0.9) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("gender")


# subset for p8 ethnicity data
p8ethnicity <- subset(demogrGRS, question == "ethnicity")
# flipped bar plot akin to p2
p8 <- ggplot(p8ethnicity, aes(x = fct_rev(fct_infreq(response)))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 7.5)) + # names can be too long, let's shrink em
  geom_bar(fill = "#66c2a5", alpha = 0.85, width = 0.85) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("ethnicity") + 
  coord_flip() # make bars horizontal


# subset for p9 first language learned data
p9first_language <- subset(demogrGRS, question == "first_language")
# flipped bar plot akin to p2
p9 <- ggplot(p9first_language, aes(x = fct_rev(fct_infreq(response)))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 7.5)) + # names can be too long, let's shrink em
  geom_bar(fill = "#3288bd", alpha = 0.85, width = 0.85) + # width controls gaps between bars
  # scale_y_continuous(breaks = seq(0, 40, by = 5)) +
  ylab("no. coauthors") +
  xlab("first language") + 
  coord_flip() # make bars horizontal



# subset for p10 professional languages used data
p10professional_language <- subset(demogrGRS, question == "professional_language")
# flipped bar plot akin to p2
p10 <- ggplot(p10professional_language, aes(x = fct_rev(fct_infreq(response)))) + # sort the response most to least 
  themeKV + 
  theme(axis.ticks.y = element_blank(),
        axis.text.x = element_text(size = 8),
        axis.text.y = element_text(size = 7.5)) + # names can be too long, let's shrink em
  geom_bar(fill = "#5e4fa2", alpha = 0.85, width = 0.85) + # width controls gaps between bars
  ylab("no. coauthors") +
  xlab("work languages") + 
  scale_y_continuous(breaks = seq(0, 40, by = 8)) +
  coord_flip() # make bars horizontal

# invoke patchwork to call and layout the above panels
# force layout given the vertical dimension needed for language plots
# below layout considers the following row themes:
# r1 = academic
# r2 = geography
# r3 = demographic
# r4 = language


layout <- "
AABBCC
AABBCC
DDEE##
DDEE##
FFGGHH
FFGGHH
IIJJ##
IIJJ##
IIJJ##"
p1 + p2 + p3 + p4 + p5 + p6 + p7 + p8 + p9 + p10 +
  plot_layout(design = layout) +
  plot_annotation(tag_levels = 'a') # add panel labels a, b, c... etc
