select *

from {{ metrics.calculate(
    metric('gender_patient'),
    grain='year',
    dimensions=['gender']
) }}
