# iOS-Test

The purpose of this test is to see how you approach a problem and what your solutions look like. The requirements for this test are simple and should be straightforward to grasp. When implementing a solution, please keep things simple as well. That said:

**Implement Travel Options list**

You have a 3 tabs each represents one search mode results , in each results list a group of cells representing each a different travel option is presented , you are free to use whatever api you wish or design you think it fits best , but make sure to include for each travel option the following data :

 - logo
 - departure time
 - arrival time
 - number of stops 
 - price 
 - duration

when there is no data available in the returned json then find how you can make a proper calculation to it

 lists of travel options  can be requested through a *JSON API* invocation,when displayed  they should be ordered by departure time. options to order through arrival time or duration should also be available. Tapping an "offer" button should display a "Offer details is not yet implemented" message to the user.



the end points are :

 - https://api.myjson.com/bins/w60i   for  flights 
 - https://api.myjson.com/bins/3zmcy  for trains 
 - https://api.myjson.com/bins/37yzm  buses
 


Your solution

Please implement your solution as an App that we can try out. starting with iOS 8 compatibility. Also send us the source code to your solution. We use GitHub, so if you put your source code into a GitHub repository, it will make our life easy.
Please provide information for any third party library and tool you are using. Please use Objective-C as the main language 

  the size for the image keep it 63 for example :
  http://cdn-goeuro.com/static_content/web/logos/63/megabus.png
  
<u>Bonus points :</u>

Show us how you can adapt it to different screen sizes
Can you use Objective-C and SWIFT together? show us a sample
A clean, well-animated, beautiful UI is very important. Please, let your imagination fly here (hint, use more than standard animations).

**Hint** 

You may use the current live app seach results page for GoEuro as a reference
