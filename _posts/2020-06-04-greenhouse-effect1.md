---
layout: post
title: The Greenhouse Effect I 
---

# How It Doesn't Work

In my Room 101 there is the pop science explanation of the Greenhouse Effect. 

The traditional account goes something like this: $$ CO_2 $$ in the atmosphere lets energy from the 
Sun in, but doesn't let it back out. The more $$ CO_2 $$ there is in the atmosphere, the more energy gets trapped and so the
Earth warms up. Or if moving pictures are your thing:
<iframe width="650" height="600" src="https://www.youtube.com/embed/6cjx4gJFME0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

This explanation does not hold up to much scrutiny: in equilibrium the energy into and out of the Earth must balance, and saying that more $$ CO_2 $$ will 
'trap' more energy is like saying that wearing a blindfold will reduce visibility in a darkened room.

So how does it work? Let's start from the basics.

### A Rock In Space

We'll model the Earth as a spherical rock in space, and not worry about the atmosphere. It absorbs energy $$ E_i $$ from the sun,  and emits 
energy to space, $$ E_o $$. If $$ E_i > E_o $$ the Earth will warm up until $$ E_i = E_o $$ and if $$ E_i < E_o $$ it will cool until equilibrium 
is reached. So over long enough timescales the incoming radiation should balance the outgoing radiation. Unfortunately today we find ourselves in the first case.

The solar constant, $$ S_0 \approx 1360 $$ $$W/m^2$$, is a measure of the incoming energy per unit area. The Earth absorbs this energy over its cross sectional area, but it is somewhat shiny,
and so reflects a fraction $$ \alpha \approx 0.3 $$ (the albedo) back into space. We'll pretend that even without an atmosphere the energy is somehow evenly distributed across the Earth's surface, so that the total
energy out is proportional to its surface area --- which is larger than its cross section by a factor of 4. This means that the outgoing energy per unit area is

$$ E_o = \frac{1}{4}S_0 (1 - \alpha) $$

in equilibrium.

The Earth radiates as a black body, so its temperature is given by $$ E_o = \sigma T_e^4 $$. This means that the temperature of the Earth is

$$ T_e = \left(\frac{1}{4\sigma}S_0 \left(1 - \alpha\right)\right)^{0.25} \approx 255K $$ 

This is considerably colder than the actual average surface temperature, which is more like 288K. There are two points to make here. The first is obvious, we need some mechanism to explain
the extra 30 degrees of observed temperature. The second is more subtle. 255K is important --- we can't get around it. Whatever happens at the surface, the radiation that reaches space *has* to
have a temperature of 255K. I'll call this the *effective emission temperature*, $$T_e$$, of the Earth.

### A First Attempt

We can get the extra temperature by introducing an atmosphere. This atmosphere is transparent to incoming solar radiation but will absorb a fraction $$ \epsilon $$ of
the radiation emitted by the Earth. This will heat up the atmosphere, and so the atmosphere itself will start emitting. Crucially, the atmosphere radiates *both up and downwards*, so the surface
will reabsorb some radiation, and this warms it up.

To make things a bit more concrete, let the temperature of the surface be $$ T $$, and the temperature of the atmosphere be $$ T_a $$. Now, the total outgoing
radiation must have energy $$\sigma T_e^4$$. This has a contribution from the atmosphere $$\epsilon \sigma T_a^4$$ (this is just Kirchhoff's Law, if a body has an abosrbtivity $$\epsilon$$ the
emissivity must also be $$\epsilon$$). It also has a contribution from surface radiation not absorbed by the atmosphere, $$(1-\epsilon) \sigma T^4$$. Combining these and cancelling the $$\sigma$$s gives

$$ T_e^4 = (1-\epsilon) T^4 + \epsilon T_a^4 $$

The atmosphere absorbs an amount $$\epsilon\sigma T^4$$ and radiates an amount $$\epsilon \sigma T_a^4 $$ upwards and an amount $$\epsilon\sigma T_a^4$$ downwards. So

$$ 2\epsilon T_a^4 = \epsilon T^4 $$ 

Notice $$ T_a < T $$.

Solving these equations gives an expression for the surface temperature in terms of the the absorbtivity of the atmosphere.

$$ T = (1 - \frac{\epsilon}{2})^{-1/4} T_e $$

You can calculate $$ \epsilon $$ using numerical radiative transfer models. Try [modtran](http://climatemodels.uchicago.edu/modtran/). Change the $$ CO_2 $$ concentration, press show
raw model output. Our $$ \epsilon $$ is 1 - average transmittance. Taking $$ \epsilon = 0.8602 $$ for current levels of $$ CO_2 $$ gives a $$ T = 293.5 $$K. Not bad!

### That's All Folks?

Now lets try modtran with a doubling of $$ CO_2 $$. This gives $$ T = 293.7$$K. This climate sensitivity of 0.2K is somewhat less than the IPCC's likely range of 2 to 4.5K. 

Look at the values for $$\epsilon$$ -- they're pretty high, the atmosphere is quite opaque. So perhaps our low climate sensitivity is not too surprising then.
Because $$CO_2$$ is essentially opaque to infrared radiation, adding more won't make much difference. A wall twice as thick is not twice as hard to see through.

Although this model is clearly flawed, it does nicely illustrate the fundamental mechanism behind the Greenhouse Effect, namely *absorption and then re-radiation at a lower temperature* by the atmosphere.
In fact, it nicely describes greenhouse gases in the so called 'optically thin' regime, in which changing their concentrations affects their opacity. An example on Earth is methane. It also illustrates an
interesting scientific idea: just because a model can accurately describe a system, it doesn't mean it can accurately describe changes to that system.

As for gases in the optically thick regime, that will have to wait for next time.
