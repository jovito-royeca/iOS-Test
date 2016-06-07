# iOS-Test


**The list of offers.**

Implement the  screen of a "journeys offers " section for the GoEuro iPhone App.!
The application consists of 1 view  where results are grouped according to their transport mode.

! For this view, there’s no specific design to implement but the list has to be easily readable for the
user and should display the following :

3 tabs each represents one search mode results (one for train , one for busses and one for flights) , in each results list a group of cells representing each a different travel option is presented , you are free to use whatever api you wish or design you think it fits best , but make sure to include for each journey the following data :

 - logo
 - departure time
 - arrival time
 - number of stops 
 - price 
 - duration

if there is no data available in the returned json file then find how you can make a proper calculation to it

 lists of travel options  can be requested through a *JSON API* invocation,when displayed  they should be ordered by departure time. options to order through arrival time or duration should also be available. Tapping an "offer" button should display a "Offer details is not yet implemented" message to the user.

the end points are :

 - https://api.myjson.com/bins/w60i   for  flights 
 - https://api.myjson.com/bins/3zmcy  for trains 
 - https://api.myjson.com/bins/37yzm  buses

for image sizes , please keep it 63 for example :
  http://cdn-goeuro.com/static_content/web/logos/63/megabus.png


implement your solution as an App that we can try out. should be comptaible starting from iOS 8 . Also send us the source code to your solution. We use GitHub, so if you put your source code into a GitHub repository, it will make our life easy.

Please provide information for any third party library and tool you are using and use Objective-C as the main language 

  
<u>Bonus points :</u>

Show us how you can adapt it to different screen sizes
Can you use Objective-C and SWIFT together? show us a sample
A clean, well-animated, beautiful UI is very important. Please, let your imagination fly here (hint, use more than standard animations).

**Hint** 

You may use the following design as a reference , however you are totally free to use your creativtiy and imagination


