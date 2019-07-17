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
require(rmarkdown)
require(ff)
render_jekyll(highlight="pygments")
opts_knit$set(base.url="/")

file <- paste0(rmds, "/", folder.name, "/", filename)

# set filepath
fig.path <- paste0(figs.path, folder.name, "/")
print(fig.path)

# create md
obj <- rmarkdown::render(file)
out.file <- basename(obj)

# output name
out.name <- paste0(date, "-", folder.name, ".md")

# add meta data to file

# save it at _posts/
file.rename(paste0(rmds, "/", folder.name, "/", out.file), paste0(posts.path, out.name))

# move image folder
from <- paste0(rmds, "/", folder.name, "/", "assets/img", "/", folder.name)
to <- paste0("~/hanbin973.github.io/assets/img/", folder.name)

#print(from)
#print(to)

file.move(from, to)

