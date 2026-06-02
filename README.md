# andersen

## Version requirements

**Always double-check that the version of eXist-db matches the configuration of the packages.** A mismatch (e.g. running eXist-db 7.x against packages built for 6.x) causes startup and module-loading errors that are hard to diagnose.

The supported local-development environment is the **Dev Container** in `.devcontainer/`, which
builds a self-contained image with eXist-db and all package dependencies baked in. Open the repo
in VS Code and choose "Reopen in Container".

Current pinned versions:

| Component | Required version | Where it is set |
|-----------|------------------|-----------------|
| eXist-db | **6.2.0** (not 7.x) | `.devcontainer/Dockerfile.dev` (`EXIST_VERSION`) |
| tei-publisher-lib | **4.0.0** (not 6.x) | `.devcontainer/Dockerfile.dev` (`PUBLISHER_LIB_VERSION`); `expath-pkg.xml` (`semver="4"`) |
| html-templating | 1.1.0 / semver 1 | `.devcontainer/Dockerfile.dev` (`TEMPLATING_VERSION`); `expath-pkg.xml` |
| roaster | 1.8.1 / semver 1 | `.devcontainer/Dockerfile.dev` (`ROUTER_VERSION`); `expath-pkg.xml` |

Do a similar version check for the other dependencies (tei-publisher libraries, html-templating, roaster) listed in `expath-pkg.xml` before deploying. When you bump any of these, update both `expath-pkg.xml` and the corresponding `*_VERSION` arg in `.devcontainer/Dockerfile.dev`, and confirm the eXist-db version still supports them.

## UPDATE

Caution: 

when updating to new TP versions make sure to port custom changes in `modules/lib/pages.xql` and `modules/lib/navigation.xql` which handle distribution of different layers into two-column system. This is connected to JS `extractTemplates` snippet in the `twocolumn.html` layout template.

