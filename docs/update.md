# Update pygmy

As `pygmy` is released regularly you should also take care of updating pygmy.

As ruby gems does not remove old versions of gems when updating, you should remove old version after a new version has been installed.

First update:

    gem update pygmy

    Updating installed gems
    Updating pygmy
    Successfully installed pygmy-0.9.4
    Parsing documentation for pygmy-0.9.4
    Installing ri documentation for pygmy-0.9.4
    Installing darkfish documentation for pygmy-0.9.4
    Done installing documentation for pygmy after 0 seconds
    Parsing documentation for pygmy-0.9.4
    Done installing documentation for pygmy after 0 seconds
    Gems updated: pygmy

A new version!

Now uninstall the old one:

    gem uninstall pygmy

    Select gem to uninstall:
     1. pygmy-0.9.3
     2. pygmy-0.9.4
     3. All versions
    > 1
    Successfully uninstalled pygmy-0.9.3

check the correct version:

    pygmy -v

    Pygmy - Version: 0.9.4


## Update Docker Containers with `pygmy`

`pygmy` can update shared docker containers for you:

    pygmy update

After it updated all containers, it will recreate them as well.


