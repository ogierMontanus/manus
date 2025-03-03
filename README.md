# manus
Live version see
https://hca.sdu.dk/manus/


## UPDATE
2025-03-03: Made public in version based on TEI-Publisher 9.
For a tour of the site in English, visit the YouTube-channel of the association e-editiones
https://www.youtube.com/@e-editiones8339
The app was built in TEI-Publisher, see teipublisher.com and https://github.com/eeditiones/tei-publisher-app




Caution: 

when updating to new TP versions make sure to port custom changes in `modules/lib/pages.xql` and `modules/lib/navigation.xql` which handle distribution of different layers into two-column system. This is connected to JS `extractTemplates` snippet in the `twocolumn.html` layout template.

