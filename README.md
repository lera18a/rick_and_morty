# rick_and_morty
This project is a starting point for a Flutter application.

## API
```
https://rickandmortyapi.com/api
```

## Getting Started
## The first step 
```
flutter pub get
```
## The second

Running the code generator
Once you have added the annotations to your code you then need to run the code generator to generate the missing .g.dart generated dart files.
*Run in the package directory.*
```
flutter pub run build_runner build --delete-conflicting-outputs
``` 
## The third 
```
flutter run --dart-define=host=https://rickandmortyapi.com/api
```

