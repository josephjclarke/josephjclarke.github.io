---
layout: post
title: Critical Slowing Down
---

One of the ways we conceptualise tipping points in the Earth System is through [bifurcation theory](https://en.wikipedia.org/wiki/Bifurcation_theory).
However, not only do we not know the positions in parameter space of these bifurcations, we also do not in general know the equations which govern the
dynamics of the various subsystems of interest. Therefore we should look for generic features that dynamical systems exhibit near a bifurcation point.

Suppose we have a system with state vector $$x$$ that depends on a parameter $$\mu$$ that undergoes a bifurcation at $$\mu = \mu_c$$:

$$ \frac{\mathrm{d}x}{\mathrm{d}t} = f(x,\mu) \quad x \in \mathbb{R}^n, \mu \in \mathbb{R}^m $$

If there is a fixed point at $$x = x_{0}$$ we can linearise about this point, setting $$x = x_0 + \xi$$ to get

$$ \frac{\mathrm{d}\xi}{\mathrm{d}t} \approx Df(x_0,\mu)\xi $$

where $$Df$$ is the Jacobian matrix. This equation is easy enough to solve (an exercise for the reader), and it reveals that 
fluctuations about equilibrium decay back to equilibrium on a timescale given by the inverse of the eigenvalues of the Jacobian. Assuming the 
fixed point is stable for $$\mu < \mu_c$$, the real part of these eigenvalues will initially be large and negative and will
become zero at the bifurcation. Hence, the fluctuation timescale starts small and heads to infinity at the bifurcation. This is a very general
phenomenon and is known as *Critical Slowing Down*.

This suggests we can anticipate tipping points by looking at statistics that measure a systems 'memory', such as its autocorrelation.

Let's take some measurements of a system we think is going to tip, and subtract the average so we're left with the fluctuations around equilibrium.
Call these data $$y_i$$. If we seek inspiration from linearised dynamical system, we might try to fit an autoregressive process:

$$y_{n+1} = ay_{n} + \epsilon_{n+1}, \quad a \in \mathbb{R}$$

where $$\epsilon_i$$ are Gaussian i.i.d random variables.
From the linearised equation, we can identify $$a$$, the AR(1) coefficient (or autocorrelation) with $$e^{\lambda}$$, where $$\lambda$$ is our eigenvalue. Hence as we approach the
tipping point, the AR(1) coefficient should rise to 1.

As an example I take the equation
$$
\dot{\nu} = \alpha\nu(1-\nu) - \gamma \nu
$$
which has a transcritical bifurcation at $$\alpha = \gamma$$. View this as a simple model for the fraction of area covered by vegetation if you like. I reduce $$\alpha$$ noisily down to $$\gamma$$ and calculate
the AR(1) coefficient, in sliding windows of length 1000.
![Critical Slowing Down](/assets/critical_slowing_down/rising_autocorr.png "Critical Slowing Down")
In this case, rising autocorrelation serves as an early warning signal for a tipping point.

You can find the code used to produce these plots [here](https://github.com/josephjclarke/josephjclarke.github.io/blob/master/code/critical_slowing_down.py).

