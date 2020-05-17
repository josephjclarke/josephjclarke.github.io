---
layout: post
title: Julia in Julia II
---
Just a quick addendum to my [previous](https://josephjclarke.github.io/2020/05/10/julia-in-julia.html) post. Seeing as how Julia prides itself (herself?) on speed, 
I thought I'd compare the performance
of various languages at producing Julia sets. The code used is [here](https://github.com/josephjclarke/julia_set_benchmark). 

These are all *naive* implementations. This was a deliberate choice on my part to give as fair a comparison as possible, as in my experience
the naive implementation tends to be the default one. 

The implementations are Julia, C (compiled with no optimisations, normal (-O2) optimisations and extreme (-Ofast) optimisations), Fortran (compiled in the same way as C)
and then three python implementations: plain old python, python with numpy and python with numba.

Here's the speed:
![Speed Comparison](/assets/julia_in_julia/bench_time.png "Speed Comparison")
and here's the memory usage:
![Memory Comparison](/assets/julia_in_julia/bench_mem.png "Memory Comparison")

A stand out feature is that Julia is competitive with C and Fortran. Of course the downside to Julia is its poor memory footprint. 
I'm surprised at how poorly Fortran did. I suspect this is due to inefficiencies in the IO system
as the Fortran implementations were spending about half their time making system calls. Plain old python did as poorly as expected, but surprisingly the numpy version was 
pretty awful. This is probably due to the nature of the problem, numpy is not well suited to these types of "loop until done" algorithms.

Perhaps the major success though is numba. By just adding a few ```@njit``` decorators to the python code I get an order of magnitude speed up!

How do your favourite languages compare?
