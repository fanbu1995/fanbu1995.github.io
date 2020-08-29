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
|**Distributions available** | only basics | a lot | the most |
|**Functionalities**| simulation only | simulation only | PDF and CDF evaluations and more |
|**Installment**| built-in | requires install (pip and conda) | requires install (pip and conda)|
|**Efficiency**| low | highest | high |


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

To sample random integers, we can use the `integers()` function. Let's say we want to sample a
3-by-5 array of integers between 2 and 8 (both endpoints included), then

```python
from numpy.random import default_rng
rng = default_rng()
rng.integers(low=2, high=8, size=(3,5), endpoint=True)

>>> array([[2, 3, 4, 4, 2],
       [5, 3, 7, 2, 2],
       [8, 7, 6, 5, 7]])
```

To sample from (or permutate) sequences, we can do the following
```python
seq = [1,2,3,4,5]

arr = [[1,2,3,4,5],
       [6,7,8,9,10]]

# sample without replacement
# note the probability "p" HAS TO sum to 1
rng.choice(seq, p=[0.1,0.2,0.1,0.3,0.3], replace=False)
>>> 4

# permute the sequence
rng.choice(seq, size=5, replace=False)
>>> array([2, 3, 1, 5, 4])

# sample from an array along an axis (say, sample a column)
rng.choice(arr, size=(1,), replace=False, axis=1)
>>> 
array([[3],
       [8]])
```

And finally, some examples of real-valued distributions
```python
# sample from Normal(3,5) with mean=3 & sd=5, and organize into a 2-by-5 array
rng.normal(loc=3,scale=5,size=(2,5))
>>> 
array([[ 13.52923449,   7.3267775 , -11.05061885,   1.9707617 ,  12.66680988],
       [ -4.0297244 ,  12.45834376,   1.23552118,   2.03453951,  2.76899204]])
          
# sample from a Dirichlet distribution with alpha=(1,2,3,4)
# 6 samples in total, vectors placed in rows
rng.dirichlet(alpha=(2,3,4,5), size=6)
>>>
array([[0.19900567, 0.14706951, 0.27954653, 0.37437829],
       [0.26614463, 0.05774624, 0.26426845, 0.41184068],
       [0.15285002, 0.34283186, 0.08426851, 0.42004961],
       [0.4375804 , 0.102708  , 0.36285606, 0.09685553],
       [0.06703317, 0.24337623, 0.34162268, 0.34796792],
       [0.02995042, 0.1747498 , 0.45785254, 0.33744724]])
```

### The `scipy.stats` module

Same as `numpy`, you need to install it via `pip` or get it for free with the Anaconda bundle.

The special thing about the `scipy.stats` module is that in addition to random variable sampling, it also provides a series of statistcal functionalities related to each distribution, such as PDF and CDF evaluation, main statistics calculation (e.g., mean, variance, skew, etc.), moments calculations, and so on.

Similar to `numpy`, it also includes a wide range of distributions - actually even more than what `numpy.random` offers. According to the [module tutorial](https://docs.scipy.org/doc/scipy/reference/tutorial/stats.html), there are 101 continuous distributions and 15 discrete ones.

Typically the way to use this module is by specifying an instance (or an object) of a distribution, and use its methods to sample or evaluate. Let's say we want to do a bunch of things with a normal distribution, for which the mean is 3 and standard deviation is 5. Then some example code is

```python
from scipy.stats import norm

# the PDF and CDF at 0
norm.pdf(0,loc=3,scale=5), norm.cdf(0,loc=3,scale=5)
>>> (0.06664492057835994, 0.2742531177500736)

# the mean and variance of this distribution
norm.mean(loc=3,scale=5), norm.var(loc=3,scale=5)
>>> (3.0, 25.0)

# sample 25 samples from it and arrange as a 5-by-5 array
norm.rvs(loc=3, scale=5, size=(5,5))
>>> array([[ 5.53997937,  6.06726398, -2.04353831, -1.61693137,  6.59197824],
       [-8.10515522, -2.15203014,  8.04193462,  2.79324216,  2.82317752],
       [ 3.6311475 ,  4.03357453, -0.44520476,  0.25870748,  5.2203014 ],
       [ 3.28086392,  3.07587057,  9.82874642, 10.60195969,  3.63723504],
       [ 5.11691806,  4.68744553,  1.40594161,  7.47255589, -0.63520945]])
```

A convenient trick when **repeatedly** using the same distribution is to **freeze** it so that you don't need to pass in arguments (like `loc` and `scale` for the normal distribution) again and again.

So the code for the task above can be rewritten as
```python
from scipy.stats import norm

# freeze it as "rv", a frozen distribution
rv = norm(loc=3, scale=5)

# PDF and CDF at 0
rv.pdf(0), rv.cdf(0)
>>> (0.06664492057835994, 0.2742531177500736)

# mean and variance of this distribution
rv.mean(), rv.var()
>>> (3.0, 25.0)

# sample 25 samples from it and arrange as a 5-by-5 array
rv.rvs(size=(5,5))
>>> array([[ 9.88755598,  8.17265306,  4.40680757,  7.38668928,  6.72128859],
       [-4.14181423,  5.29081735,  7.55169754,  8.23739169,  1.05982909],
       [ 0.88443857, -0.60595856,  4.88601216,  3.96272595,  2.46423227],
       [ 6.41230144,  0.80340375,  2.36638116, -5.54702185, 11.29779127],
       [10.53331556, -5.39831162,  9.03057659,  3.65320366, -0.95226979]])
```

Another feature of `scipy.stats` is that the functions allow broadcasting of the arguments. For example, if we want to generate random samples from different normal distributions with the mean ranging from 1,6,8 and standard deviation 1 and 10. Then we can write the code as
```python
norm.rvs(loc=[1,6,8], scale=[[1],[10]])

>>> 
array([[ 1.87233686,  5.9937878 ,  7.80705708],
       [-0.26218167, 21.73217187, 12.19536297]])
```
Here in the output, for instance, the first row contains samples with standard deviation 1, and the mean changes from 1 to 6 and to 8. Note that to make this work properly, the second argument has to be passed in as a column array. 

(For more details and handy tricks, please refer to the [module tutorial](https://docs.scipy.org/doc/scipy/reference/tutorial/stats.html).)

### Comparing their efficiency

Now let's benchmark random variable sampling using these three different modules. 

Use the simple normal distribution example. Suppose we want 10,000 samples from Normal(3,5), and we compare the running time of these following choices

- `gauss` from `random` (faster implementation of normal sampling);
- `normal` from `numpy.random.default_rng()` (the recommended choice); 
- `norm` from `scipy.stats` (using a frozen distribution for convenience).

Each draw will be executed 1000 times for benchmarking. The code and output is as follows:

```python
# setup commands for each choice
setup_random = "from random import gauss"
setup_numpy = "from numpy.random import default_rng; rng = default_rng()"
setup_scipy = "from scipy.stats import norm; rv = norm(loc=3,scale=5)"

# import timeit module for benchmarking
import timeit

# benchmark "random"
print(timeit.timeit("[gauss(mu=3,sigma=5) for i in range(10000)]", setup=setup_random, number=1000))
>>> 5.341856791999817
                  
# benchmark "numpy"                   
print(timeit.timeit("rng.normal(3,5,10000)", setup=setup_numpy, number=1000))
>>> 0.13603072300065833

# benchmark "scipy"
print(timeit.timeit("rv.rvs(size=10000)", setup=setup_scipy, number=1000))
>>> 0.3074812459999521
```
So, `numpy.random` is almost 40 times faster than `random` (mainly because we have to run a for loop just to draw multiple samples...), and about 2 times faster than `scipy.stats`. 

And thus, if you only want to sample a lot of random variables, `numpy.random` is probably the best option, at least from an efficiency point of view.

