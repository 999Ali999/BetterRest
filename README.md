# BetterRest
This SwiftUI project is another forms-based app that will ask the user to enter information and convert that all into an alert, which might sound dull – you’ve done this already, right?

Well, yes, but practice is never a bad thing. However, the reason we have a fairly simple project is because I want to introduce you to one of the true power features of iOS development: machine learning (ML).

All iPhones come with a technology called Core ML built right in, which allows us to write code that makes predictions about new data based on previous data it has seen. We’ll start with some raw data, give that to our Mac as training data, then use the results to build an app able to make accurate estimates about new data – all on device, and with complete privacy for users.

The actual app we’re building is called BetterRest, and it’s designed to help coffee drinkers get a good night’s sleep by asking them three questions:

When do they want to wake up?
Roughly how many hours of sleep do they want?
How many cups of coffee do they drink per day?
Once we have those three values, we’ll feed them into Core ML to get a result telling us when they ought to go to bed. If you think about it, there are billions of possible answers – all the various wake times multiplied by all the number of sleep hours, multiplied again by the full range of coffee amounts.

That’s where machine learning comes in: using a technique called regression analysis we can ask the computer to come up with an algorithm able to represent all our data. This in turn allows it to apply the algorithm to fresh data it hasn’t seen before, and get accurate results.
