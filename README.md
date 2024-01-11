# MSDyn365BC.Ntfy

This app is a wrapper around https://ntfy.sh - an open source notification service.

The goal of this app is to let users setup notification for various "events" in Buisness Central, notifying them, when the action is finished.

Example:
You schedule a number of invoices for background posting and want to know when it finished. 
Just setup a notification and you will get a push notification to your phone.

Another example:
You have a report that you need to print out every week but it takes 15 minutes to render.
Setup a notification so you know when you need to finish your coffee break ;)

## How to

Go to https://ntfy.sh/ on open the the web app:

![image](https://github.com/StefanMaron/MSDyn365BC.Ntfy/assets/24838311/2185bc0f-92fd-46b2-b02c-5497ed86d6dc)

Then 1. click on Subscribe topic, 2. generate a new name and 3. copy that name and 4. finish with a click on Subscribe

![image](https://github.com/StefanMaron/MSDyn365BC.Ntfy/assets/24838311/726ea2eb-8da7-41a1-87a1-89c7452ebe9b)

Back in BC, after you installed the extension. You can grab it from Github from the artifacts or clone the repo and compile it yourself.
You need to add the topic. Search for Ntfy Topic, click new and insert the code you copied before.

![image](https://github.com/StefanMaron/MSDyn365BC.Ntfy/assets/24838311/aee9851e-d905-4e60-b2bc-ef02c86d2b43)

Then go to Ntfy Entry and create a new row, select the Topic and the event you want to receive notifications for

![image](https://github.com/StefanMaron/MSDyn365BC.Ntfy/assets/24838311/26481f39-4cef-4239-991d-9ddba03d067e)

Close all the pages and release a Sales order. You should get the notification in the Ntfy web app.
![image](https://github.com/StefanMaron/MSDyn365BC.Ntfy/assets/24838311/24f934ef-95bd-4f22-a4df-e560d7ecec20)

Of course you can achieve the same thing with the mobile app.
https://docs.ntfy.sh/subscribe/phone/
