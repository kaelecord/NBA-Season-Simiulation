# NBA-Season-Simiulation
## Simulation of the 2020-2021 NBA Season

The goal of my project was to write a program that would simulate a whole season of NBA games. The two datasets required to run this program are the following: a schedule dataset containing all games played during the regular season and a dataset containing player data (necessary variables: name, team, and PPG).

In order to predict the outcome of an induvial game I needed a way to predict the points scored by each player on a team. To do this I used trial and error to find distribution that matched the scoring output for a few different players from various spots on the scoring list. I wanted to find a distribution that would describe a players output if they averaged 40PPG or 5PPG. 

The resulting distribution was as follows:

expected points = (1/10)*PPG*randomPoisson(Gamma = 10)

Steph Curry                       | Danny Green                      | Lu Dort                        |
:--------------------------------:|:--------------------------------:|:------------------------------:|
![StephScoring](https://user-images.githubusercontent.com/99698416/153977546-1c5b602a-d56d-4a79-b555-1d566ce3d0a2.png) | ![DANNYSCORING](https://user-images.githubusercontent.com/99698416/153977575-f2258be2-f010-4128-8dc9-ccf3e8fd1635.png) | ![LUSCORING](https://user-images.githubusercontent.com/99698416/153977585-b44c0f1c-edc5-4e61-b884-2de00f50c828.png)


## Standings   
<img src = https://user-images.githubusercontent.com/99698416/153977417-c682235d-1eaa-4fae-9c16-1a731894fe76.png width = "400" height = "650">  
PF = Points For  |  PA = Points Against  |  PD = Point Differential (PF-PA)  |  WAM  = Wins above .500

## Graphic Results  

Wins vs Points For|Wins vs Point Differential|  
:----------------:|:------------------------:|  
<img src = https://user-images.githubusercontent.com/99698416/153977493-17fd7fb2-08e3-493b-94b4-7c61a13b1e91.png width = "400" height = "400"> | <img src = https://user-images.githubusercontent.com/99698416/153977504-2b10611d-3bfd-4fdb-8edd-76ca3dcaa257.png width = "400" height = "400">
