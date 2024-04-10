# Attendence Recorder
In this project I am experimenting Flutter and its common packages.<br>
This app helps to fill a google sheet to record attendence or attendance tracking.<br>
the first column contains 'date' and the day of the lecture, and each other column represents a student's name and the time at which he entered the lecture.

## To run this project you need
### 1. a google clound account and a google sheet api key 
These are required to access the sheet
### 2. in you clone, create Credentials.dart in sheetUtils directory
It should have these constants:
```dart
final String credentials = r''''''.trim();

const spreadSheetId = "spread sheet Id";

const serviceEmail = "your service email from google sheet api";
```
You can follow [this](https://www.youtube.com/watch?v=3UJ6RnWTGIY&t=831s) video to finish setup

## Used tools:
**intl:** for dateTime formatting.<br>
**gsheet:** a high level of google sheet api. <br>
**hive:** shared prefrences.<br>
**provider:** state managment. <br>
**get it:** for dependency injection.<br>
