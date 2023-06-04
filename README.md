# Burp Suite

Burp Suite is an integrated platform for performing security testing of web applications. Its various tools work seamlessly together to support the entire testing process, from initial mapping and analysis of an application’s attack surface, through to finding and exploiting security vulnerabilities.

Burp gives you full control, letting you combine advanced manual techniques with state-of-the-art automation, to make your work faster, more effective, and more fun.

portswigger.net

![burpsuite logo](https://i.ibb.co/cvvB9qJ/burpsuite.png)

## How to use this Makejail

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/burpsuite

ARG ruleset=0

OPTION template=files/linux.conf
OPTION devfs_ruleset=${ruleset}
# Recommended
OPTION tmpdir
# But this works fine without sharing /tmp
#OPTION x11
```

Where `options/network.makejail` are the options that suit your environment, for example:

```
ARG network
ARG interface=appjail0

OPTION alias=${interface}
OPTION virtualnet=${network} default
OPTION nat
```

In the above example `appjail0` is a loopback interface, so it must first exist before creating the jail.

The `files/linux.conf` template is as follows:

```
exec.start: /bin/true
exec.stop: /bin/true
persist
enforce_statfs: 1
```

Open a shell and run `appjail makejail` and `appjail start`:

```sh
appjail makejail -j burpsuite -- --network development --ruleset 11
appjail start burpsuite
```

Your ruleset must unhide `shm` and `shm/*`.

After Makejail builds the jail, you can run Burp Suite using the `burpsuite_open` custom stage:

```sh
appjail run -s burpsuite_open burpsuite
```

<p align="center">
    <img src="https://i.imgur.com/yl645zm.png" />
</p>

## Notes

1. This Makejail uses [Debian](https://github.com/AppJail-makejails/debian).

## Bugs

1. When clicking in `Open Browser` the error `Cannot invoke "net.portswigger.browser.Ze3.ZM()" because "this.ZO" is null` is displayed.
2. Burp's browser cannot be used.

If you fix them, feel free to send a pull request.
