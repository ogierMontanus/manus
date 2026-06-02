# andersen

## Version requirements

**Always double-check that the version of eXist-db matches the configuration of the packages.** A mismatch (e.g. running eXist-db 7.x against packages built for 6.x) causes startup and module-loading errors that are hard to diagnose.

Current pinned versions:

| Component | Required version | Where it is set |
|-----------|------------------|-----------------|
| eXist-db | **6.2.0** (not 7.x) | `manus.code-workspace` → "Start eXist-db" task (`existdb/existdb:6.2.0` docker tag) |
| tei-publisher-lib | **4.0.4** (not 6.x) | `expath-pkg.xml` (`semver="4.0.4"`) and "Install tei-publisher-lib 4.0.4" task |
| html-templating | semver 1 | `expath-pkg.xml` |
| roaster | semver 1 | `expath-pkg.xml` |

Do a similar version check for the other dependencies (tei-publisher libraries, html-templating, roaster) listed in `expath-pkg.xml` before deploying. When you bump any of these, update both `expath-pkg.xml` and the corresponding deploy task in `manus.code-workspace`, and confirm the eXist-db version still supports them.

## UPDATE

Caution: 

when updating to new TP versions make sure to port custom changes in `modules/lib/pages.xql` and `modules/lib/navigation.xql` which handle distribution of different layers into two-column system. This is connected to JS `extractTemplates` snippet in the `twocolumn.html` layout template.

