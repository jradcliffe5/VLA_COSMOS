import glob, casatools, shutil, ast

try:
	i = sys.argv.index("-c") + 2
except:
	i = 1
	pass

typ=sys.argv[i]
delete=ast.literal_eval(sys.argv[i+1])

if typ == '20B':
    ms = glob.glob('20B-370.sb*_sc.ms')
    
    concat(vis=ms,concatvis='20B-370_target_sc.ms',timesort=True)
    
    if delete==True:
        for i in ms:
            shutil.rmtree(i)
    
