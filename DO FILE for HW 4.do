**Homework 4 Part 1**

import excel "/Users/kylietaylor/Downloads/fredgraph.xls", sheet("FRED Graph") cellrange(A1:E111) firstrow
gen t = _n
tsset t
gen lnffr = log(ffr)
gen lnCPI = log(CPI)
gen dFFR = d.lnffr
gen dCPI = d.lnCPI
gen dGDP = d.ln_Y
drop lnffr lnCPI

tsline ffr ln_Y CPI

tsline dFFR dGDP dCPI

var dFFR dGDP dCPI

irf create myGraph24, set(myGraph24)
irf graph irf

matrix A = (1,0,0\.,1,0\.,.,1)
matrix B = (.,0,0\0,.,0\0,0,.)

svar dFFR dGDP dCPI, aeq(A) beq(B)

irf set "impulses99.irf"
irf create myIRF99, step(10)
irf graph irf

matrix sig_var = e(Sigma)
matrix chol_var = cholesky(sig_var)
matrix list chol_var

matrix A = (1,0,0\.,1,0\.,.,1)
matrix B = (.,0,0\0,.,0\0,0,.)

svar  dGDP dCPI dFFR, aeq(A) beq(B)

irf set "impulses909.irf"
irf create myIRF909, step(10)
irf graph irf

matrix sig_var = e(Sigma)
matrix chol_var = cholesky(sig_var)
matrix list chol_var

