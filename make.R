#!/usr/bin/env Rscript

require(rmarkdown)
require(ff)

# get folder name from input argument
folder.name <- commandArgs(trailingOnly=TRUE)[1]

# set directory of jekyll blog
base <- "/home/hanbin973/hanbin973.github.io/"
# set the directory to where your Rmd's reside
rmds <- "_Rmd"
setwd(base)

# copy file from _Rmd to root
Rmd.name <- "main.Rmd" # change if required

Rmd.path <- paste0(rmds, "/", folder.name, "/", Rmd.name)
bib.path <- paste0(rmds, "/", folder.name, "/", folder.name, ".bib")

file.copy(Rmd.path, Rmd.name)
file.copy(bib.path, paste0(folder.name, ".bib"))

# compile Rmd
Rmd.compile <- rmarkdown::render(Rmd.name)
out.file <- basename(Rmd.compile)

# save outcome md to specified path
date <- toString(Sys.Date())
out.name <- paste0(date, "-", folder.name, ".md")
md.path <- paste0("_posts/", out.name)
file.rename(out.file, md.path)

# TODO: add meta data to outcome

# remove copied files
file.remove(Rmd.name)
file.remove(paste0(folder.name, ".bib"))
