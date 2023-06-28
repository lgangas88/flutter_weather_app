
# Project Title

A flutter project where you can get the current weather and some news about the selected city.




## Features

 - The app has an architecture very simple but at the same time very powerful for a small project like this. There are 3 main layers (ui, models, services) that encapsulate their own approach.
 - A home page listing all the news related to the selected city. Once you start scrolling new requests will be called and added to the list.
 - In the appbar some information about the weather of the selected city will be displayed. The temperature is on the metric system and the weather icon is according the response.
 - The home page has a FAB that shows a bottom dialog with some main cities around the world. Once you tap on a city, the news and the weather will change according the city.
 - To know more about a city, tap on any new in the list and it will take you to a detail page. More info will be displayed as well as the publication date and source.


## To consider

- The dio package is being used to make the http calls. As there are two apis to consume, there are two instances of the dio class, one of each managing their own env variables.
- Packages like json_serializable and freezed were considered, but they are not essential for this type of projects in terms of size.
- The .env file is not in the .gitignore file because of facility purposes (it should be).

