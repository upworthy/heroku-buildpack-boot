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
