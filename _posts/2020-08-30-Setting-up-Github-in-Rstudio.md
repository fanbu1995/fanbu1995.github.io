---
layout: post
title: Setting up Github in Rstudio
subtitle: (a cheatsheet of key commands)
tags: [Data science cheat sheets]
---

## Why this post?

After struggling with the whole process of version control and `git` for years (don't ask me how I got into a top PhD program with this kind of comprehension capability - 
I don't know either), I got quite addicted to the idea of version control. Since I work mostly in `R` (and `Python`, but that is a different issue), I usually
manage my R projects using `git`. But occasionally, I forget about the setup steps and have to Google around for a while before I figure everything out.

So finally I've had enough of those "oh I'm getting old" quarter-life crisis moments and decided to put together a document for the setup steps. 

Of course, there are other (probably better) ways to do this (you can always do everything in your terminal), but the follows are just what I have been doing and 
have got used to.

## The setup recipe

1. Create a repository on GitHub. No need to initialize with a README file, and you can always do that later on. 
(Needless to say, you need a GitHub account for this.)

2. Copy the URL of your repository. (Under "clone" tab; the address should end with ".git".)

3. Open RStudio, go to File --> New Project --> Version Control --> Git. Under "Repository URL", paste the URL you just copied, and specify where (locally) you want
your repo files to be under "Create project as subdirectory of:". Click "Create Project".

4. Configure Git. You can do this in the terminal using something like

```
git config --global user.name "YOUR USER NAME"
git config --global user.email "YOUR EMAIL"
```





