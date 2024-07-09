import math
import time

def estimate_pi(n):
    s = 1.0
    for i in range(1, n + 1):
        s += (-1 if i % 2 else 1) / (2 * i + 1)
    return 4 * s

tik = time.time()
p = estimate_pi(100_000_000)
tok = time.time() - tik
print(f"π ≈ {p}") # f-strings are available in Python 3.6+
print(f"Error is {p - math.pi:.4e}")
print(f"Time taken: {tok:.2f} seconds")