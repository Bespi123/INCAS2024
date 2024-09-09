simulationParameters   
salidas=sim('simulationComplete.slx','SrcWorkspace','current');
yout = salidas.get('yout');
t    = salidas.get('tout');
save
