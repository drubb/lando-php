# lando-php
Extends the default Apache/PHP images of Lando, adding ImageMagick 7 and some
CLI tools. The resulting image will be stored in GitHub Container Registry
and rebuild periodically (GH actions workflow) to catch up upstream changes.

Branches represent different Lando base images, like `devwithlando/php:8.3-apache-5`.

To use this image, add it to overrides in .lando.yml:

```yaml
services:
  appserver:
    overrides:
      image: ghcr.io/arocom-gmbh/lando-php:8.3-apache-5
```
