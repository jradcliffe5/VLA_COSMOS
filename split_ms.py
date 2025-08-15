import os, ast
import numpy as np
import casatools

## Import arguments
try:
	i = sys.argv.index("-c") + 2
except:
	i = 1
	pass

ms = sys.argv[i]
avg = ast.literal_eval(sys.argv[i+1])

os.system('rm -r %s_sc.ms'%ms)
if avg == False:
    split(vis='%s_calibration/%s.ms'%(ms,ms),
          outputvis='%s_sc.ms'%ms,
          keepmms=False,
          field='COSMOS')
    statwt(vis='%s_sc.ms'%ms,datacolumn='DATA',minsamp=2)
    tb = casatools.table()
    tb.open('%s_sc.ms'%ms) 
    weight=tb.getcol('WEIGHT')
    tb.close()
    flagdata(vis='%s_sc.ms'%ms,
         mode='clip',
         datacolumn='WEIGHT',
         clipminmax=[0,np.median(weight)+6*np.std(weight)])
    del weight
else:
    split(vis='%s_calibration/%s.ms'%(ms,ms),
          outputvis='%s_sc.ms'%ms,
          keepmms=False,
          field='COSMOS',
          timebin='6s',
          width=4)