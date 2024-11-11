+++
title = "Non-linear ICA"
date = "2024-12-31"
description = "An introduction to non-linear ICA."
draft = true
+++

Tldr; Non-linear ICA replaces the mixing matrix with a non-linear mixing function.

--- 
$\newcommand{\z}{\mathbf{z}}$
$\newcommand{\x}{\mathbf{x}}$
$\newcommand{\u}{\mathbf{u}}$
$\newcommand{\btheta}{\mathbf{\theta}}$
$\newcommand{\bphi}{\mathbf{\phi}}$
$\newcommand{\f}{\mathbf{f}}$
$\newcommand{\T}{\mathbf{T}}$
$\newcommand{\blambda}{\mathbf{\lambda}}$
$\newcommand{\bepsilon}{\mathbf{\varepsilon}}$

dimensions;: $\x\in\mathbb{R}^d$ and $\z\in\mathbb{R}^n$
deep latent variable model: $p_\btheta(\x,\z)=p_\btheta(\x|\z)p_\btheta(\z)$

decoder: $p_\theta(\x|\z)$

observed distribution: $p_\btheta(\x) = \int p_\btheta(\x,\z)d\z$

$\Rightarrow$ if $p_\btheta(\x|\z)$ is modelled with a neural network, we obtain a flexible class of distributions for $p_\btheta(\x)$

Variational autoencoders (VAEs) perform inference of the full generative model $p_\btheta(\x,\z)$ and the inference model $q_\bphi(\z|\x)$, which approximates $p_\btheta(\z|\x)$. However, it is difficult to obtain inference models that have meaning. The marginal distribution of $\x$ has meaning, but the distributions on the latent variables $\z$ are generally meaningless. 

# Identifiability
Plan:
- Define identifiability
- identifiability in linear ICA
- intro to identifiability of non-linear ICA

In general, identifiability in linear ICA is impossible without the assumptions in [my previous post](http://localhost:1313/infomax-and-linear-ica/). 

# Deep Latent Variable Models with Conditional Latent Priors

Plan:
- Identifiability in non-linear ICA 
- Key assumptions + significance / meaning
- Theory 
- Results
- Conclusions



Khemakhem et al. introduced the class of identifiable VAE models using a conditional prior on the latents $p_\btheta(\z|\u)$, where $\u \in \mathbb{R}^m$ is an observed random variable. By doing this, they essentially make the non-linear ICA problem into a semi-supervised signal disentanglement. In addition to this conditioning, they assume that the latent variables are distributed according to some exponential family of the form, $$p_{\T,\blambda} \prod_i \frac{Q_i(z_i)}{Z_i(\u)} \exp{\left\[\sum_{j=1}^k T_{i,j}(z_i)\lambda_{i,j}(\u)\right\]},$$ where $Q_i$ is the base measure, $Z_i(\u)$ is the normalising constant, \T_i=(T_{i,1}, \ldots, T_{i, k})$$ are the sufficient statistics, and $\blambda_i(\u)=(\lambda_{1,i}, \ldots, \lambda_{i,k})$. The parameters of the identifiable VAE are thus given by $\btheta=(\f, \T, \blambda)$.

The joint distribution of the $\x$ and $\z$ can be written as $$p_\btheta(\x,\z)p_{\T, \blambda}(\z|\u),$$ with, $$p_\f(\x|\z)=p_\bepsilon(\x - \f(\z)).$$ By taking, $\x - \f(\z) = \bepsilon \Rightarrow \x = \f(\z) + \bepsilon$, we obtain the non-linear ICA formulation, where $\f$ is a non-linear mixing function on $\z$ and $\bepsilon$ is an independent noise term. Additionally, assuming that $\f$ is injective, we guarantee that for each $\x$ there is a unique $\z$.

**Assumption.** The function $\f: \mathbb{R}^d \rightarrow \mathbb{R}^m$ is injective.

The priors on the latent variables $p_\btheta(\z|\u)$ are assumed to be conditionally factorial with respect to $\u$. Thus, each individual latent $z_{i}$ is assigned a prior conditional on $\u$ through an arbitrary function $\blambda(\u)$, which outputs the parameters $\blambda_{i,j}$ exponential family parameters. This probability density is given by, $$p_{\T, \blambda}(\z|\u)=\prod_i \frac{Q_i(z_i)}{Z_i(\u)} \exp{\left\[\sum_{j=1}^k T_{i,j}(z_i)\lambda_{i,j}(\u)\right\]},$$ where $Q_i$ is the base measure, $Z_i(\u)$ is the normalising constant, \T_i=(T_{i,1}, \ldots, T_{i, k})$$ are the sufficient statistics, and $\blambda_i(\u)=(\lambda_{1,i}, \ldots, \lambda_{i,k})$.

## Identifiability of DLVMs with Conditional Priors