# chaco_snakes_functional_traits
Data and R scripts to analyze environmental filtering in snake assemblages from the Humid Chaco (Argentina) using a fourth-corner approach.

Functional trait, occurrence, and environmental coverage data for snake assemblages
Dataset DOI: [to be added after Zenodo deposition]
________________________________________
Overview
This repository contains the data and scripts used to assess environmental filtering in snake assemblages from the Humid Chaco ecoregion of Argentina. The dataset supports analyses of associations between species functional traits, environmental composition, and species occurrence across sampling sites using a fourth-corner approach.
________________________________________
Study area
Data were collected within the Humid Chaco ecoregion, a subtropical lowland floodplain characterized by strong hydrological seasonality and a heterogeneous mosaic of forests, grasslands, flooded habitats, and anthropogenic areas.
________________________________________
Repository structure
Data files
environmental_coverage_matrix.csv
•	Rows: grid cells (sampling units)
•	Columns: environmental categories
•	Values: proportional coverage per grid cell
Environmental categories:
•	Forests
•	Flooded forests
•	Grasslands
•	Flooded grasslands
•	Anthropogenic areas
________________________________________
presence_absence_matrix.csv
•	Rows: sampling sites
•	Columns: snake species (n = 48)
•	Values: 0 = absence, 1 = presence
________________________________________
traits.csv
•	Rows: snake species (n = 48)
•	Columns: functional traits
Traits include morphological, ecological, and reproductive variables:
•	VEN: ventral scales
•	SUB: subcaudal scales
•	TL: total length
•	TaL: tail length
•	SVL: snout–vent length
•	HL: head length
•	HW: head width
•	IO: interocular width
•	ED: eye–snout distance
•	C: mid-body circumference
•	Reprod: reproductive mode (categorical)
•	Habit: habitat use (categorical)
________________________________________
Code
FourthCorner_TraitWheel_scripts.R
This script performs:
•	Data preprocessing
•	Fourth-corner analysis
•	Trait–environment visualization
________________________________________
Reproducibility
Workflow
To reproduce the analyses:
1.	Load all data files
2.	Run FourthCorner_TraitWheel_scripts.R
________________________________________
Requirements
•	R (version 4.x recommended)
•	Required packages are listed within the script
________________________________________
Data sources
Environmental land-cover layers were obtained from the MapBiomas Project.
Raw georeferenced occurrence records are not publicly available due to institutional data privacy policies. However, all derived data necessary to reproduce the analyses are included in this repository.
________________________________________
Associated manuscript
Ulibarrie et al. (in review) – Biologia
________________________________________
License
[Add license here, e.g., CC-BY 4.0]
