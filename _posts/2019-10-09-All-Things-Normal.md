---
layout: post
title: All Things "Normal"
subtitle: A cheatsheet for inference of normal distributions 
tags: [Bayesian statistics]

---

Entry-level Bayesian analysis is all about the "kernel trick" - "eyeballing" a distribution from the central part of the 
density function. 

So here is a little cheatsheet for all the distributions (and tricks) one may need for doing inference related to 
Normal distributions. 

### 1. How to recognize a normal distribution
Suppose your random variable of interest is vector \\(y \in \mathbb{R}^n\\), and the probability density function for \\(y\\) is 
proportional to
\\[
\exp\left(-\frac{1}{2} [y^TAy - 2b^T y]\right),
\\]
where \\(A\\) is an \\(n \times n\\) positive semi-definite matrix, and \\(b \in \mathbb{R}^n\\).

Then you can immediately say that \\(y \sim N(A^{-1}b, A^{-1})\\).

### 2. Commonly used priors for variance or covariance matrix

I've found that using "precision", rather than variance or covariance matrix, can make your life much easier.

For the univariate case, let precision \\(\gamma = (\sigma^2)^{-1}\\) be the inverse of the variance. We often adopt
a Gamma prior for \\(\gamma\\), which is equivalent to using an inverse-Gamma prior for \\(\sigma^2\\). 

The density of a \\(\text{Gamma}(a,b)\\) distribution is proportional to
\\[
x^{a-1}e^{-bx}.
\\]

In some textbooks (e.g. [the one by Peter Hoff](https://link.springer.com/book/10.1007/978-0-387-92407-6)),
a \\(\text{Gamma}(\frac{n_0}{2},\frac{n_0\sigma_0^2}{2})\\) prior is used for the precision paramter. Here \\(n_0\\) represents the "prior sample size".


For the multivariate case (let the dimensionality be \\(n\\)), let the precision matrix \\(\Gamma = (\Sigma)^{-1}\\) be the inverse of the covariance matrix. We often
adopt a Wishart prior, which is equivalent to using an inverse-Wishart prior for \\(\Sigma\\). 

The density of a \\(\text{Wishart}(V,m)\\) distribution is proportional to
\\[
\lvert X \rvert^{(m-n-1)/2} \exp\left(-\text{tr}(V^{-1}X)/2\right).
\\]
Here the \\(n \times n\\) positive definite matrix \\(V\\) is the *scale matrix*, and \\(m\\) is the *degree of freedom*, with 
\\(\mathbb{E}(X) = mV\\). 

We may use something like a \\(\text{Wishart}(\frac{S_0}{n_0},n_0)\\) prior for the precision matrix, where \\(n_0 \geq n+1\\).
