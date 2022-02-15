# NBA-Season-Simiulation
Simulation of the 2020-2021 NBA Season

The goal of my project was to write a program that would simulate a whole season of NBA games. The two datasets required to run this program are the following: a schedule dataset containing all games played during the regular season and a dataset containing player data (necessary variables: name, team, and PPG).

In order to predict the outcome of an induvial game I needed a way to predict the points scored by each player on a team. To do this I used trial and error to find distribution that matched the scoring output for a few different players. 

The resulting distribution was as follows:

expected points = (1/10)*PPG*randomPoisson(Gamma = 10)
![image](https://anomaly.io/wp-content/uploads/2015/06/poisson-formula.png)


