```{r}
library(shiny)


# Run an app from a subdirectory in the repo
runGitHub("stat133-hws-fall17", "zhanyuanucb", subdir = "hw04/app")
```

### Comments and Reflection
1. This is the first time I wrote unit tests. _Scale of difficulty: 1_ 
2. This is first time I worked with **ggvis**. _Scale of difficulty: 4_
3. This is first time I worked with conditional panels in **shiny**. _Scale of difficulty: 4_
4. As far as I know (not so much, though), I prefer using **ggvis** when working with **shiny**, because it can separate the data computation process and the plotting process, especially when interactions are necessary.
5. In this homework, the most time-consuming part is figuring out the usage of conditional panel.
