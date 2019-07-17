#!/usr/bin/env Rscript

# get folder name from input argument
folder.name <- commandArgs(trailingOnly=TRUE)[1]

# set directory of jekyll blog
base <- "/home/hanbin973/hanbin973.github.io/"
# set the directory to where your Rmd's reside
rmds <- "_Rmd"
setwd(base)

# set name of file
date <- toString(Sys.Date())
filename <- "main.Rmd"

# path for folders
figs.path <- "img/"
posts.path <- "_posts/"

# start
require(knitr)
render_jekyll(highlight="pygments")
opts_knit$set(base.url="/")

file <- paste0(rmds, "/", folder.name, "/", filename)

# set filepath
fig.path <- paste0(figs.path, folder.name, "/")
opts_chunk$set(fig.path=fig.path)

# suppress messages
opts_chunk$set(cache=F, warning=F, message=F, cache.path="_cache/", tidy=F)

# output name
out.name <- paste0(date, "-", folder.name, ".md")

# create md
out.file <- basename(knit(file))

# save it at _posts/
file.rename(out.file, paste0(posts.path, out.name))
