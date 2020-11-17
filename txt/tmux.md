# Tmux

## Attach to currente tmux process
tmux attach -t 0

## Create tmux process
0 - server 
```bash
cd ~/code/zunkasite/bin
```

1 - top
```bash
top
htop
```

2 - memory
```bash
sudo journalctl --disk-usage
sudo journalctl --vacuum-size=100M
free -h
```

3 - price
```bash
cd ~/code/zunkasite/bin/db/products
./check-products-price.js
```

4 - database
```bash
mongo -u admin --authenticationDatabase admin -p
```

5 - log
```bash
cd ~/.local/share/zunka/log/zunkasite
```




