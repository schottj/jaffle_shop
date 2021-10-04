with env_var as (
    select 
        '{{env_var("DBT_CLOUD_RUN_ID", "DEV")}}' as run_id,
        '{{env_var("DBT_ENVIRONMENT")}}' as environment
    
)

Select * from env_var
