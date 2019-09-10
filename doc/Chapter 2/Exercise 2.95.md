## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### [Exercise 2.95](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_thm_2.95)

Define _P_<sub>1</sub>, _P_<sub>2</sub>, and _P_<sub>3</sub> to be the polynomials

<p align="center">
  <img src="https://i.ibb.co/ScFTn5s/SICPexercise2-95.png" alt="SICPexercise2.95" title="SICPexercise2.95">
</p>

Now define _Q_<sub>1</sub> to be the product of _P_<sub>1</sub> and _P_<sub>2</sub> and _Q_<sub>2</sub> to be the product of _P_<sub>1</sub> and _P_<sub>3</sub>, and use greatest-common-divisor ([exercise 2.94][1]) to compute the GCD of _Q_<sub>1</sub> and _Q_<sub>2</sub>. Note that the answer is not the same as _P_<sub>1</sub>. This example introduces noninteger operations into the computation, causing difficulties with the GCD algorithm. To understand what is happening, try tracing `gcd-terms` while computing the GCD or try performing the division by hand.

We can solve the problem exhibited in [exercise 2.95][2] if we use the following modification of the GCD algorithm (which really works only in the case of polynomials with integer coefficients). Before performing any polynomial division in the GCD computation, we multiply the dividend by an integer constant factor, chosen to guarantee that no fractions will arise during the division process. Our answer will thus differ from the actual GCD by an integer constant factor, but this does not matter in the case of reducing rational functions to lowest terms; the GCD will be used to divide both the numerator and denominator, so the integer constant factor will cancel out.

More precisely, if _P_ and _Q_ are polynomials, let _O_<sub>1</sub> be the order of _P_ (i.e., the order of the largest term of _P_) and let _O_<sub>2</sub> be the order of _Q_. Let _c_ be the leading coefficient of _Q_. Then it can be shown that, if we multiply _P_ by the _integerizing factor_ _c_<sup>1+<i>O</i>₁-<i>O</i>₂</sup>, the resulting polynomial can be divided by _Q_ by using the `div-terms` algorithm without introducing any fractions. The operation of multiplying the dividend by this constant and then dividing is sometimes called the _pseudodivision_ of _P_ by _Q_. The remainder of the division is called the _pseudoremainder_.

### Solution

:(

[1]: ./Exercise%202.94.md
[2]: ./Exercise%202.95.md

