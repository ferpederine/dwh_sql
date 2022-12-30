# dwh_sql
Code Respository for Stored Procedures and Materialized Views for the DWH / DL Module

## Purpose
This repo contains two folders - one containing SQL relating to the stored procedures, and a second containing analytical and staging views created using Materliazed Views


## Project Structure

```
|--dwh_sql
    |--materialized_views\                          # All Materialized Views - Transforms and Load
        |--00_exploratory_data_analysis.sql         # A first MV to explore the data
        |--01_dim_author.sql                        # A list of article authors
        |--01_dim_date_loading.sql                  # A custom date dimension spanning many past centuries
        |--02_dim_institute.sql                     # Institutes Categorised
        |--03_dim_location.sql                      # Detailed location information with a natural geographic hierarchy
        |--04_dim_name.sql                          # Source dimension for article related data
        |--05_fact_institute.sql                    # Measure of how frequently insitutes are mentioned
        |--06_fact_location.sql                     # Measure of how often a location is mentioned
        |--07_fact_name.sql                         # Count of how many times an individual is named
        |--08_analysis_secret_council.sql           # The analytical view required to get an insight into the secret council
        |--09_analysis_geographic_analysis.sql      # The geographical footprint of people mentioned in the Lexicon
        |--10_analysis_influential_figures.sql      # A detailed view of influential figures
        |--11_network_analysis.sql                  # The network view of which articles mention which people

    |--stored_procedures\                           # Contains All SPROCs to Refresh MVs and load tables
        |--01_load_new.sql                          # Load any new article to the staging table
        |--02_update_existing.sql                   # Update any existing article 
        |--03_refresh_staging_mvs.sql               # Refresh the main staging table with new or updated articles
        |--04_dwh_data_cleaning.sql                 # Perform minor data cleaning
        |--05_dwh_update_dim_article.sql            # Update the dimensional data relating to the article
        |--06_dwh_update_fact_focal_point.sql       # Update the focal point fact table
        |--07_dwh_update_fact_influence.sql         # Update the influencer fact table
        |--08_dwh_update_fact_spread.sql            # Update the geographic spread fact table
        |--09_dwh_update_all_analytical_views.sql   # Refresh the main analytical views for Tableau

    |--visuals\                                     # Contains the Tableau Workbook file
        |--The Secret Council.twbx                  # The main Tableau workbook file
```