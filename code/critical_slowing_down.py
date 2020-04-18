import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate
import scipy.signal

from statsmodels.tsa.stattools import acf

np.random.seed(1996)

final_time = 10000
window_size = 1000
times = np.arange(final_time)
frac = np.zeros(final_time)

ar = np.zeros(frac.size - window_size)

alpha0 = 0.9
gamma = 0.1
frac[0] = 1 - gamma / alpha0
tipping_time = 10000
alpha_det = alpha0 - times * (alpha0 - gamma) / tipping_time
equilibrium = 1 - gamma / alpha_det
equilibrium[tipping_time:] = 0.0
alpha = alpha_det + np.random.normal(scale=0.1, size=alpha_det.size)

for t in times[1:]:
    df = alpha[t - 1] * frac[t - 1] * (1 - frac[t - 1]) - gamma * frac[t - 1]
    frac[t] = frac[t - 1] + df

ar = np.fromiter(
    (acf(scipy.signal.detrend(frac[m:m + window_size]), fft=True)[1]
     for m in range(ar.size)),
    dtype=np.float,
    count=ar.size)

plt.subplot(211)
plt.plot(times, frac, color="red", label="Dynamical Solution")
plt.plot(times,
         equilibrium,
         color="black",
         linestyle="--",
         label="Equilibrium")
plt.axvline(tipping_time, color="green", linestyle=":", label="Tipping Point")
plt.xlabel("$t$")
plt.ylabel(r"$\nu$")
plt.xlim(0, final_time + 500)
plt.ylim(0, 1.0)
plt.legend()

plt.subplot(212)
plt.plot(times[window_size:], ar, color="red", label="AR(1)")
plt.axvline(tipping_time, color="green", linestyle=":", label="Tipping Point")
plt.xlabel("$t$")
plt.ylabel("$AR(1)$")
plt.ylim(0, 1.0)
plt.xlim(0, final_time + 500)
plt.tight_layout()
plt.savefig("rising_autocorr.png", bbox_inches="tight")
