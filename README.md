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
  2. Put your source package in that directory (the `.dsc` and associated
     tarballs)
  3. Run `docker run -v $DIR:/usr/src quay.io/paperg/cleanroom
     /usr/src/YOUR-PACKAGE.dsc`

If all goes well, you should be left with `.deb` binary packages in `$DIR`.

The container will do this:

  1. Unpacks your source package with `dpkg-source -x`
  2. Installs the build dependencies with `mk-build-deps`
  3. Builds the binary package with `debuild -b -us -uc`

If you have several packages to build, you can pass each one as an argument.
