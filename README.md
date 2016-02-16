debuildd
========

dbuildd is a daemon that waits for Debian source packages then builds them.
It's like [buildd](https://buildd.debian.org/), but maybe more modern and can be
deployed without
[pages and pages of instructions](https://wiki.debian.org/BuilddSetup). The "d"
is for Docker, get it? Unfortunately it hasn't been implemented yet.

cleanroom is the Docker image dbuildd uses to do the building. It's an
alternative to tools like [pbuilder](http://pbuilder.alioth.debian.org/) for
people who prefer Docker over chroots or LVM. This part is implemented so you
can use it.

Suggested usage:

  1. Create an otherwise empty directory. We'll call it `$DIR`.
  2. Put the thing you want to build in that directory. The thing can be a
     source package and associated tarballs, or an already unpacked source tree.
  3. Run something like

    docker run -v $DIR:/usr/src quay.io/paperg/cleanroom cleanroom /usr/src/YOUR-PACKAGE.dsc

or

    docker run -v $DIR:/usr/src quay.io/paperg/cleanroom cleanroom /usr/src/YOUR-SOURCE-TREE

If all goes well, you should be left with `.deb` binary packages in `$DIR`.

The container runs a shell script (`cleanroom`) that does this:

  1. If the thing being buildt is a source package, unpack it with
     `dpkg-source -x`
  2. Install the build dependencies with `mk-build-deps`
  3. Build the binary package(s) with `debuild -b -us -uc`

If you have several packages to build, just add them as arguments:

    docker run -v $DIR:/usr/src quay.io/paperg/cleanroom \
    /usr/src/SOME-PACKAGE.dsc \
    /usr/src/ANOTHER-PACKAGE.dsc \
    /usr/src/GREAT-PROGRAM/

If the shell script doesn't do exactly what you need, you can override the
container's entrypoint with `docker run --entrypoint ...` and do your own thing.
You'll find the basic Debian development tools already installed.

testing
-------

There's a shell script `test` which runs a trivial Debian package through
cleanroom. You'll need `dpkg-dev` installed (to build a source package) and
you'll need to be able to `sudo` (to clean up the files made by the Docker
container, which are created as root). You'll also need Docker, of course.
