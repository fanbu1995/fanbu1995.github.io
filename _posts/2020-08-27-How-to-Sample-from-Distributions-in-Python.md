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
|**Installment**| built-in | requires install (pip and conda) | requires install (pip and conda)|
|**Efficiency**| high | higher | okay |


## Now into the meat and bone

### The `random` library

There are three basic types of "simulations" that the `random` module offers: integers, sequences, and real-valued distributions.

For integers, for example, using `random.randrange(start, stop[, step])` can randomly generate an integer between `start` and `stop` with a stepsize `step` (optional). 

For sequences, it can randomly select elements from any sequence (not necessarily numbers) uniformly or with a specified distribution (or weights), and it can also randomly shuffle (permute) a sequence.

Some examples:
```python
from random import choice, choices, shuffle, sample

fruits = ['apple','banana', 'pear', 'peach', 'grape', 'mango']

# choose one element at random
choice(fruits)
>>> 'mango'

# choose k elements WITH REPLACEMENT with weights
choices(fruits, weights = [1,3,4,5,6,7], k = 4)
>>> ['peach', 'grape', 'peach', 'pear']

# choose k elements WITHOUT REPLACEMENT uniformly
sample(fruits,k=3)
>>> ['grape', 'peach', 'banana']

# shuffle the list (in place, only accepts mutable objects)
shuffle(fruits)
fruits
>>> ['banana', 'peach', 'grape', 'mango', 'pear', 'apple']
```

For real-valued distributions, it supports sampling from certain commonly used distributions: Uniform, Gamma, Beta, Exponential, Normal, Pareto, etc.

Some examples:
```python
from random import *

# Uniform(0,1)
random()
>>> 0.23317458326492257

# Uniform(1.5,2.6)
uniform(1.5,2.6)
>>> 2.0483236868182306

# Beta(3,5)
betavariate(3,5)
>>> 0.24637194926989447

# Gamma(5,5)
# 1st arg = shape, 2nd arg = scale (not rate!)
>>> 15.558501989226073

# Normal(0,5)
# 1st arg = mean, 2nd arg = standard deviation
# note: this is faster than "normalvariate(mu, sigma)"
gauss(0,5)
>>> -5.324221535282665
```

(References: [the random library documentation](https://docs.python.org/3/library/random.html).)

### The `numpy.random` module

Compared to the built-in `random` library, `numpy.random` is more powerful in two ways:

- It enables array output (for generating random numbers) and input (for sequence selection/permutation); note that functions in `random` mostly just output a single number.
- It supports a much larger set of distributions, including (but not limited to) Binomial, \\(\chi^2\\), Dirichlet, F, Geometric, Negative-Binomial, Poisson, etc., which a statistician (like me) is quite happy about.

That being said, you do need to install it via
```
pip install numpy
```
unless you already have the [Anaconda](https://www.anaconda.com/products/individual) bundle (`numpy` comes with it).

Starting from version 1.17.0, `numpy` has implemented a faster generator with better statistical properties; usage of the functions is the same as those under 
the `numpy.random` module from before, and previous functions are still available. 

The following example is borrowed from their [documentation page](https://numpy.org/doc/stable/reference/random/index.html):

```python
# Do this
from numpy.random import default_rng
rng = default_rng()
vals = rng.standard_normal(10)
more_vals = rng.standard_normal(10)

# instead of this
from numpy import random
vals = random.standard_normal(10)
more_vals = random.standard_normal(10)
```

All the change is that now you should instantiate an instance of the ``default_rng`` class, and then from there everything is just like before.

Below let's go through a few more examples. 



