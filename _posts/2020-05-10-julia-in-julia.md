---
layout: post
title: Julia In Julia
---

I've been interested in the [Julia](https://julialang.org) language for a while now. It's got a powerful type system,
LISPy metaprogramming and (if you believe the claims) almost C level performance in a scripting language.

I thought it might be quite fun to construct *Julia Sets* using the Julia programming language.

Let $$f$$ be a function from the complex plane to itself. The (filled) Julia set is defined as
$$K(f) = \{z \in \mathbb{C} : f^k(z) \nrightarrow \infty\; \mathrm{as}\, k \rightarrow \infty\}$$.

This is just the set of points that don't blow up under iteration with $$f(z)$$.

Here's a few examples, white denotes points in the set and the shades of blue give how quickly the other points blow up.

### $$f(z) = z^2 + 0.285 + 0.01i$$
![A Filled Julia Set](/assets/julia_in_julia/first.png "A Filled Julia Set")
### $$f(z) = z^2 + 0.8 + 0.15i$$
![A Filled Julia Set](/assets/julia_in_julia/second.png "A Filled Julia Set")
### $$f(z) = z^2 - 0.5i$$
![A Filled Julia Set](/assets/julia_in_julia/third.png "A Filled Julia Set")


The code to produce these is pretty straightforward too. This is the first program I've written in Julia, so apologies for anything non-idiomatic.

We begin by defining some constants:
```julia
const max_real = 2.0
const max_imag = max_real
const number = 5000
const max_radius = 50.0
const iters = 100
```

Then we define a higher order function, which will iterate another function until it exceeds some maximum radius, in which case it returns the number
of iterations,  or until it exceeds the maximum number of iterations, in which case it returns 0.
``` julia
function iterate_until_escape(z,f)
    z0 = z
    for i = 1:iters
        z0 = f(z0)
        if abs(z0) > max_radius
            return i
        end
    end
    return 0
end
```
We convert this to an RGB value:
```julia
function to_rgb(i)
    if i == 0
        return "255 255 255 "
    else
        b = round(Int,255*(i/iters))
        return "0 $b $b "
    end
end
```

Now I use Julia's metaprogramming facilities to let the program user input their own function:
```julia
println("Input the function to iterate:")
user_function = readline(stdin)
@generated f(z) = Meta.parse(user_function)
```
I use Julia's simple function definition syntax to compose all these functions together.
```julia
jul(z) = to_rgb(iterate_until_escape(z,f))
```

Now it's just a matter of running this. I output the results in Netpbm format.
```julia
function main()
    open("set.ppm","w") do file
        write(file,"P3\n$number $number\n255\n")
        for y in range(max_imag,stop=-max_imag,length=number)
            for x in range(-max_imag,stop=max_imag,length=number)
                write(file,jul(x+1im*y))
            end
        end
    end
end
main()
```

I enjoyed my little dive into Julia. It was simple to use and pretty well documented.
One of the nice things was not being afraid of for loops, a fear which numpy is good at instilling in you.

This is a pretty naive implementation, and there are some pretty obvious ways you could improve it. But it seems to do the job quite nicely.
