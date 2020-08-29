---
layout: post
title: Setting up Github in RStudio
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
 or you can use the `usethis` package in R
```r
library(usethis)
use_git_config(user.name = "YOUR USER NAME", user.email="YOUR EMAIL")
```

5. Cache your credentials (so that you can reduce the number of times to type in username and password)
   Now, even after configuration, you still need to type in your username and password **every time** you push or pull. So a convenient work-around is to cache your credentials via
```
git config credential.helper 'cache --timeout [NUMBER OF SECONDS TO CACHE]'
```
For example, if you want to store your usename and password for over a month, then you want to type the following command in your terminal
```
git config credential.helper 'cache --timeout 3000000'
```
Of course, if you are working on your own machine, then the most convenient way is to set up an SSH key. Instructions are provided by [GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh).


## A few more commands

Occasionally, we may just want to bypass all the button-pressing on the RStudio console and simply do it in the terminal. 

Here are some basic useful commands:

1. Initialize a local directory as a git repo:
```
git init
```

2. Add (stage) all files, check their status, and commit
```
git add -A
git status
git commit -m "[COMMIT MESSAGE]"
git branch -M master
```

3. Link it to a remote repository (which already exists on GitHub) and push changes
```
git remote add origin [REPO URL]
git push -u origin master
```

4. Verify/show remote repo information 
```
git remote -v
git remote show origin
```

5. Create (or switch) to a new branch and push to remote repository
```
git checkout -b [BRANCH NAME]  //this is for creating a new one
git checkout [BRANCH NAME]     //this is for switching to a new one
```
```
git push -u origin [BRANCH NAME]
```

6. Pull from a remote repo/branch. First make sure you are in the correct local branch, then run
```
git pull origin
```
Note that "pull" is equivalent to `git fetch` + `git merge`. 


