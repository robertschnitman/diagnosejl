# diagnoserjl
***Robert Schnitman***  
***2018-03-16***  
***Recommended Citation:  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Schnitman, Robert (2018). diagnoserjl v0.0.0.5. https://github.com/robertschnitman/diagnoserjl***

# Outline
0. Requisites/Recommendations and Package Imports
1. Introduction
2. diagnose()
3. fitres()
4. modeldf()
5. validate()

## 0. Julia Version and Package Imports
*Recommends*: Julia ≥ 0.6.2.

*Package imports*
  * Dataframes ≥ 0.10.1
  * Gadfly     ≥ 0.6.5
  * GLM        ≥ 0.8.1


## 1. Introduction
Based on the original R library, `diagnoser` (https://github.com/robertschnitman/diagnoser).

Motivation: make an equivalent package for Julia for pedagogical purposes and to take advantage of its capabilities.

## 2. diagnose()
```julia
file = "stata_auto.csv"
auto = readtable(file)

model_lm = fit(LinearModel, @formula(price ~ mpg + weight), auto)

diagnose(model_lm)
```
![](img/diagnose.png)

## 3. modeldf()

```julia
modeldf(model_lm, 0.95) # default confidence interval is 0.95.
```
|     |             |          |          |         |          |          |           |        | 
|-----|-------------|----------|----------|---------|----------|----------|-----------|--------| 
| Row | terms       | beta     | se       | moe     | ci_lower | ci_upper | t         | p      | 
| 1   | (Intercept) | 1946.07  | 3597.05  | 7172.31 | -5226.24 | 9118.38  | 0.541018  | 0.5902 | 
| 2   | mpg         | -49.5122 | 86.156   | 171.79  | -221.302 | 122.278  | -0.574681 | 0.5673 | 
| 3   | weight      | 1.74656  | 0.641354 | 1.27882 | 0.467736 | 3.02538  | 2.72324   | 0.0081 | 

## 4. fitres()

```julia
fitres(model_lm, true) # Outputs a dataframe. The default is "false", which returns an array.
```
|     |         |           |                  | 
|-----|---------|-----------|------------------| 
| Row |  fit    |  residual |  residual_margin | 
| 1   | 5974.22 | -1875.22  | -0.457482        | 
| 2   | 6955.33 | -2206.33  | -0.464589        | 
| 3   | 5467.72 | -1668.72  | -0.439251        | 
| 4   | 6632.14 | -1816.14  | -0.377106        | 
| 5   | 8329.35 | -502.347  | -0.0641813       | 
| 6   | 7464.72 | -1676.72  | -0.289689        | 
| 7   | 4553.58 | -100.578  | -0.0225865       | 
| 8   | 6684.54 | -1495.54  | -0.288213        | 
| 9   | 7930.52 | 2441.48   | 0.235391         | 
| 10  | 6943.64 | -2861.64  | -0.701038        | 
| 11  | 8815.5  | 2569.5    | 0.225692         | 
| …   |         |           |                  | 
| 63  | 3918.89 | 76.1108   | 0.0190515        | 
| 64  | 7226.13 | 5763.87   | 0.443716         | 
| 65  | 3854.95 | 40.0458   | 0.0102813        | 
| 66  | 3793.59 | 4.41278   | 0.00116187       | 
| 67  | 5264.06 | 634.944   | 0.107636         | 
| 68  | 4253.62 | -505.62   | -0.134904        | 
| 69  | 5718.16 | 0.838351  | 0.000146591      | 
| 70  | 4579.86 | 2560.14   | 0.358564         | 
| 71  | 3479.05 | 1917.95   | 0.355374         | 
| 72  | 4079.12 | 617.878   | 0.131547         | 
| 73  | 4183.92 | 2666.08   | 0.389209         | 
| 74  | 6640.95 | 5354.05   | 0.446357         | 

## 5. validate()

```julia
validate(model_lm, false) # By default, the output (dataframe = false) returns an array. 
                          # Set to "true" for a dataframe.
```

|                   |             | 
|-------------------|-------------| 
| :n                |  [74.0]     | 
|  :ar2             |  [0.273485] | 
|  :r2              |  [0.293389] | 
|  :rmse            |  [2462.54]  | 
|  :mae             |  [1966.89]  | 
|  :mpe             |  [-0.11274] | 
|  :residual_mean   |  [-0.0]     | 
|  :residual_median |  [-503.983] | 
|  :residual_sd     |  [2479.35]  | 
