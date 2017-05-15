# Copyright(c) 1986 Association of Universities for Research in Astronomy Inc.

include	<math.h>

# GAMMLN -- Return natural log of gamma function.
# POIDEV -- Returns Poisson deviates for a given mean.
# GASDEV -- Return a normally distributed deviate of zero mean and unit var.


# GAMMLN -- Return natural log of gamma function.
# Argument must greater than 0.  Full accuracy is obtained for values
# greater than 1.  For 0<xx<1, the reflection formula can be used first.
#
# Based on Numerical Recipes by Press, Flannery, Teukolsky, and Vetterling.
# Used by permission of the authors.
# Copyright(c) 1986 Numerical Recipes Software.

real procedure gammln (xx)

real	xx		# Value to be evaluated

int	j
double	cof[6], stp, x, tmp, ser
data	cof, stp / 76.18009173D0, -86.50532033D0, 24.01409822D0,
		-1.231739516D0,.120858003D-2,-.536382D-5,2.50662827465D0/

begin
	x = xx - 1.0D0
	tmp = x + 5.5D0
	tmp = (x + 0.5D0) * log (tmp) - tmp
	ser = 1.0D0
	do j = 1, 6 {
	    x = x + 1.0D0
	    ser = ser + cof[j] / x
	}
	return (tmp + log (stp * ser))
end


# POIDEV -- Returns Poisson deviates for a given mean.
# The real value returned is an integer.
#
# Based on Numerical Recipes by Press, Flannery, Teukolsky, and Vetterling.
# Used by permission of the authors.
# Copyright(c) 1986 Numerical Recipes Software.
#
# Modified to return zero for input values less than or equal to zero.

real procedure poidev (xm, seed)

real	xm		# Poisson mean
long	seed		# Random number seed

real	oldm, g, em, t, y, ymin, ymax, sq, alxm, gammln(), urand(), gasdev()
data	oldm /-1./

begin
	if (xm <= 0)
	    em = 0
	else if (xm < 12) {
	    if (xm != oldm) {
		oldm = xm
		g = exp (-xm)
	    }
	    em = 0
	    for (t = urand (seed); t > g; t = t * urand (seed))
		em = em + 1
	} else if (xm < 100) {
	    if (xm != oldm) {
		oldm = xm
		sq = sqrt (2. * xm)
		ymin = -xm / sq
		ymax = (1000 - xm) / sq
		alxm = log (xm)
		g = xm * alxm - gammln (xm+1.)
	    }
	    repeat {
		repeat {
	            y = tan (PI * urand(seed))
		} until (y >= ymin)
	        em = int (sq * min (y, ymax) + xm)
	        t = 0.9 * (1 + y**2) * exp (em * alxm - gammln (em+1) - g)
	    } until (urand(seed) <= t)
	} else
	    em = xm + sqrt (xm) * gasdev (seed)
	return (em)
end


# GASDEV -- Return a normally distributed deviate with zero mean and unit
# variance.  The method computes two deviates simultaneously.
#
# Copyright(c) 2017 Anastasia Galkin
# Reference: G. E. P. Box and Mervin E. Muller, A Note on the Generation of
#            Random Normal Deviates, The Annals of Mathematical Statistics
#            (1958), Vol. 29, No. 2 pp. 610–611

real procedure gasdev (seed)

long	seed

int	count
data	count/0/

real	u1, u2, x
real	urand()

begin
	if (count == 0) {
		repeat {
			u1 = 2 * urand (seed) - 1.
		} until (u1 > 0)
		repeat {
			u2 = 2 * urand (seed) - 1.
		} until (u1 > 0)
		x = sqrt(-2 * log(u1)) * cos(2*PI*u2);
		count = 1
	} else {
		x = sqrt(-2 * log(u1)) * sin(2*PI*u2);
		count = 0
	}
	return (x)
end
