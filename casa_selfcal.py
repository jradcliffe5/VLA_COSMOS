import sys, os
import numpy as np

def remove_flagged_scans(caltable):
	# Backup original table
	tb = casatools.table()
	tb.open(caltable,nomodify=False)
	flags = tb.getcol('FLAG')
	index = []
	for i in range(tb.nrows()):
		if np.all((flags[:,:,i]==True)==True):
			index.append(i)
	tb.removerows(index)
	tb.close()

try:
	i = sys.argv.index("-c") + 2
except:
	i = 1
	pass

msfile = sys.argv[i]
caltable = sys.argv[i+1]
calmode = sys.argv[i+2]
solint = sys.argv[i+3]
try:
    combine = sys.argv[i+4]
except:
    combine=""

try:
    gaintables = sys.argv[i+5:]
except:
    gaintables = []

gaincal(vis=msfile, 
        caltable=caltable, 
        gaintype='G', 
        gaintable=gaintables,
        interp=len(gaintables)*['linearperobs'],
        calmode=calmode, 
        solint=solint, 
        combine=combine, 
refant='ea28,ea02,ea10,ea25,ea23,ea09,ea18,ea16,ea13,ea12,ea19,ea04,ea01,ea27,ea20,ea08,ea17,ea07,ea24,ea11,ea14,ea03,ea06,ea21,ea26,ea15,ea05', 
        minsnr=1,
        solnorm=True,
        minblperant=3)
remove_flagged_scans(caltable)

gaintables = gaintables + [caltable]
applycal(vis=msfile, gaintable=gaintables, interp=len(gaintables)*['linearperobs'])