# DE1_project2
Done by: Ghadena Hgaig, Karoly Takacs, Eniko Palko and Russu_Anastasiia

Data Engineering 1: Project 2  
Analysing the Impact of Healthcare Spending on Life Expectancy Across Regions and Spending Types 

Overview 
The project integrates data on healthcare spending and life expectancy across OECD countries over the span of 15 years, preparing data for the further exploration of the relationship between healthcare-related expenditure and health outcomes of the general population. Using an automated ETL pipeline in Knime, data was transformed through multiple processes: 
 
- Data sourcing: Country and Spending Datasets were obtained from the World Bank, complemented by data on life expectancy from the OECD Data API. These datasets provided comprehensive coverage of selected countries and years. These sources are highly reliable, and the data is fit for the topic of analysis.  
- Data preparation: Raw data was cleaned in python, selecting metrics of choice as well as handling duplication and missing data.  
- Data integration: The cleaned datasets were integrated into relational tables and stored in MySQL, enabling efficient querying and analysis. The Knime workflow combined data from MySQL with the OECD API, and created visualisations form the data.  
Technical Choices 
- Data Processing: Python was chosen for initial data cleaning, for its versatility in data processing and file management. Type conversions were utilized to ensure compatibility with statistical analysis. Missing values were handled with NaN and errors were handled with errors=’coerce’ function. Value counts ensured consistency in observations. 

