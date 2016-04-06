# Has Coverage of Online Harassment Grown Since 2014?

In this analysis, I use data from MediaCloud.org to test the hypothesis that coverage of online harassment grew from Jan 1, 2014 to March 31, 2016.

## Data Collection
Data was collected by searching the repository at MediaCloud.org for all sentences matching the following search query:

    “online harassment,”  “cyberbullying,” “online abuse,” “revenge porn,” 
    “cyberstalking,” “online hate speech,” and “online racism”

The dataset included 24 US media sources, 95 UK media sources, and 1065 blogs and digital first media sources.

## Analysis
This analysis uses a negative binomial model to test the null hypothesis that there is no relationship between the month since Jan 1 2014 and the number of sentences per region about online harassment in a given week. For more on count models, see:

    Long, J. Scott. 1997. Regression Models for Categorical and Limited Dependent Variables. 1 edition. Thousand Oaks: SAGE Publications, Inc.

## Results
The following R code was executed (see the attached R script).

    nb1 <- glm.nb(Total.Media ~ monthnum, data = weeks)
    nb2 <- glm.nb(UK.Media ~ monthnum, data = weeks)
    nb3 <- glm.nb(US.Media ~ monthnum, data = weeks)
    nb4 <- glm.nb(Digital.Media ~ monthnum, data = weeks)
    
    stargazer(nb1,nb2,nb3,nb4, type="text")

Model Results:

    =====================================================================================
                                              Dependent variable:                        
                      -------------------------------------------------------------------
                        Total.Media        UK.Media         US.Media      Digital.Media  
                            (1)              (2)              (3)              (4)       
    -------------------------------------------------------------------------------------
    monthnum              0.032***         0.039***         0.020***         0.036***    
                          (0.006)          (0.007)          (0.006)          (0.007)     
                                                                                         
    Constant              4.898***         3.389***         3.864***         4.054***    
                          (0.090)          (0.111)          (0.096)          (0.106)     
                                                                                         
    -------------------------------------------------------------------------------------
    Observations            117              117              117              117       
    Log Likelihood        -696.264         -549.946         -563.244         -619.492    
    theta             4.314*** (0.556) 2.935*** (0.395) 3.919*** (0.527) 3.125*** (0.402)
    Akaike Inf. Crit.    1,396.528        1,103.893        1,130.487        1,242.985    
    =====================================================================================
    Note:                                                     *p<0.1; **p<0.05; ***p<0.01
    

When interpreting these results, remember that the incidence rate ratio is calculated with `exp(beta)`. For example, in the case of UK media, the coefficient of monthnum is 0.039, which means that the incidence rate ratio is 1.039. The final interpretation is that from month to month, the number of sentences about online harassment in UK media increased by a rate of 3.9% on average between Jan 1 2014 and Jan 2016, a relationship that is statistically significant.

Note also that this research makes no claims about the number of stories, or whether online harassment is growing. It is also possible that these findings reflect a change in the terms used to describe certain things rather than a change in the incidence of the underlying issues being described. I have attempted to account for this by using terms like cyberbullying and cyberstalking, which have a longer history.
