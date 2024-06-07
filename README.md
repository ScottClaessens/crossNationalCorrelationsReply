# Reply to: Controlling for non-independence of nations should NOT be the default choice in cross-cultural research

This repository contains the R code for the manuscript "Reply to: Controlling for non-independence of nations should NOT be the default choice in cross-cultural research".

## Getting Started

### Cloning this repository

To clone this repository using Git, run:

```
git clone https://github.com/ScottClaessens/crossNationalCorrelationsReply
```

### Installing required packages

To run this code, you will need to [install R](https://www.r-project.org/) and the following R packages:

```
install.packages(c("brms","ggdist","ggtext","MASS","papaja",
                   "targets","tarchetypes","tidyverse"))
```

If you run into issues with the pipeline, try installing the specific R version or package versions outlined in `sessionInfo.txt`.

### Executing code

1. Set the working directory to this code repository
2. Load the `targets` package with `library(targets)`
3. To run all analyses, run `tar_make()`
4. To load individual targets into your environment, run `tar_load(targetName)`

## Help

Any issues, please email scott.claessens@gmail.com.

## Authors

Scott Claessens, scott.claessens@gmail.com
