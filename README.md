## Configuration

By default, there's an expectation that the app's `build.boot`
file defines `build` task that takes care of all sorts of build-time
concerns (e.g. pulling dependencies from repos eagerly). If a more
complicated logic is desired at build-time, it can be overriden by
specifying `BOOTBUILD_CMD` var that contains, say, a more complex boot
pipeline. For instance:

    BOOTBUILD_CMD="boot foo -x -- bar --blah -q -- qaz"

To expose more config vars at build-time, set a
`BOOTBUILD_CONFIG_WHITELIST` config var containing a space-delimited
list of config var names. Note that this can result in unpredictable
behaviour since changing your app's config does not result in a
rebuild of your app. So it's easy to get into a situation where your
build is broken, but you don't notice it until later when you
push. For this reason it's recommended to take care with this feature
and always push after changing a whitelisted config value.

## JDK version

This buildpack does not install the JDK. Instead, it uses the default JDK
on the Heroku Cedar stack, which is JDK 7. If you'd prefer to use JDK 8, you
can suplement this buildpack with the jvm-common buildpack by running these
commands:

```
$ heroku buildpacks:clear
$ heroku buildpacks:add https://github.com/heroku/heroku-buildpack-jvm-common
$ heroku buildpacks:add https://github.com/upworthy/heroku-buildpack-boot
```

## Testing

You can either test this buildpack locally with Docker, or run the tests on
Heroku. To use Heroku, create a new app with the testrunner buildpack, push the
buildpack code, and then run the tests:

```
$ heroku create --buildpack https://github.com/heroku/heroku-buildpack-testrunner
$ git push heroku master
$ heroku run tests
...
------
ALL OK
239 SECONDS
```

To test with Docker, first build the [testrunner image](https://github.com/heroku/heroku-buildpack-testrunner)
and then run the `test.sh` script.

## Credits

Thanks to the authors of various official Heroku buildpacks for
providing excellent documentation and clearly written source code. In
particular, config var whitelisting has been inspired by
[Clojure buildpack.][1]

[1]: https://github.com/heroku/heroku-buildpack-clojure#configuration
