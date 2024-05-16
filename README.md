# FinalProject
Final Project for PubH-7462
FinalGuidelines:

  1) Team Members:
  
    Brandon Payne and Emmanuel Chea

  2) Product title: 

    India Sales (Diwali Sales Data)
  
  3) Product type:
  
    Report using Shiny app
  
  4) Product purpose:
  
    Query data "instantly" from a web page, graphicly create charts from data
  
  5) What data source(s): 
  
    tidytuesday https://github.com/rfordatascience/tidytuesday/tree/master/data/2023/2023-11-14
  
  6) Product features: What are the main elements of your data product (tables, plots, etc.)?
  What questions will they answer and how will they provide insight into your data?:
  
    1. Differences between state sales by categories.
    2. Overall raw profit, Make a slider or something similar to show Max/Min.
    3. See differences in sales by age.
    4. Regional differences in sales or volume.
    5. See which customers are buying the most and their background/demographics.
    6. .....
  
  7) Automation [if applicable]: How will you automate the creation and deployment of your
  data product? What event(s) will trigger updates?:
  
    Update to pull most recent data, default run pre-specified script for easy use
  
  8) Interactivity [if applicable]: What are the main functions/actions that the app will allow
  the user to do? Plots and regression, to data wrangle
  
    Allow the creation of regression based on any groupings, plots generalized outputs based on parameters
  
  9) Programming challenges: What are the main programming challenges that you anticipate
  facing in implementing your data product? 
    
    Biggest problem will be the Shiny aspect. Plots and functions can be prespecfied and planned ahead.
  
  10) Division of labor: How will your team collaborate to complete the project? Will each
  person be responsible for a particular set of features, or will team members work together
  on the entire codebase? If you are working alone this part will, of course, be trivial.
  Note that the first four items will form the basis for the data product documentation that you will
  provide with the final submitted version.
  
    Make a few functions that need to be implemented and their general "outputs" to be divided per person (or created on demand by each person), main part of the shiny app will be done by brandon functions and checking implementation will be done by emmanuel
    
  11) Future work: If you had time, what additional features would you like to implement in your app?

    Future work could include a more robust approach the interactivity of the of the dropdowns for the variables that are chosen for each of the plots, graphs, and tables. As of right now the dropdowns will let use choose variables that do not exist within the same groups.
  
  The data product proposal will be graded on its completeness (10 points), clarity (10 points), and
  originality (5 points). We will aim to provide feedback on your app concept by Friday, April 5
