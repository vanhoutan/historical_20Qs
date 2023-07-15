#### this script is for figure 2
#### for the project entitled "Global research priorities for historical ecology to inform conservation"
#### known colloquially as HE 20Qs 


library(ggplot2)      # plotting and viz
library(ggthemes)
library(grid)
library(gridExtra)
library(png)
library(patchwork) 
library(figpatch) 
library(lattice)


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


#### read in PNGs
pic1 <- readPNG(('image/pic1.png'), native = TRUE)
pic2 <- readPNG(('image/pic2.png'), native = TRUE)
pic3 <- readPNG(('image/pic3.png'), native = TRUE)
pic4 <- readPNG(('image/pic4.png'), native = TRUE)
pic5 <- readPNG(('image/pic5.png'), native = TRUE)


# p1 <- grid.arrange(rasterGrob(pic1),ncol=1)
# p2 <- grid.arrange(rasterGrob(pic2),rasterGrob(pic3),
#              rasterGrob(pic4),rasterGrob(pic5),
#              ncol=2)
# patchwork the final plot with added track map

grid.arrange(rasterGrob(pic1),
             rasterGrob(pic2),
             rasterGrob(pic3),
             rasterGrob(pic4),
             rasterGrob(pic5),
             layout_matrix=rbind(c(1,2,3),c(1,4,5)))
