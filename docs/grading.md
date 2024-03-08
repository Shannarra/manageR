# Grades and grading

In order to resolve the problem with grades for different counties, the following structure was organized:

1. An institution **must** adhere to specific _grading system_, guiding the way grading is done for its classes, exams and subjects.
2. A grading system is defined as a collection of the following attributes:

Attribute | Meaning
--- | --- |
**name** | The name of the system, any does |
**start_grade** | The starting grade (lowest when looking at grades linearly)  |
**end_grade** | The end grade (highest when looking at grades linearly) |
**step** | The step between grades, usually is 1 but can be custom for specific cases (see [danish grading system](https://www.norden.org/en/info-norden/grading-scale-danish-education-system#:~:text=All%20Danish%20educational%20programmes%20from,The%20lowest%20grade%20is%20%2D3.)) |
**direction** | One of the system directions listed below |
**description** | Just a helper description, similar to name |
**possible_grades** | Usually auto-generated before saving the GradingSystem unless it's a non-linear one, in which case you will need to input the values as a comma-separated string |

### system directions
```
 nonlinear: 3, # e.g. Danish system
 positive: 2,  # 2..6 -> + (Eastern Europe)
 negative: 1,  # 5..1 -> - (Central Europe)
 unknown: 0
```

3. Institutions clamp on the possible grades (when grading exam/user) depending on the related GradingSystem.
4. Grading - __TBD__
