2. Title and Brief description of experiment:
Title: Benchmarking parallelism in matrix multiplication
Description: In a reference matrix multiplication algorithm multiplying two square matrices, we are going to observe the time it takes to perform the operation as a parallelizable script. We will vary the size of the input matrices and the number of threads on the script’s runtime.
3. The response variable is time and is measured in units of seconds.
4. Factors: (At least one factor must have quantitative levels)
Factor 1 is: Size of the input matrix 
Its levels are: 500000, 1000000, 2000000, 5000000
In the data file we will use levels: 5.699, 6.0, 6.301, 6.699 
In recording each datum, we will use log10(size) for the size levels so that the factor levels are more appropriately spaced for mplot and rplot.
Factor 2 is: The number of threads utilized in the benchmark
Its levels are: 2, 3, 4, 6
What is your "experimental unit"? How many experimental units will be needed to run your experiment?
Each individual run of the computer program is our experimental unit. To run our experiment, we will utilize 4 * 4 * 6 = 96 experimental units.

Draw the DESIGN MATRIX and indicate the random order that the trails will be run


Factor 2: Number of threads
2
3
4
6
Factor 1:
Input matrix size
5E5
(10^5.699)
63, 81, 29, 30, 33, 53
47, 51, 64, 59, 65, 36
46, 69, 34, 21, 54, 16
75, 10, 13, 27, 6, 72
1E6
19, 70, 50, 61, 44, 40
87, 76, 9, 11, 96, 43
26, 83, 93, 78, 28, 90
3, 18, 82, 42, 73, 56
2E6
(10^6.301)
95, 41, 15, 12, 71, 80
92, 55, 38, 48, 68, 85
49, 79, 66, 74, 84, 91
58, 57, 88, 94, 22, 23
5E6
(10^6.699)
5, 86, 39, 25, 14, 7
31, 77, 37, 24, 4, 2
62, 45, 35, 52, 17, 67
1, 20, 89, 32, 60, 8


Generated using rand(‘state’, 181141)
5. How will randomization and replication be used?
Randomization: By the instructions above, we are going to select a random order for each of the benchmarks to avoid random factors like uncontrollable background system load and thermal conditions. We generate this using the MatLab “sample” function.
Replication: We repeat each benchmark 6 times.
