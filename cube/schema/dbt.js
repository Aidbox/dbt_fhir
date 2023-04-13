import dbt from '@cubejs-backend/dbt-schema-extension';

asyncModule(async () => {
  await dbt.loadMetricCubesFromDbtProject('/dbt');
});
