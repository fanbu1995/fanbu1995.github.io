---
layout: post
title: How to Sample from Distributions in Python
subtitle: (it's probably messier than you think)
tags: [Data science cheat sheets]

---

## Before we start...

One of the first headache moments that an R user like me faced when transitioning to Python is related to random number generation: how exactly do I sample 
from a probabilistic distribution??? 

I mean, in R, drawing random samples from whatever distributions you like is **very** straightforward. For many of the common distributions, you don't need to load 
packages at all, and the choice of functions for such task is simple too.

For example, if you want 100 i.i.d. samples from \\(N(\mu, \sigma^2)\\) where, say, \\(\mu=3\\) is the mean and \\(\sigma^2=9\\) is the variance, 
then you would just type

```r
rnorm(100, 3, 3)
```

As a more complicated example, let's say we want to draw 20 samples from a Multinomial distribution with \\(K=4\\) categories of equal probabilities and \\(N=6\\) trials. 
(That is, in each experiment, we pick 6 times out of 4 categories, where each category is equally likely to get picked, and we repeat this independently for 20 times.)
Then the R code for generating the samples is simply
```r
rmultinom(20, size = 6, prob = rep(1,4)) 
```
(Note that for the `prob` argument, R automatically scales it to sum to 1.)

In Python, however, you **do** need to load a library, either a built-in Python module, or something you have to install yourself.

In this post, I'll go over **3** different Python libraries that offer functionalities of random variable simulation. Below is a brief summary of these libraries:

| **Name** | `random` | `numpy.random` | `scipy.stats`|
|----------|---------- | -------------| -------------|
|**Distributions available** | only basics | a lot | a lot |
|**Functionalities**| simulation only | simulation only | PDF and CDF evaluations and more |
|**Efficiency**| high | higher | okay |
