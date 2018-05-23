```{r}
library(shiny)


# Run an app from a subdirectory in the repo
runGitHub("zhanyuan_github", "ucbzhanyuan", subdir = "grade-visualizer/app")
```

### Comments and Reflection
1. This is the first time I wrote unit tests. 
2. This is first time I worked with **ggvis**.
3. This is first time I worked with conditional panels in **shiny**.
4. As far as I know (not so much, though), I prefer using **ggvis** when working with **shiny**, because it can separate the data computation process and the plotting process, especially when interactions are necessary.

