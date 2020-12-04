# reproducible workshop

Version 0.1
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/vetpsk/workshop_cc/master)

Project containing example code and dummy data for reproducible code workshop. Various commits with improvement in the code are attempted in this workshop.

## The example
Objective: Developing a modeling strategy for predicting number of culled dairy cows based on associated covariates.

### General Background
On average, 25-30% of Dutch dairy cows are replaced annually by young heifers to maximize the economic output of the dairy farms. The dairy cow replacement problem has been extensively studied in the past with respect to economic benefit. But nowadays, new goals in terms of environmental sustainability and better welfare for animals are important to consider. The main aim of this project is to identify and analyse the herd characteristics associated with culling decisions in dairy cattle.

<p align="right">
  <img src="https://www.openaccess.nl/sites/www.openaccess.nl/files/documenten/open-access-logo-png-transparent.png" width="300px" alt="logo" />
  <br><b>Experiment to add image</b>
</p>

## Project organization


```
.
├── .gitignore
├── CITATION.md
├── LICENSE.md
├── README.md
├── requirements.txt
├── bin                <- Compiled and external code, ignored by git (PG)
│   └── external       <- Any external source code, ignored by git (RO)
├── config             <- Configuration files (HW)
├── data               <- All project data, ignored by git
│   ├── processed      <- The final, canonical data sets for modeling. (PG)
│   ├── raw            <- The original, immutable data dump. (RO)
│   └── temp           <- Intermediate data that has been transformed. (PG)
├── docs               <- Documentation notebook for users (HW)
│   ├── manuscript     <- Manuscript source, e.g., LaTeX, Markdown, etc. (HW)
│   └── reports        <- Other project reports and notebooks (e.g. Jupyter, .Rmd) (HW)
├── results
│   ├── figures        <- Figures for the manuscript or reports (PG)
│   └── output         <- Other output for the manuscript or reports (PG)
└── src                <- Source code for this project (HW)
└── workshop_cc.Rproj  <- R-project file 
```
## Dependencies and session info
For more information, please view [dependencies](./config/Dependencies)

## License

This project is licensed under the terms of the [MIT License](/LICENSE.md)

## Citation

Please [cite this project as described here](/CITATION.md).
