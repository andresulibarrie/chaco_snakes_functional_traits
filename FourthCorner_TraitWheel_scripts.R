#### PACKAGES ####
required_packages <- c("tidyverse", "ade4", "RColorBrewer")

installed <- rownames(installed.packages())
for (p in required_packages) {
  if (!(p %in% installed)) install.packages(p)
}

library(tidyverse)
library(ade4)
library(RColorBrewer)

#### FUNCTIONS ####
acomodar<-function(matriz){
  matriz<-as.data.frame(matriz)
  rownames(matriz)<-matriz[,1]
  matriz<-matriz[,-1]
  return(matriz)
}

#### DATA IMPORT ####

# Assumes working directory = repository root

TraitsRel <- read.csv("traits.csv", sep=";")
TraitsRel$Mode <- as.factor(TraitsRel$Mode)
TraitsRel$Habit <- as.factor(TraitsRel$Habit)
TraitsRel <- TraitsRel[,c(1:3,12:21)]

Presences48 <- read.csv("presence_absence_matrix.csv", sep=";")
Environments <- read.csv("environmental_coverage_matrix.csv", sep=";")

L_Presences48 <- acomodar(Presences48)
R_Environments <- acomodar(Environments)
Q_TraitsRel <- acomodar(TraitsRel)

#### CORRELATIONS ####
CorrelacionRel <- cor(Q_TraitsRel[,c(-11,-12)], method = "spearman")

cor_matrix_rm1 <- CorrelacionRel           
cor_matrix_rm1[upper.tri(cor_matrix_rm1)] <- 0
diag(cor_matrix_rm1) <- 0

Q_TraitsRel <- Q_TraitsRel [,c(-2,-4,-9)]

set.seed(100)

#### FOURTH CORNER ANALYSIS ####
result <- fourthcorner(
  R_Environments, 
  L_Presences48, 
  Q_TraitsRel, 
  modeltype = 6, 
  nrepet = 9999
)

summary(result)
export <- print(result)
write.csv(export,"Results100.csv", row.names = TRUE)

#### CREATE ResDF FROM Results ####
# Convert result to data frame (if not already)
Results <- as.data.frame(export)

# Separate "Test" into Environment and Trait
library(tidyr)
library(dplyr)

ResDF <- Results %>%
  separate(Test, into = c("Environment", "Trait"), sep = " / ") %>%
  mutate(
    Trait = trimws(Trait),
    Environment = trimws(Environment)
  ) %>%
  select(Environment, Trait, Obs, Std.Obs, Pvalue)

ResDF <- ResDF %>%
  filter(Pvalue < 0.05)

# Check
head(ResDF)

#### TRAITWHEEL ####
df <- ResDF %>%
  arrange(Environment, Trait)

df$Obs <- as.numeric(df$Obs)
df$Std.Obs <- as.numeric(df$Std.Obs)
df$Pvalue <- as.numeric(df$Pvalue)

df$TraitID <- seq_len(nrow(df))
df$bar_length <- abs(df$Std.Obs)
df$color <- ifelse(df$Obs >= 0, "positive", "negative")

sector_df <- df %>%
  group_by(Environment) %>%
  summarise(
    start = min(TraitID) - 0.5,
    end   = max(TraitID) + 0.5
  ) %>% 
  ungroup() %>% 
  mutate(mid = (start + end) / 2)

n_env <- nrow(sector_df)
bg_colors <- brewer.pal(max(3, n_env), "Set2")[1:n_env]
names(bg_colors) <- sector_df$Environment

p_wheel <- ggplot() +
  geom_rect(
    data = sector_df,
    aes(xmin = start, xmax = end, ymin = 0, ymax = 3, fill = Environment),
    alpha = 0.25
  ) +
  geom_segment(
    data = df,
    aes(x = TraitID, xend = TraitID, y = 0, yend = bar_length, color = color),
    linewidth = 1.1
  ) +
  scale_color_manual(values = c("positive" = "forestgreen",
                                "negative" = "firebrick")) +
  geom_text(
    data = df,
    aes(x = TraitID, y = bar_length + max(bar_length)*0.10, label = Trait),
    size = 3
  ) +
  coord_polar(theta = "x") +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),)

p_wheel



