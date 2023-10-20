# Distro Hopping
Repositório para script de instalação de programas Linux.

## Used on
- ZorinOS -> PopOS

## Obs
Para o correto funcionamento do script (com PopOS), deve-se rodar o seguinte código no terminal:
```szh
sudo systemctl stop packagekit
```
Após o término das instalações, rode:
```szh
sudo systemctl start packagekit
```
