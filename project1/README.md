# ML Project 1


The project is to implement conjugate estimators for the following scenarios:

Binomial, gaussian with known variance (i.e. estimate the mean), and gaussian with known mean (i.e. estimate the variance)

You should plot the mean squared error both the ML and conjugate prior estimates, all on one plot, with a legend. For each scenario, choose 2-3 different values for the hyper parameters. 

Additionally, for at least one set of hyperparameter per scenario, plot the posterior density as it changes with observations. The easy way to do this is to just plot the pdf a few times, for different #s of observations. If you want to get fancy, make a movie/animation.

You can do this in python or MATLAB. 


Simple example:

Generate 10 observations from a normal density.

Compute the ML estimate for 1,2,3....10 observations. As you get more observations, you should get closer to the correct value. With each estimate 1....10, you can compute a single squared error value. So you will have 10 values for squared error on that sequence of observations. Save those squared errors.

Then, iterate over this. Do it several times. Generate a new sequence of 10 observations, and compute a new set of 10 estimates, and the corresponding squared error at each observation. Save the squared error values.

After you've built a matrix of many iterations, each with a squared error value for each # of observations, take the mean of that, so that you have the average squared error for each # of observations.

If you do this correctly, both your ML and conjugate prior plots of the MSE will be smooth.
